#!/bin/sh

cd $(dirname "$0")
nc -l -p 6666 < payload &
wget --debug localhost:6666
