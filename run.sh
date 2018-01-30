#!/bin/sh

case $1 in
    dev)
        cmd=/opt/CVE-2017-13089/src/dev/exploit-dev.sh
        ;;
    dos)
        cmd=/opt/CVE-2017-13089/src/dos/crash.sh
        ;;
    exploit)
        cmd=/opt/CVE-2017-13089/src/exploit/exploit.sh
        ;;
    *)
        cmd=/bin/bash
        ;;
esac

docker build -t cve201713089 .
docker run \
    --security-opt seccomp=unconfined \
    -it \
    -v "$(pwd)"/src:/opt/CVE-2017-13089/src \
    cve201713089 \
    $cmd
