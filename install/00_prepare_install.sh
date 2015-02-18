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
echo -e "\e[1;36mCheck user info ...\e[0m"
echo -e "\nCheck the file '$CUR_DIR/$DST_FNAME':"
echo -e "\e[1;34m--------- START CHECK ---------\e[1;33m"
cat "$CUR_DIR"/"$DST_FNAME"
echo -e "\e[1;34m---------- END CHECK ----------\e[0m"
echo -e "\nEdit user info:"
echo -e "\e[0;32m   vi \"$CUR_DIR/$DST_FNAME\"\n\e[0m"
}

[ ! -f "$CUR_DIR"/"$DST_FNAME" ] && ( cp "$SRC_DIR"/"$SRC_FNAME" "$CUR_DIR"/"$DST_FNAME"; print_check; echo -e "\e[1;31mPlease, edit the file '$CUR_DIR/$DST_FNAME'\e[0m"; exit 1 )

print_check

exit 0