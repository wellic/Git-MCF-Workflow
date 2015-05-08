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
FNAME_DO_INSTALL=02_install.sh
FNAME_USER_INFO="my_git_name_info"
CHECK_INFO='your name|your.email.address|yournickname'

SRC_DIR="$CUR_DIR"/install_template
DST_DIR="$CUR_DIR"/"$DIR_INSTALL"


prepare_install () {
  bash "$CUR_DIR/00_prepare_install.sh" || exit 1
}

prepare_dstdir() {
  [ -d "$DST_DIR" ] && rm -rf "$DST_DIR"
  mkdir -p "$DST_DIR"

  cp {"$SRC_DIR","$DST_DIR"}/"$FNAME_INSTALL"
  echo >> "$DST_DIR"/"$FNAME_INSTALL"
}

fill_userinfo() {
  echo "#user info" >> "$DST_DIR"/"$FNAME_INSTALL"
  cat "$CUR_DIR"/"$FNAME_USER_INFO" >> "$DST_DIR"/"$FNAME_INSTALL"
  echo >> "$DST_DIR"/"$FNAME_INSTALL"
}

add_os_params() {
  SUFFIX_OS="win.bat"
  MY_OS=$(uname)
  [ "$MY_OS" = "Linux"  ] && SUFFIX_OS="linux.sh"
  [ "$MY_OS" = "Darwin" ] && SUFFIX_OS="macos.sh"
  FNAME_FIX="fix_${SUFFIX_OS}"
  echo "#Added from $FNAME_FIX" >> "$DST_DIR"/"$FNAME_INSTALL"
  cat "$SRC_DIR"/"$FNAME_FIX" >> "$DST_DIR"/"$FNAME_INSTALL"
}

check_userinfo() {
   echo grep -q -P "$CHECK_INFO" "$CUR_DIR/$FNAME_USER_INFO"
   grep -q -P "$CHECK_INFO" "$CUR_DIR/$FNAME_USER_INFO" || return 0
   clear
   echo -e "\033[1;31mThe user info was not filled corectly.\033[0m"
   echo -e "\033[0;31m\nYou have to check user info in \"$CUR_DIR/$FNAME_USER_INFO\"\033[0m"
   echo -e "\033[1;34m--------- START CHECK ---------\033[1;33m"
   cat "$CUR_DIR/$FNAME_USER_INFO"
   echo -e "\033[1;34m---------- END CHECK ----------\033[0m"
   echo -e "\033[7;31m\nPlease fill user info completely.\033[0m"
   exit 1
}

#-------------------------------------------------------------------------------------------

prepare_install

echo -e "\033[7;35m\nStart creating  install\n\033[0m"

check_userinfo
prepare_dstdir
fill_userinfo
add_os_params

echo -e "\033[1;36mThe install program was prepared.\033[0m"
echo -e "\nYou have to run installation after checked user info correct:"
echo -e "\033[0;32m   bash \"$CUR_DIR/$FNAME_DO_INSTALL\"\033[0m"
echo -e "\033[7;35m\nFinish creating  install\033[0m"

exit 0