#!/bin/bash

#You do not have to change the code if you do not understand that you do
#Вы не должны изменять код, если вы не понимаете, что вы делаете.

set -e

RET_DIR=$PWD
CUR_DIR=$(dirname "$0")
cd "$CUR_DIR"
CUR_DIR=$PWD
cd "$RET_DIR"
clear

DIR_INSTALL=_install
FNAME_INSTALL=install.sh
FNAME_FIX_WIN=fix_win.bat

SRC_FNAME="git_name_info"
DST_FNAME=my_"$SRC_FNAME"

SRC_DIR="$CUR_DIR"/install.template

print_check() {
echo -e "\033[1;36mCheck user info ...\033[0m"
echo -e "\nCheck the file '$CUR_DIR/$DST_FNAME':"
echo -e "\033[1;34m--------- START CHECK ---------\033[1;33m"
cat "$CUR_DIR"/"$DST_FNAME"
echo -e "\033[1;34m---------- END CHECK ----------\033[0m"
echo -e "\nEdit user info:"
echo -e "\033[0;32m   vi \"$CUR_DIR/$DST_FNAME\"\033[0m"
}

echo -e "\033[7;35mStart preparing install\n\033[0m"

[ ! -f "$CUR_DIR"/"$DST_FNAME" ] && ( cp "$SRC_DIR"/"$SRC_FNAME" "$CUR_DIR"/"$DST_FNAME"; print_check; echo -e "\033[1;31mPlease, edit the file '$CUR_DIR/$DST_FNAME'\033[0m"; exit 1 )
print_check

echo -e "\033[7;35m\nFinish preparing install\033[0m"

exit 0