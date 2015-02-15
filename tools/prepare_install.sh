#!/bin/bash

set -e

SRC_DIR=./before_install
DST_DIR=./install

mkdir -p "$DST_DIR/old"

[ -f "$DST_DIR"/00_install.sh    ] && mv "$DST_DIR"/{,old/}00_install.sh
[ -f "$DST_DIR"/01_setup_name.sh ] && mv "$DST_DIR"/{,old/}01_setup_name.sh
[ -f "$DST_DIR"/90_fix_win.sh    ] && mv "$DST_DIR"/{,old/}90_fix_win.sh

cp {"$SRC_DIR","$DST_DIR"}/00_install.sh
[ -f "$SRC_DIR"/my_setup_name.sh ] && cp "$SRC_DIR"/my_setup_name.sh "$DST_DIR"/01_setup_name.sh || cp {"$SRC_DIR","$DST_DIR"}/01_setup_name.sh
cp {"$SRC_DIR","$DST_DIR"}/90_fix_win.bat
