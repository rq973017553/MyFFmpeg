#! /bin/bash

# mac --cc=clang
# 禁用编译器优化选项 --disable-optimizations

set -e

PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

FFMPEG="FFmpeg"

FFMPEG_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
--enable-filter=delogo
--enable-pthreads
--enable-indev=avfoundation
--enable-gpl
--enable-version3
--disable-optimizations
--disable-shared
--enable-static
--enable-debug
--enable-libx264
--enable-libfdk-aac
--enable-libmp3lame
--enable-libopus
--enable-libvpx
--enable-nonfree
"

MAC_CONFIGURE_COMMAND=$UBUNTU_FFMPEG_CONFIGURE_COMMAND"--CC=clang
--enable-hardcoded-tables
--host-cflags=
--host-ldflags=
"

FFMPEG_GIT_URL="git@github.com:FFmpeg/FFmpeg.git"


if [ ! -e $FFMPEG ]; then
 echo "==========================clone FFmpeg=========================="
 $CLONE_GIT_COMMAND$FFMPEG_GIT_URL
fi


echo "==========================build ffmpeg=========================="
if [ -e $FFMPEG ]; then
 cd $FFMPEG
 if [ $SYSTEM == "Darwin" ]; then
  $MAC_FFMPEG_CONFIGURE_COMMAND
 else
  $FFMPEG_CONFIGURE_COMMAND
 fi
 make clean
 make
 make install
fi
echo "==========================ffmpeg build successful!=========================="
