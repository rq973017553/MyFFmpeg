#! /bin/bash
# 编码H.264视频，编译参数--enable-gpl --enable-libx264

set -e

X264="x264"
X264_GIT_URL="https://code.videolan.org/videolan/x264.git"
X264_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
--disable-shared
--enable-static
--disable-asm
"

echo $CLONE_GIT_COMMAND$X264_GIT_URL

if [ ! -e $X264 ]; then
 echo "==========================clone x264=========================="
 $CLONE_GIT_COMMAND$X264_GIT_URL
fi

echo "==========================build x264=========================="
if [ -e $X264 ]; then
 cd $X264
 $X264_CONFIGURE_COMMAND
 make clean
 make
 make install
fi
cd ..
echo "==========================x264 build successful!=========================="
