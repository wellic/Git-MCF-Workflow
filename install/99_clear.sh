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

echo -e "\033[7;35mStart clearing\n\033[0m"

[ -d "$CUR_DIR"/"$DIR_INSTALL" ] &&  rm -vrf "$CUR_DIR"/"$DIR_INSTALL"

echo -e "\033[7;35m\nFinish clearing\033[0m"

exit 0