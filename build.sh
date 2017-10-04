#!/usr/bin/env bash

set -x

export DEBIAN_FRONTEND=noninteractive
export WORKSPACE_DIR=/workspace
# export THIRDPARTY_DIR=${WORKSPACE_DIR}/3rdparty
export PROJECT_DIR=${WORKSPACE_DIR}/native-app
export OUTPUT_DIR=${WORKSPACE_DIR}/out

if [ "$PWD" != "$WORKSPACE_DIR" ]; then
  echo "Build helper script to be run inside a container."
  echo "Go to $WORKSPACE_DIR directory before running this script."
  exit 1
fi

make
make -f sharedlib.makefile
make -f staticlib.makefile