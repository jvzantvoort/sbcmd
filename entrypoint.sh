#!/bin/bash
CONST_SCRIPTPATH="$(readlink -f "$0")"
CONST_SCRIPTNAME="$(basename "$CONST_SCRIPTPATH" .sh)"
CONST_SCRIPTDIR="$(dirname "$CONST_SCRIPTPATH")"
CONST_OUTPUTBASEDIR="/output"
CONST_CODEBASEDIR="/code"
CONST_SBCMDDIR="/usr/sbcmd/bin"
CONST_LOGFILE="${CONST_OUTPUTBASEDIR}/logging.txt"

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
    SW_DSTDIR="html" ;;
  ablog) SW_SRCDIR=""
    SW_DSTDIR="website" ;;
esac

# extract certain arguments
# --------------------------------------
for arg_item in "$@"
do
  case $arg_item in
    srcdir=*) SW_SRCDIR="${arg_item#*=}";        shift ;;
    dstdir=*) SW_DSTDIR="${arg_item#*=}";        shift ;;
    uid=*)    SW_UID="${arg_item#*=}";           shift ;;
    gid=*)    SW_GID="${arg_item#*=}";           shift ;;
    *)        ARGS=("${ARGS[@]}" "${arg_item}"); shift ;;
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
