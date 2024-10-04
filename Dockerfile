FROM python:3

LABEL \
  maintainer="john@vanzantvoort.org" \
  description="site builder command image"

RUN mkdir -p /usr/sbcmd/bin

# add the python requirements file
ADD requirements.txt /tmp/requirements.txt
ADD entrypoint.sh /usr/sbcmd/bin/entrypoint.sh
ADD mkarchive /usr/sbcmd/bin/mkarchive
ADD sphinx_build /usr/sbcmd/bin/sphinx_build

# runtime dependencies
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libldap2-dev \
		libsasl2-dev \
		rsync \
	; \
	rm -rf /var/lib/apt/lists/*

RUN pip install -U pip && pip install -r /tmp/requirements.txt

WORKDIR /code
VOLUME ["/output"]


USER docker:docker
ENTRYPOINT ["/usr/sbcmd/bin/entrypoint.sh"]
