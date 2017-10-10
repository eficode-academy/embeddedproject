#!/usr/bin/env bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive
export WORKSPACE_DIR=/workspace
# export THIRDPARTY_DIR=${WORKSPACE_DIR}/3rdparty
export PROJECT_DIR=${WORKSPACE_DIR}/native-app
export OUTPUT_DIR=${WORKSPACE_DIR}/out

make all
