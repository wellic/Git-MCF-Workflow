#!/bin/bash

set -e

cd "$(dirname "$0")"
CUR_DIR=$PWD
cd -
SRC_DIR="$CUR_DIR"/install.template
DST_DIR="$CUR_DIR"/_install
FNAME="my_git_name_info"

"$CUR_DIR"/00_prepare_install.sh

mkdir -p "$DST_DIR/old"

[ -f "$DST_DIR"/00_install.sh    ] && mv "$DST_DIR"/{,old/}00_install.sh
[ -f "$DST_DIR"/90_fix_win.sh    ] && mv "$DST_DIR"/{,old/}90_fix_win.sh

cp {"$SRC_DIR","$DST_DIR"}/00_install.sh
echo >> "$DST_DIR"/00_install.sh
echo "#user info" >> "$DST_DIR"/00_install.sh
cat "$CUR_DIR"/"$FNAME" >> "$DST_DIR"/00_install.sh
cp {"$SRC_DIR","$DST_DIR"}/90_fix_win.bat

echo -e "\e[1;36m""\nThe install program was prepared.\n""\e[0m"
echo "1. All user have to run installation after checked user info correct:"
echo  -e "\e[0;32m""sh \"$DST_DIR/00_install_name.sh\"\n""\e[0m"
echo "2. After installation Windows users have to start the additional fix."
echo "Go to the directory '$DST_DIR' and start fix:"
echo  -e "\e[0;32m""90_fix_win.bat\n""\e[0m"
