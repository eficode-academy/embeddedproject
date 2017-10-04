#!/usr/bin/env bash

set -x

export DEBIAN_FRONTEND=noninteractive
export WORKSPACE_DIR=/workspace
# export THIRDPARTY_DIR=${WORKSPACE_DIR}/3rdparty
export PROJECT_DIR=${WORKSPACE_DIR}/native-app
export OUTPUT_DIR=${WORKSPACE_DIR}/out

if [ "$PWD" != "$WORKSPACE_DIR" ]; then
  echo "Test helper script to be run inside a container."
  echo "Go to $WORKSPACE_DIR directory before running this script."
  exit 1
fi

make test
${OUTPUT_DIR}/bin/test --durations yes --reporter compact --out ${OUTPUT_DIR}/bin/results_compact.txt
${OUTPUT_DIR}/bin/test --durations yes --reporter console --out ${OUTPUT_DIR}/bin/results_console.txt
${OUTPUT_DIR}/bin/test --durations yes --reporter junit --out ${OUTPUT_DIR}/bin/results_junit.xml
${OUTPUT_DIR}/bin/test --durations yes --reporter xml --out ${OUTPUT_DIR}/bin/results_xml.xml