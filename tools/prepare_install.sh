#!/bin/bash

set -e

cd "$(dirname "$0")"
CURDIR=$PWD
cd -
clear
SRC_DIR="$CURDIR"/before_install
DST_DIR="$CURDIR"/install

[ ! -f "$SRC_DIR"/my_setup_name.sh ] && ( cp "$SRC_DIR"/{01,my}_setup_name.sh; echo; echo "Please, prepare file '$SRC_DIR/my_setup_name.sh'"; exit 1 )

mkdir -p "$DST_DIR/old"

[ -f "$DST_DIR"/00_install.sh    ] && mv "$DST_DIR"/{,old/}00_install.sh
[ -f "$DST_DIR"/01_setup_name.sh ] && mv "$DST_DIR"/{,old/}01_setup_name.sh
[ -f "$DST_DIR"/90_fix_win.sh    ] && mv "$DST_DIR"/{,old/}90_fix_win.sh

cp {"$SRC_DIR","$DST_DIR"}/00_install.sh
[ -f "$SRC_DIR"/my_setup_name.sh ] && cp "$SRC_DIR"/my_setup_name.sh "$DST_DIR"/01_setup_name.sh || ( cp {"$SRC_DIR","$DST_DIR"}/01_setup_name.sh; "$DST_DIR"/{01,my}_setup_name.sh )
cp {"$SRC_DIR","$DST_DIR"}/90_fix_win.bat

echo
echo "The directory 'install' was prepared"
echo
echo "Before install check file: '$DST_DIR/01_setup_name.sh'"
echo
echo "### Begin check file"
echo "### $DST_DIR/01_setup_name.sh'"
echo
cat "$DST_DIR"/01_setup_name.sh
echo
echo "### End check file"
echo
echo "For start install:"
echo "sh \"$DST_DIR/00_install_name.sh\""
echo
