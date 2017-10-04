#!/usr/bin/env bash

# git clean -dfx && git submodule foreach "git clean -dfx"
# git submodule update --init

docker run --rm --tty --interactive --workdir=/workspace --volume ${PWD}:/workspace praqma/native-make:latest bash
