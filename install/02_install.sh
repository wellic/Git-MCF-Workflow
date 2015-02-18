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

echo -e "\033[7;35mStart installing\n\033[0m"

bash "$CUR_DIR/$DIR_INSTALL/$FNAME_INSTALL"

echo -e "\nPlease check your new '.gitconfig':"
echo -e "\033[0;32m   less ~/.gitconfig\033[0m"

echo -e "\033[7;35m\nFinish installing\033[0m"

exit "$?"