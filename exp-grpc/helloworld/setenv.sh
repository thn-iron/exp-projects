#!/bin/bash

CWD=$(pwd)

GEN_DIR=$CWD/build/generated/source/proto

GOPATH=$CWD/src/main/go:$GEN_DIR/main/go
export GOPATH

PATH=$GOPATH/bin:$PATH
export PATH
