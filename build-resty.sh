#!/bin/bash

set -e  # Fail the script if anything fails
set -x  # Verbose output
set -u  # Undefined variables

./configure \
    "--prefix=$AR_BIN_DIR" \
    --with-file-aio \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-http_ssl_module \
    --with-luajit \
    "$@"

make
make install
