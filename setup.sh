#!/bin/sh

set -e -x -u

BASE=/vagrant

apt-get update

apt-get install -y --no-install-recommends \
        apt-file \
        dnsutils \
        git \
        iproute2 \
        less \
        psmisc \
        strace \
        tcpdump \
        telnet \
        tree \
        vim

# AR related:
apt-get install -y --no-install-recommends \
        gcc \
        gettext-base \
        libdigest-sha-perl \
        libffi-dev \
        libffi6 \
        libpcre++-dev \
        libssl-dev \
        make \
        patch \
        python3 \
        python3-dev \
        python3-pip \
        python3-virtualenv \
        rsync

