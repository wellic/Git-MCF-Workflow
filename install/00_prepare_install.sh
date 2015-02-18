#!/bin/bash

set -e

cd "$(dirname "$0")"
CUR_DIR=$PWD
cd -
clear
SRC_DIR="$CUR_DIR"/install.template
FNAME="my_git_name_info"

[ ! -f "$CUR_DIR"/$FNAME ] && ( cp {"$SRC_DIR","$CUR_DIR"}/$FNAME; echo -e "\e[1;31m""\nPlease, prepare file '$CUR_DIR/$FNAME'\n""\e[0m"; exit 1 )

echo  -e "\e[1;36m""\nPlease check user info !!!\n""\e[0m"
echo "Check info in the '$CUR_DIR/$FNAME':"
echo -e "\e[1;34m""--------- START CHECK ---------\n""\e[1;33m"
cat "$CUR_DIR"/"$FNAME"
echo -e "\e[1;34m""\n---------- END CHECK ----------\n""\e[0m"
echo "For edit user info:"
echo  -e "\e[0;32m""vi \"$CUR_DIR/$FNAME\"""\e[0m"

exit 0