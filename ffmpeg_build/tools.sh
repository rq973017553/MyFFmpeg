#! /bin/bash

SYSTEM=`uname` # 用于显示操作系统名称
MY_DIR=`pwd` # 获取当前目录的绝对路径
PREFIX=${MY_DIR}/output # 输出目录，用于存放生成好的二进制文件
cpu_num=`cat /proc/stat | grep cpu[0-9] -c` # 用于获取当前系统的cpu数量
CLONE_GIT_COMMAND="git clone " # git clone
