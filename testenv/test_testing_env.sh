#!/bin/bash

set -o nounset
set -e

echo
echo "--- Start $0 $*"

RET_DIR=$PWD

INSTALL_DIR=${1:-}
NAME_TESTDIR=${2:-_testgit_}
NAME_SERVER=${3:-server}
NAME_DEV=${4:-dev}


CUR_DIR=$(dirname "$0")
INSTALL_DIR=$1
[ -z "$INSTALL_DIR" ] && INSTALL_DIR="$CUR_DIR"/../..
cd $INSTALL_DIR
CUR_DIR=$PWD

ROOT="$CUR_DIR"/_testgit_


ROOT="$CUR_DIR"/"$NAME_TESTDIR"
DIR_SERVERS="$ROOT"/"$NAME_SERVER"s
DIR_DEVS="$ROOT"/"$NAME_DEV"s

#colors
c_main='\033[7;35m'
c_err='\033[1;31m'
c_inf='\033[1;34m'
c_cmd='\033[0;36m'
c_cmdinf='\033[1;32m'
c_cmdcd='\033[0;33m'
c_clr='\033[0m'

STATUS='Error'
STATUS_COLOR=$c_err

showerr() {
    local MESS=$1
    local COLOR=${2:-$c_err}
    echo -e "${COLOR}${MESS}${c_clr}"
}

showinfo() {
    local MESS=$1
    local COLOR=${2:-$c_inf}
    echo -e "${COLOR}${MESS}${c_clr}"
}

showcmd() {
    local CMD=$1
    local COLOR=${2:-"$c_cmd"}
    echo -e "${COLOR}# ${CMD}${c_clr}"
}

exit_if_error() {
    local STATUS=$1
    [ $STATUS = '0' ] && return 0
    local MESS=${2:-}
    [ ! -z "$MESS" ] && MESS="$MESS "
    MESS="${MESS}It was error."
    showerr "$MESS"
    exit $STATUS
}

do_cmd() {
    local MESS=${1:-''}
    local DO_CMD=${2:-''}
    local COLOR=${3:-$c_cmd}
    showinfo "$MESS:"  "$c_cmdinf"
    showcmd  "$DO_CMD" "$COLOR"
    [ "$DO_CMD" = '' ] && return 0
    $DO_CMD || exit_if_error $? "$MESS"
}

