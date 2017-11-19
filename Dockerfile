FROM ubuntu:xenial
MAINTAINER rob@computerlab.io
WORKDIR /opt/CVE-2017-13089/

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autopoint \
    build-essential \
    execstack \
    flex \
    gcc \
    gdb \
    gettext \
    git \
    gperf \
    libgnutls30 \
    libgnutls-dev \
    make \
    netcat \
    pkg-config \
    python \
    rsync \
    texinfo

RUN git clone git://git.savannah.gnu.org/wget.git -b v1.19.1

COPY src/patches/01-no-stack-protector.patch wget/
COPY src/patches/02-build-with-debugging-symbols.patch wget/
RUN cd wget && \
    git apply 01-no-stack-protector.patch && \
    git apply 02-build-with-debugging-symbols.patch

RUN cd wget && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    objcopy --only-keep-debug /usr/local/bin/wget /usr/local/bin/wget.debug && \
    objcopy --strip-debug /usr/local/bin/wget && \
    execstack -s /usr/local/bin/wget
