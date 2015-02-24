#!/bin/bash

set -e

RET_DIR=$PWD
CUR_DIR=$(dirname "$0")

cd "$CUR_DIR"/../
MAIN_DIR=$PWD
cd "$RET_DIR"

SRC=~/.gitconfig
DST="$MAIN_DIR/.gitconfig_sample"

echo cp "$SRC" "$DST"
cp "$SRC" "$DST"
sed 's/Valerii Savchenko.*$/your_name/g' -i "$DST"
sed 's/valerii.s\@.*$/your@mail/g' -i "$DST"
sed 's/wellic/yournick/g' -i "$DST"
