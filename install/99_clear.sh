#!/bin/bash

set -e

cd "$(dirname "$0")"
CUR_DIR=$PWD
cd -
clear 

SRC_DIR="$CUR_DIR"/install.template
NAME_INSTALL_DIR=_install
NAME_INSTALL_PRG=00_install.sh
NAME_FIX_PRG=90_fix_win.bat
DST_DIR="$CUR_DIR"/"$NAME_INSTALL_DIR"
FILE_NAME_INFO="my_git_name_info"


echo -e "\e[1;36mClearing ...\e[0m"

[ -d "$CUR_DIR"/"$NAME_INSTALL_DIR" ] &&  rm -vrf "$CUR_DIR"/"$NAME_INSTALL_DIR"
#[ -f "$CUR_DIR"/"$FILE_NAME_INFO" ] &&  mv -v "$CUR_DIR"/"$FILE_NAME_INFO" "$CUR_DIR"/"${FILE_NAME_INFO}.$(date +%Y%m%d_%H%M%S).old"

echo -e "\e[1;36mCleared\e[0m"

exit 0