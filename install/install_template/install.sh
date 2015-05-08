#!/bin/bash

set -e 

#You do not have to change the code if you do not understand that you do
#Вы не должны изменять код, если вы не понимаете, что вы делаете.


NAME_CFG=".gitconfig"
NAME_TMPL=".gitconfig_sample"
cp -v ~/"$NAME_CFG" ~/"${NAME_CFG}.$(date +%Y%m%d_%H%M%S).old"

RET_DIR=$PWD
CUR_DIR=$(dirname "$0")
cd "$CUR_DIR"
CUR_DIR=$PWD
cd "$CUR_DIR"/../../
CFG_DIR=$PWD
cd "$RET_DIR"

[ ! -f "$CFG_DIR"/"$NAME_TMPL" ] && (echo -e "\033[1;31m\nSome error. Check exists script '$CFG_DIR/$NAME_TMPL'\033[0m"; exit 1 )

cp -v "$CFG_DIR"/"$NAME_TMPL" ~/"$NAME_CFG"
