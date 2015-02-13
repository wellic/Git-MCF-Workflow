#!/bin/bash

set -o nounset
#set -e

CNT_DEVS=3
CNT_SERVERS=2

ROOT="${PWD}/_testgit_"
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
  while [ "$s" -lt "$e" ]
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

make_repos
make_devs
