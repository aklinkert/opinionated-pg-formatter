FROM alpine:3

RUN apk add --no-cache --update bash perl make

WORKDIR /pgformatter

ARG PG_FORMATTER_VERSION=v5.8

ADD https://github.com/darold/pgFormatter/archive/refs/tags/$PG_FORMATTER_VERSION.tar.gz pg_format.tar.gz
RUN tar --strip-components=1 -xf pg_format.tar.gz

RUN perl Makefile.PL \
    && make \
    && make install \
    && mv pg_format /etc/pg_format

WORKDIR /workdir

ADD format.sh /etc/format.sh
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "/etc/format.sh"]
