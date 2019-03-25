FROM python:2.7.13

LABEL \
  maintainer="john@vanzantvoort.org" \
  description="site builder command image"

# add the python requirements file
ADD requirements.txt /tmp/requirements.txt

# install required debian packages
# Run pip to install the requirements
RUN apt-get update && \
    apt-get install -y libldap2-dev libsasl2-dev && \
    pip install -r /tmp/requirements.txt

WORKDIR /code
VOLUME ["/output"]

ENTRYPOINT ["/code/entrypoint.sh"]
