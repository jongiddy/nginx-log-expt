#!/bin/sh

set -e -x -u

BASE=/vagrant

# Let's try to limit the number of layers to minimum:
export OPENRESTY_VERSION=1.13.6.1 \
    OPENRESTY_DOWNLOAD_SHASUM=775b89cfadf3dbfa13864f3ad4dee4f67dac6604 \
    OPENRESTY_DIR=${HOME}/src/openresty \
    OPENRESTY_COMPILE_OPTS="" \
    AR_BIN_DIR=${HOME}/ar

# These depend on other ENV vars, so we need a separate ENV block:
export OPENRESTY_DOWNLOAD_URL=https://openresty.org/download/openresty-$OPENRESTY_VERSION.tar.gz \
    AUTH_ERROR_PAGE_DIR_PATH=${AR_BIN_DIR}/nginx/conf/errorpages


# apt-get update

# apt-get install -y --no-install-recommends \
#         apt-file \
#         dnsutils \
#         git \
#         iproute2 \
#         less \
#         psmisc \
#         strace \
#         tcpdump \
#         telnet \
#         tree \
#         vim

# # AR related:
# apt-get install -y --no-install-recommends \
#         gcc \
#         gettext-base \
#         libdigest-sha-perl \
#         libffi-dev \
#         libffi6 \
#         libpcre++-dev \
#         libssl-dev \
#         make \
#         patch \
#         python3 \
#         python3-dev \
#         python3-pip \
#         python3-virtualenv \
#         rsync

# python3 -m pip install --upgrade virtualenv
# virtualenv --no-site-packages $VENV_DIR
# ${VENV_DIR}/bin/pip install --upgrade setuptools pip

# export PATH=${VENV_DIR}/bin:$PATH

# pip install -r requirements-tests.txt

curl -fsSL "$OPENRESTY_DOWNLOAD_URL" -o openresty.tar.gz
echo "$OPENRESTY_DOWNLOAD_SHASUM  openresty.tar.gz" | shasum -c -
mkdir -pv $OPENRESTY_DIR
tar --strip-components=1 -C $OPENRESTY_DIR -xzf openresty.tar.gz
rm openresty.tar.gz
patch -p1 $OPENRESTY_DIR/configure ${BASE}/openresty-1.13.6.1-no_sse42.patch

cd $OPENRESTY_DIR

${BASE}/build-resty.sh


# cp ${BASE}/nginx.conf.clear ${AR_BIN_DIR}/nginx/conf/nginx.conf
# cp ${BASE}/nginx.conf.block_access ${AR_BIN_DIR}/nginx/conf/nginx.conf
# cp ${BASE}/nginx.conf.block_error ${AR_BIN_DIR}/nginx/conf/nginx.conf
cp ${BASE}/nginx.conf.stderr ${AR_BIN_DIR}/nginx/conf/nginx.conf
