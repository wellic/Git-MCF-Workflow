#!/bin/bash

RET_DIR=$PWD

CUR_DIR=$(dirname "$0")
cd "$CUR_DIR"/../..
CUR_DIR=$PWD

set -o nounset
#set -e

CNT_DEVS=3
CNT_SERVERS=2

ROOT="$CUR_DIR"/_testgit_
DIR_SERVERS="$ROOT/servers"
DIR_DEVS="$ROOT/devs"

NAME_SERVER=server
NAME_DEV=dev

[ -e "$ROOT" ] && (rm -rf "$ROOT".bak ; mv -f "$ROOT" "$ROOT".bak) || : ; mkdir -p "$ROOT"
mkdir -p "$DIR_DEVS"
mkdir -p "$DIR_SERVERS"

myseq() {
  s=${1:-0}; e=${2:-0}; step=${3:-1};
  result=
  while [ "$s" -le "$e" ]
  do
    result="$result $s"
    s=$(( $s+$step ))
  done

  echo "$result"
}

make_repos() {
  cd "$DIR_SERVERS"
  for i in $( myseq 1 $CNT_SERVERS ) ; do
    NAME="$NAME_SERVER"$i
    git init --bare "$NAME"
  done
}

add_repos() {
  for i in $(myseq 2 $CNT_SERVERS) ; do
    NAME="$NAME_SERVER"$i
    git remote add $NAME "$DIR_SERVERS/$NAME"
  done
}

make_devs() {
  cd "$ROOT"

  for i in $(myseq 1 $CNT_DEVS) ; do
    cd "$DIR_DEVS"
    NAME="$NAME_DEV"$i
    git clone --no-hardlinks -n "$DIR_SERVERS/$NAME_SERVER"1 "$NAME"
    cd $NAME
    add_repos
  done
}


clear
make_repos
make_devs

cd "$RET_DIR"

echo -e "\033[7;35mCreated env. for testing\033[0m"

LIST=$(ls -1 "$DIR_SERVERS")
echo -e "Emulated servers in '$DIR_SERVERS':"
echo -e "\033[0;36m$LIST\033[0m"

LIST=$(ls -1 "$DIR_DEVS")
echo -e "Emulated developers in '$DIR_DEVS':" 
echo -e "\033[0;36m$LIST\033[0m"

echo -e "\nFor testing go to:"
echo -e "\033[0;32m   cd \"$DIR_DEVS\"\033[0m"

echo -e "\033[7;35m\nFinish creating env. for testing\033[0m"
