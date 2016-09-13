#!/usr/bin/env bash

CWD=$(cd "$(dirname "$0")" && pwd)

function create_dir() {
  TEMP_DIR="$1"
  if [ ! -d "${TEMPDIR}" ]; then
    mkdir -p "${TEMP_DIR}"
  fi
}

# top level generated source code directory
GEN_DIR=$CWD/build/generated/source/proto

# output dir for go
PROTO_GO_OUTDIR=$GEN_DIR/main/go/src

# output dir for java
PROTO_JAVA_OUTDIR=$GEN_DIR/main/java
PROTO_JAVA_GRPC_OUTDIR=$GEN_DIR/main/grpc

# top level source directory
SOURCE_DIR=$CWD/src/main/proto
SERVICE_DIR=${SOURCE_DIR}/service

PROTO_PATH="--proto_path=${SOURCE_DIR}"
PROTOC_BIN_PATH="protoc"

PROTOC_GRPC_JAVA_PLUGIN=${CWD}/plugins/protoc-gen-grpc-java
if [ ! -f "${PROTOC_GRPC_JAVA_PLUGIN}" ]; then
  echo "grpc-java compiler does not exist: ${PROTOC_GRPC_JAVA_PLUGIN}"
  echo "follow instructions at: https://github.com/grpc/grpc-java/tree/master/compiler"
  exit 1
fi

case "$1" in
  'go')
    if [ ! -z "$2" ]; then
      PROTO_GO_OUTDIR="$2"
    fi
    create_dir $PROTO_GO_OUTDIR

    PROTO_OUTDIR="--go_out=${PROTO_GO_OUTDIR}"
    PROTO_GRPC_OUTDIR="--go_out=plugins=grpc:${PROTO_GO_OUTDIR}"

    # for Go output
    find $SOURCE_DIR -type f -name '*.proto' -exec $PROTOC_BIN_PATH {} $PROTO_PATH $PROTO_OUTDIR \;

    # for GRPC Go output
    $PROTOC_BIN_PATH $SERVICE_DIR/*.proto $PROTO_PATH $PROTO_GRPC_OUTDIR

    echo "finished generating .go files at ${PROTO_GO_OUTDIR}"
    ;;

  'java')
    if [ ! -z "$2" ]; then
      PROTO_JAVA_OUTDIR="$2"
    fi
    create_dir $PROTO_JAVA_OUTDIR
    create_dir $PROTO_JAVA_GRPC_OUTDIR

    PROTO_OUTDIR="--java_out=${PROTO_JAVA_OUTDIR}"
    PROTO_GRPC_OUTDIR="--plugin=protoc-gen-grpc-java=${PROTOC_GRPC_JAVA_PLUGIN} --grpc-java_out=${PROTO_JAVA_GRPC_OUTDIR}"

    # for Java output
    find $SOURCE_DIR -type f -name '*.proto' -exec $PROTOC_BIN_PATH {} $PROTO_PATH $PROTO_OUTDIR \;

    # for GRPC Java output
    $PROTOC_BIN_PATH $SERVICE_DIR/*.proto $PROTO_PATH $PROTO_GRPC_OUTDIR

    echo "finished generating .java files at ${PROTO_JAVA_OUTDIR}"
    echo "finished generating grpc .java files at ${PROTO_JAVA_GRPC_OUTDIR}"
    ;;

  'clean')
    $0 clean.go $2
    $0 clean.java $2
    ;;

  'clean.go')
    if [ ! -z "$2" ]; then
      PROTO_GO_OUTDIR="$2"
    fi

    if [ -d "${PROTO_GO_OUTDIR}" ]; then
      echo "cleaning location: ${PROTO_GO_OUTDIR}"
      rm -rf ${PROTO_GO_OUTDIR}/*
    fi
    ;;

  'clean.java')
    if [ ! -z "$2" ]; then
      PROTO_JAVA_OUTDIR="$2"
      PROTO_JAVA_GRPC_OUTDIR="$2"
    fi

    if [ -d "${PROTO_JAVA_OUTDIR}" ]; then
      echo "cleaning location: ${PROTO_JAVA_OUTDIR}"
      rm -rf ${PROTO_JAVA_OUTDIR}/*
    fi

    if [ -d "${PROTO_JAVA_GRPC_OUTDIR}" ]; then
      echo "cleaning location: ${PROTO_JAVA_GRPC_OUTDIR}"
      rm -rf ${PROTO_JAVA_GRPC_OUTDIR}/*
    fi
    ;;

  *)
    echo -e "\nUsage: $0 {go | java | clean | clean.go | clean.java}"
    echo
esac
exit 0
