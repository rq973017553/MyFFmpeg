#! /bin/bash

SYSTEM=`uname`
MY_DIR=`pwd`
PREFIX=${MY_DIR}/output
cpu_num=`cat /proc/stat | grep cpu[0-9] -c`
CLONE_GIT_COMMAND="git clone "
