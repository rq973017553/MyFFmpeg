#! /bin/bash

set -e

MY_DIR=`pwd`
PREFIX=${MY_DIR}/output

PKG_CONFIG_GIT_URL="git://anongit.freedesktop.org/pkg-config"
PKG_CONFIG="pkg-config"
PKG_CONFIG_VERSION="0.29.2"
PKG_CONFIG_URL="https://pkg-config.freedesktop.org/releases/"

FFMPEG_DIR="FFmpeg"
FFMPEG_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--enable-gpl
--enable-version3
--enable-nonfree
--enable-shared
--enable-debug
--enable-libx264
"

X264_DIR="x264"
X264_GIT_URL="http://git.videolan.org/git/x264.git x264"
X264_CONFIGURE_COMMAND="./configure
--enable-shared
--disable-asm
"

YASM="yasm"
YASM_DOWNLOAD_URL="http://www.tortall.net/projects/yasm/releases/"
YASM_VERSION="1.2.0"

MY_DIR=`pwd`
SYSTEM=`uname`
CLONE_GIT_COMMAND="git clone "
FFMPEG_GIT_URL="git@github.com:FFmpeg/FFmpeg.git"

cd $MY_DIR

if [ -e "output" ]; then
 rm -rf output 
 mkdir output
else
 mkdir output
fi

if [ ! -e $FFMPEG_DIR ]; then
 echo "==========================clone FFmpeg=========================="
 $CLONE_GIT_COMMAND$FFMPEG_GIT_URL
fi

if [ ! -e $X264_DIR ]; then
 echo "==========================clone x264=========================="
 $CLONE_GIT_COMMAND$X264_GIT_URL
fi

echo "==========================download pkg-config=========================="
if [ ! -e $PKG_CONFIG".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl -O $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" \
> $PKG_CONFIG".tar.gz"
 else
  wget $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" \
-O $PKG_CONFIG".tar.gz"
 fi
fi

echo "==========================unzip pkg-config=========================="
if [ -e $PKG_CONFIG".tar.gz" ]; then
 if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION ]; then 
  rm -r $PKG_CONFIG"-"$PKG_CONFIG_VERSION
 fi 
 tar zxvf $PKG_CONFIG".tar.gz"
fi
 
echo "==========================download yasm=========================="
if [ ! -e $YASM".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" > $YASM".tar.gz"
 else
  wget $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" -O $YASM".tar.gz"
 fi
fi

echo "==========================unzip yasm=========================="
if [ -e $YASM".tar.gz" ]; then
 if [ -e $YASM"-"$YASM_VERSION ]; then 
  rm -r $YASM"-"$YASM_VERSION
 fi 
 tar zxvf $YASM".tar.gz"
fi

echo "==========================build pkg-config=========================="
if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION ]; then
 cd $PKG_CONFIG"-"$PKG_CONFIG_VERSION
 ./configure --with-internal-glib
 make clean
 make
 sudo make install
fi
echo "==========================pkg-config build successful!=========================="


echo "==========================build yasm=========================="
cd ..
if [ -e $YASM"-"$YASM_VERSION ]; then
 cd $YASM"-"$YASM_VERSION
 ./configure
 make clean
 make
 sudo make install
fi
echo "==========================yasm build successful!=========================="


echo "==========================build x264=========================="
cd ..
if [ -e $X264_DIR ]; then
 cd $X264_DIR
 $X264_CONFIGURE_COMMAND
 make clean
 make
 sudo make install
fi
echo "==========================x264 build successful!=========================="


echo "==========================build ffmpeg=========================="
cd ..
if [ -e $FFMPEG_DIR ]; then
 cd $FFMPEG_DIR
 $FFMPEG_CONFIGURE_COMMAND
fi
echo "==========================ffmpeg build successful!=========================="
