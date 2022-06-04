#! /bin/bash
# 编码H.265视频，ffmpeg通过编译参数--enable-gpl --enable-libx265来开启

set -e

PATH=$PATH:$PREFIX/bin

X265="x265_git"
X265_GIT_URL="https://bitbucket.org/multicoreware/x265_git.git"

echo $CLONE_GIT_COMMAND$X265_GIT_URL

if [ ! -e $X265 ]; then
 echo "==========================clone x265=========================="
 $CLONE_GIT_COMMAND$X265_GIT_URL
fi

echo "==========================build x265=========================="
if [ -e $X265 ]; then
 cd $X265/build/linux
 if [[ "$enableShared" == true  ]]; then
  switchStatus=on
 else
  switchStatus=off
 fi
 cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$PREFIX -DENABLE_SHARED=$switchStatus ../../source
 make -j${cpu_num}
 make install
fi
cd $MY_DIR
echo "==========================x265 build successful!=========================="
