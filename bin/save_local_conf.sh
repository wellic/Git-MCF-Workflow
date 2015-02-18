#!/bin/bash

set -e

RET_DIR=$PWD
CUR_DIR=$(dirname "$0")

cd "$CUR_DIR"/../
MAIN_DIR=$PWD
cd "$RET_DIR"

DST_DIR="$CUR_DIR"/local_git_config
GIT_DIR="$MAIN_DIR"/.git

#mkdir -p "$DST_DIR" 
echo "cp $GIT_DIR/config $DST_DIR/config"
cp "$GIT_DIR"/config "$DST_DIR"/config



