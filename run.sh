#!/bin/sh

set -e -x -u

BASE=/vagrant

export AR_BIN_DIR=${HOME}/ar

python3 ${BASE}/sockets.py &

sleep 5

${AR_BIN_DIR}/bin/openresty 2>&1 | sleep 3600
