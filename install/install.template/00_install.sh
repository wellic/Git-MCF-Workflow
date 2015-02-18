#!/bin/sh

NAME_CFG=".gitconfig"
NAME_TMPL=".gitconfig_sample"

cp -v ~/"$NAME_CFG" ~/"${NAME_CFG}.$(date +%Y%m%d_%H%M%S).old"

CUR_DIR=$(dirname "$0")
cd "$CUR_DIR"/../../
CFG_DIR=$PWD
cd -

[ ! -f "$CFG_DIR"/"$NAME_TMPL" ] && (echo -e "\e[1;31m\nSome error. Check exists script '$CFG_DIR/$NAME_TMPL'\e[0m"; exit 1 )

cp -v "$CFG_DIR"/"$NAME_TMPL" ~/"$NAME_CFG"