start_test() {

    local DEV=dev1
    local STEP_NUM=1
    local STEP="Step $STEP_NUM: Check dirs."
    local CNT=6
    showinfo "$STEP"
      do_cmd "$STEP 1-$CNT" "cd $ROOT"      ${c_cmdcd}
      do_cmd "$STEP 2-$CNT" "cd devs"       ${c_cmdcd}
      do_cmd "$STEP 3-$CNT" "ls -1"         ${c_cmdcd}
      do_cmd "$STEP 4-$CNT" "cd ../servers" ${c_cmdcd}
      do_cmd "$STEP 5-$CNT" "ls -1"         ${c_cmdcd}
      do_cmd "$STEP 6-$CNT" "cd ../devs"    ${c_cmdcd}
    showinfo "$STEP Status: Finished\n"

    STEP_NUM=2
    STEP="Step ${STEP_NUM}: Initial."
    CNT=10
    showinfo "$STEP"
      DEV=dev1
      do_cmd "$STEP 1-$CNT"  "cd $DEV" ${c_cmdcd}
      do_cmd "$STEP 2-$CNT ($DEV)"  "git remote -v"
      do_cmd "$STEP 3-$CNT ($DEV)"  "git w-fakecommit Initial_dev1_c1 off"
      do_cmd "$STEP 4-$CNT ($DEV)"  "git w-fakecommit dev1_c2 off"
      do_cmd "$STEP 5-$CNT ($DEV)"  "git w-fakecommit dev1_c3 off"
      do_cmd "$STEP 6-$CNT ($DEV)"  "git push -u origin master"
      do_cmd "$STEP 7-$CNT ($DEV)"  "git last"

      DEV=dev2
      do_cmd "$STEP 8-$CNT ($DEV)"  "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 9-$CNT ($DEV)"  "git pull origin master"
      do_cmd "$STEP 10-$CNT ($DEV)" "git w-create-base"
    showinfo "$STEP Status: Finished\n"

    STEP_NUM=3
    STEP="Step ${STEP_NUM}: Setup local config."
    CNT=4
    showinfo "$STEP"
      do_cmd "$STEP 1-$CNT ($DEV)" "git checkout cfg"
      do_cmd "$STEP 2-$CNT ($DEV)" "git w-fakecommit dev2_cfg1 off"
      do_cmd "$STEP 3-$CNT ($DEV)" "git w-fakecommit dev2_cfg2 off"
      do_cmd "$STEP 4-$CNT ($DEV)" "git w-rebuild-base"
    showinfo "$STEP Status: Finished\n"

    STEP_NUM=4
    STEP="Step ${STEP_NUM}: Work process in one group."
    CNT=7
    showinfo "$STEP"
      do_cmd "$STEP 1-$CNT ($DEV)" "git w-fakecommit dev2_fix1 off"
      do_cmd "$STEP 2-$CNT ($DEV)" "git w-fakecommit dev2_fix2 off"
      do_cmd "$STEP 3-$CNT ($DEV)" "git last"

      DEV=dev1
      do_cmd "$STEP 4-$CNT ($DEV)" "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 5-$CNT ($DEV)" "git w-fakecommit dev1_c4 off"
      do_cmd "$STEP 6-$CNT ($DEV)" "git w-fakecommit dev1_c5 off"
      do_cmd "$STEP 7-$CNT ($DEV)" "git last"
    showinfo "$STEP Status: Finished\n"

    STEP_NUM=5
    STEP="Step ${STEP_NUM}: Send and Load fixes in one group."
    CNT=7
    showinfo "$STEP"
      do_cmd "$STEP 1-$CNT ($DEV)" "git push origin master"
      do_cmd "$STEP 2-$CNT ($DEV)" "git last"

      DEV=dev2
      do_cmd "$STEP 3-$CNT ($DEV)" "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 4-$CNT ($DEV)" "git w-upload"

      DEV=dev1
      do_cmd "$STEP 5-$CNT ($DEV)" "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 6-$CNT ($DEV)" "git pull --rebase origin master"
      do_cmd "$STEP 7-$CNT ($DEV)" "git last"
    showinfo "$STEP Status: Finished\n"

    STEP_NUM=6
    STEP="Step ${STEP_NUM}: Test w-copy2tmp."
    CNT=7
    showinfo "$STEP"
      DEV=dev2
      do_cmd "$STEP 1-$CNT ($DEV)" "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 2-$CNT ($DEV)" "touch test.file" ${c_cmdcd}
      do_cmd "$STEP 3-$CNT ($DEV)" "git status"
      do_cmd "$STEP 4-$CNT ($DEV)" "git w-copy2tmp"
      do_cmd "$STEP 5-$CNT ($DEV)" "git br -r"
      do_cmd "$STEP 6-$CNT ($DEV)" "git status"
      do_cmd "$STEP 7-$CNT ($DEV)" "rm -f test.file" ${c_cmdcd}
    showinfo "$STEP Status: Finished\n"

    STEP_NUM=7
    STEP="Step ${STEP_NUM}: Work with additional source."
    CNT=18
    showinfo "$STEP"
      DEV=dev3
      do_cmd "$STEP 1-$CNT ($DEV)"  "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 2-$CNT ($DEV)"  "git w-fakecommit dev3_c1 off"
      do_cmd "$STEP 3-$CNT ($DEV)"  "git w-fakecommit dev3_c2 off"
      do_cmd "$STEP 4-$CNT ($DEV)"  "git w-fakecommit dev3_c3 off"
      do_cmd "$STEP 5-$CNT ($DEV)"  "git push -u server2 master"
      do_cmd "$STEP 6-$CNT ($DEV)"  "git last"

      DEV=dev1
      do_cmd "$STEP 7-$CNT ($DEV)"  "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 8-$CNT ($DEV)"  "git pull --rebase origin master"
      do_cmd "$STEP 9-$CNT ($DEV)"  "git w-fakecommit dev1_c6 off"
      do_cmd "$STEP 10-$CNT ($DEV)" "git w-fakecommit dev1_c7 off"
      do_cmd "$STEP 11-$CNT ($DEV)" "git push origin master"
      do_cmd "$STEP 12-$CNT ($DEV)" "git last"

      DEV=dev2
      do_cmd "$STEP 13-$CNT ($DEV)" "cd ../$DEV" ${c_cmdcd}
      do_cmd "$STEP 14-$CNT ($DEV)" "git w-fakecommit dev2_fix3 off"
      do_cmd "$STEP 15-$CNT ($DEV)" "git checkout cfg"
      do_cmd "$STEP 16-$CNT ($DEV)" "git w-fakecommit dev2_cfg3 off"
      do_cmd "$STEP 17-$CNT ($DEV)" "git w-rebuild-base"
      do_cmd "$STEP 18-$CNT ($DEV)" "git w-upload2 server2 master"

    showinfo "$STEP Status: Finished\n"

    STATUS='Ok'
    STATUS_COLOR=$c_main
}

cd "$RET_DIR"


showinfo 'Start test' $c_main
start_test
showinfo "Finish test: $STATUS" ${STATUS_COLOR}

showinfo "Please check"
cat << 'EOF'
* ... | Fake commit: dev2_cfg3 (HEAD,origin/_user_cfg_backup,fix,cfg)
* ... | Fake commit: dev2_cfg2
* ... | Fake commit: dev2_cfg1
* ... | Fake commit: dev2_fix3 (origin/master, master)
* ... | Merge remote-tracking branch 'server2/master'
|\
| * ... | Fake commit: dev3_c3 (server2/master)
| * ... | Fake commit: dev3_c2
| * ... | Fake commit: dev3_c1
* ... | Fake commit: dev1_c7
* ... | Fake commit: dev1_c6
* ... | Fake commit: dev2_fix2
* ... | Fake commit: dev2_fix1
* ... | Fake commit: dev1_c5
* ... | Fake commit: dev1_c4
* ... | Fake commit: dev1_c3
* ... | Fake commit: dev1_c2
* ... | Fake commit: Initial_dev1_c1
EOF
