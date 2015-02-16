#!/bin/bash

set -e

CUR_DIR=$(dirname "$0")
DST_DIR="$CUR_DIR"/local_git_config
GIT_DIR="$CUR_DIR"/../.git

#mkdir -p "$DST_DIR" 
echo "cp $GIT_DIR/config $DST_DIR/config"
cp "$GIT_DIR"/config "$DST_DIR"/config



