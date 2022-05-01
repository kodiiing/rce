#!/usr/bin/env bash

VERSION = "1.18.1"

cd /tmp
curl -LO https://golang.org/dl/go${VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz
rm go${VERSION}.linux-amd64.tar.gz
