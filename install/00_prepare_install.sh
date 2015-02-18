#!/bin/bash

set -e

cd "$(dirname "$0")"
CUR_DIR=$PWD
cd -
clear
SRC_DIR="$CUR_DIR"/install.template
SRC_FNAME="git_name_info"
DST_FNAME=my_"$SRC_FNAME"

print_check() {
echo  -e "\e[1;36m""Check user info !!!\n""\e[0m"
echo "Check info in the '$CUR_DIR/$DST_FNAME':"
echo -e "\e[1;34m--------- START CHECK ---------\e[1;33m"
cat "$CUR_DIR"/"$DST_FNAME"
echo -e "\e[1;34m---------- END CHECK ----------\e[0m"
echo -e "\nFor edit user info:"
echo -e "\e[0;32m   vi \"$CUR_DIR/$DST_FNAME\"\e[0m"
}

[ ! -f "$CUR_DIR"/"$DST_FNAME" ] && ( cp "$SRC_DIR"/"$SRC_FNAME" "$CUR_DIR"/"$DST_FNAME"; print_check; echo -e "\e[1;31m""\nPlease, edit file '$CUR_DIR/$DST_FNAME'""\e[0m"; exit 1 )

print_check

exit 0