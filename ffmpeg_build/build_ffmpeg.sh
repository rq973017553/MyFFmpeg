#! /bin/bash

set -e

FFMPEG="FFmpeg"
FFMPEG_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir="$PREFIX/bin"
--extra-cflags="-I$PREFIX/include"
--extra-ldflags="-L$PREFIX/lib"
--enable-gpl
--enable-version3
--enable-shared
--enable-debug
--enable-libx264
--enable-libfdk-aac
--enable-libmp3lame
--enable-libopus
--enable-libvpx
--enable-nonfree
"

FFMPEG_GIT_URL="git@github.com:FFmpeg/FFmpeg.git"


if [ ! -e $FFMPEG ]; then
 echo "==========================clone FFmpeg=========================="
 $CLONE_GIT_COMMAND$FFMPEG_GIT_URL
fi


echo "==========================build ffmpeg=========================="
if [ -e $FFMPEG ]; then
 cd $FFMPEG
 $FFMPEG_CONFIGURE_COMMAND
 make
 make install
 make distclean
fi
echo "==========================ffmpeg build successful!=========================="
