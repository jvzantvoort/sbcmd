FROM jvzantvoort/python3:latest

LABEL \
  maintainer="john@vanzantvoort.org" \
  description="site builder command image"

RUN mkdir -p /usr/sbcmd/bin

# add the python requirements file
ADD requirements.txt /tmp/requirements.txt
ADD entrypoint.sh /usr/sbcmd/bin/entrypoint.sh
ADD mkarchive /usr/sbcmd/bin/mkarchive
ADD sphinx_build /usr/sbcmd/bin/sphinx_build

# install required debian packages and
# run pip to install the requirements
RUN apt-get update && apt-get install -y libldap2-dev libsasl2-dev rsync && \
pip install -r /tmp/requirements.txt && \
sed -i 's,sphinx.application,sphinx.errors,g' /usr/local/lib/python3.6/site-packages/sphinxcontrib/googleanalytics.py

WORKDIR /code
VOLUME ["/output"]


USER docker:docker
ENTRYPOINT ["/usr/sbcmd/bin/entrypoint.sh"]
