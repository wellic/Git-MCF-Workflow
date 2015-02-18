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
FNAME_USER_INFO="my_git_name_info"
FNAME_DO_INSTALL=02_install.sh

SRC_DIR="$CUR_DIR"/install.template
DST_DIR="$CUR_DIR"/"$DIR_INSTALL"

bash "$CUR_DIR/00_prepare_install.sh"
[ $? ] || exit 1

echo -e "\033[7;35m\nStart creating  install\n\033[0m"

[ -d  ] && rm -rf "$DST_DIR"
mkdir -p "$DST_DIR"

cp {"$SRC_DIR","$DST_DIR"}/"$FNAME_INSTALL"

echo >> "$DST_DIR"/"$FNAME_INSTALL"
echo "#user info" >> "$DST_DIR"/"$FNAME_INSTALL"
cat "$CUR_DIR"/"$FNAME_USER_INFO" >> "$DST_DIR"/"$FNAME_INSTALL"
echo >> "$DST_DIR"/"$FNAME_INSTALL"

[ "$(uname)" = 'Linux' ] && FNAME_FIX=fix_linux.sh || FNAME_FIX=fix_win.bat
echo "#Added from $FNAME_FIX" >> "$DST_DIR"/"$FNAME_INSTALL"
cat "$SRC_DIR"/"$FNAME_FIX" >> "$DST_DIR"/"$FNAME_INSTALL"

echo -e "\033[1;36mThe install program was prepared.\033[0m"
echo -e "\nYou have to run installation after checked user info correct:"
echo -e "\033[0;32m   bash \"$CUR_DIR/$FNAME_DO_INSTALL\"\033[0m"

echo -e "\033[7;35m\nFinish creating  install\033[0m"

exit 0