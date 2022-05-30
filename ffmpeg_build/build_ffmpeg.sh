#! /bin/bash

# mac --cc=clang
# 禁用编译器优化选项 --disable-optimizations
# 编译libmp3lame需要使用到--extra-cflags和--extra-ldflags属性

set -e

PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

FFMPEG="FFmpeg"

# 通用配置
COMMON_FFMPEG_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
--extra-cflags=-I$PREFIX/include
--extra-ldflags=-L$PREFIX/lib
--enable-pthreads
--enable-gpl
--enable-version3
--disable-optimizations
--disable-shared
--enable-static
--enable-debug
--enable-nonfree
--enable-filter=delogo
"

# linux配置
LINUX_FFMPEG_CONFIGURE_COMMAND=$COMMON_FFMPEG_CONFIGURE_COMMAND"
--enable-libx264
--enable-libfdk-aac
--enable-libmp3lame
--enable-libopus
--enable-libvpx
"

# mac配置
MAC_CONFIGURE_COMMAND=$COMMON_FFMPEG_CONFIGURE_COMMAND"
--enable-libfdk-aac
--enable-libx264
--enable-libmp3lame
--enable-hardcoded-tables
--host-cflags=
--host-ldflags=
--cc=clang
"

FFMPEG_GIT_URL="git@github.com:FFmpeg/FFmpeg.git"


if [ ! -e $FFMPEG ]; then
 echo "==========================clone FFmpeg=========================="
 $CLONE_GIT_COMMAND$FFMPEG_GIT_URL
fi


echo "==========================build ffmpeg=========================="
if [ -e $FFMPEG ]; then
 cd $FFMPEG
 if [[ $SYSTEM == "Darwin" ]]; then
  $MAC_FFMPEG_CONFIGURE_COMMAND
 else
  $LINUX_FFMPEG_CONFIGURE_COMMAND
 fi
 make clean
 make
 make install
fi
echo "==========================ffmpeg build successful!=========================="
