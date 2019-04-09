#!/bin/bash
#===============================================================================
#
#         FILE:  entrypoint.sh
#
#        USAGE:  entrypoint.sh
#
#  DESCRIPTION:  This script is called at the start of the image.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  John van Zantvoort, John@------------.org
#      COMPANY:  none
#      CREATED:  18-Jul-2017
#
# Copyright (C) 2019 John van Zantvoort
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#===============================================================================
declare -r CONST_SCRIPTPATH="$(readlink -f $0)"
declare -r CONST_SCRIPTNAME="$(basename $CONST_SCRIPTPATH .sh)"
declare -r CONST_SCRIPTDIR="$(dirname $CONST_SCRIPTPATH)"
declare -r CONST_DOCTREE="/output/tmp/doctrees"
declare -r CONST_OUTPUTBASEDIR="/output"
declare -r CONST_CODEBASEDIR="/code"
declare -r CONST_SBCMDDIR="/usr/sbcmd/bin"
declare -r CONST_LOGFILE="${CONST_OUTPUTBASEDIR}/logging.txt"

eval $( fixuid )

# logging functions {{{
function logging()
{
  local priority="$1"; shift
  printf "%s [%s] %s\n" "$CONST_SCRIPTNAME" "${priority}" "$@" | \
    tee -a ${CONST_LOGFILE}
}

function logging_err()
{
  logging "err" "$@"
}

function logging_info()
{
  logging "info" "$@"
}

function script_exit()
{
  local STRING="$1"
  local RETV="${2:-0}"
  if [ "$RETV" = "0" ]
  then
    logging_info "$STRING"
  else
    logging_err "$STRING"
  fi
  exit $RETV
}

# }}}

# function isabs {{{
function isabs()
{
  local path=$1; shift
  echo "$path" | grep -q "^/"
  RETV=$?
  [[ "$RETV" = "0" ]] && return 0 || return 1
}
# }}}

# function print_help {{{
function print_help()
{
  HELP_COMMAND=""
  HELP_COMMAND="${HELP_COMMAND} docker run --rm -v  \$PWD:/code"
  HELP_COMMAND="${HELP_COMMAND} --mount type=tmpfs,destination=/webroot"
  HELP_COMMAND="${HELP_COMMAND} -i sbcmd/prod:1"

  echo "  ${HELP_COMMAND}"
  exit 1


}
# }}}

# function find_builder {{{
function find_builder()
{
  local SW_ACTION=$1; shift

  if [ -x "${CONST_CODEBASEDIR}/${SW_ACTION}" ]
  then
    echo "${CONST_CODEBASEDIR}/${SW_ACTION}"
    return 0
  fi

  if [ -x "${CONST_CODEBASEDIR}/${SW_ACTION}_build" ]
  then
    echo "${CONST_CODEBASEDIR}/${SW_ACTION}_build"
    return 0
  fi

  if [ -x "${CONST_SCRIPTDIR}/${SW_ACTION}" ]
  then
    echo "${CONST_SCRIPTDIR}/${SW_ACTION}"
    return 0
  fi

  if [ -x "${CONST_SCRIPTDIR}/${SW_ACTION}_build" ]
  then
    echo "${CONST_SCRIPTDIR}/${SW_ACTION}_build"
    return 0
  fi

  if [ -x "${CONST_SBCMDDIR}/${SW_ACTION}" ]
  then
    echo "${CONST_SBCMDDIR}/${SW_ACTION}"
    return 0
  fi

  if [ -x "${CONST_SBCMDDIR}/${SW_ACTION}_build" ]
  then
    echo "${CONST_SBCMDDIR}/${SW_ACTION}_build"
    return 0
  fi

  print_help "E_NOSUCHFILE"
}
# }}}

#------------------------------------------------------------------------------#
#                                    Main                                      #
#------------------------------------------------------------------------------#
logging_info "start"


SW_ACTION=$1; shift
SW_SRCDIR=""
SW_DSTDIR=""
SW_UID="0"
SW_GID="0"
SW_ARCH="no"

# help
# --------------------------------------
[[ "${SW_ACTION}" = "help" ]] && print_help "usage"
[[ -z "${SW_ACTION}" ]] && print_help "usage"

# no such command
# --------------------------------------
COMMAND=$(find_builder "${SW_ACTION}")

# set case based defaults
# --------------------------------------
case "${SW_ACTION}" in
  sphinx) SW_SRCDIR="sphinxdoc"
          SW_DSTDIR="html";;
  ablog) SW_SRCDIR=""
         SW_DSTDIR="website";;
esac

# extract certain arguments
# --------------------------------------
for arg_item in "$@"
do
  case $arg_item in
    srcdir=*) SW_SRCDIR="${arg_item#*=}";        shift;;
    dstdir=*) SW_DSTDIR="${arg_item#*=}";        shift;;
    archive=*) SW_ARCH="${arg_item#*=}";        shift;;
    uid=*)    SW_UID="${arg_item#*=}";           shift;;
    gid=*)    SW_GID="${arg_item#*=}";           shift;;
    *)        ARGS=("${ARGS[@]}" "${arg_item}"); shift;;
  esac
done

# make relative path absolute
# --------------------------------------
isabs "${SW_SRCDIR}" || SW_SRCDIR="${CONST_CODEBASEDIR}/${SW_SRCDIR}"
isabs "${SW_DSTDIR}" || SW_DSTDIR="${CONST_OUTPUTBASEDIR}/${SW_DSTDIR}"

# COMMAND
# --------------------------------------

[[ -e "/code/preprocessor" ]] && /code/preprocessor "${SW_SRCDIR}" "${SW_DSTDIR}" $@

$COMMAND "${SW_SRCDIR}" "${SW_DSTDIR}" $@

[[ -e "/code/postprocessor" ]] && /code/postprocessor "${SW_SRCDIR}" "${SW_DSTDIR}" $@

${CONST_SBCMDDIR}/mkarchive "${SW_SRCDIR}" "${SW_DSTDIR}" "${SW_UID}" "${SW_GID}" $@

script_exit "end"
#------------------------------------------------------------------------------#
#                                  The End                                     #
#------------------------------------------------------------------------------#

# vim: foldmethod=marker
