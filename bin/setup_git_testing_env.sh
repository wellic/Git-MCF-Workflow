#!/bin/bash 

set -o nounset
#set -e 

CNT_DEVS=5
CNT_SERVERS=3

ROOT="${PWD}/_testgit_"
DIR_SERVERS="$ROOT/servers"
DIR_DEVS="$ROOT/devs"

NAME_SERVER=server
NAME_DEV=dev

[ -e "$ROOT" ] && (rm -rf "$ROOT".bak ; mv -f "$ROOT" "$ROOT".bak) || : ; mkdir -p "$ROOT"
mkdir -p "$DIR_DEVS"
mkdir -p "$DIR_SERVERS"

make_repos() {
  cd "$DIR_SERVERS"
  for i in $( seq 1 $CNT_SERVERS ) ; do 
    NAME="$NAME_SERVER"$i
    git init --bare "$NAME"
  done
}

add_repos() {
  for i in $(seq 2 $CNT_SERVERS) ; do 
    NAME="$NAME_SERVER"$i
    git remote add $NAME "$DIR_SERVERS/$NAME"
  done
}

make_devs() {
  cd "$ROOT"  

  for i in $(seq 1 $CNT_DEVS) ; do 
    cd "$DIR_DEVS"  
    NAME="$NAME_DEV"$i
    git clone --no-hardlink "$DIR_SERVERS/$NAME_SERVER"1 "$NAME"
    cd $NAME
    add_repos
  done

  NAME="$NAME_DEV"1
  cd "$DIR_DEVS/$NAME"
  git commit --allow-empty -m "'Initial commit of dev: $NAME'"
  git push -u origin master

#  for i in $(seq 2 $CNT_DEVS) ; do 
#    NAME="$NAME_DEV"$i
#    cd "$DIR_DEVS/$NAME"  
#    git pull origin master
#  done

}

make_repos
make_devs
