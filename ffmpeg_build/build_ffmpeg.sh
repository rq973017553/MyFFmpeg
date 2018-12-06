#! /bin/bash

set -e

export LDFLAGS="${LDFLAGS} -lstdc++"

MY_DIR=`pwd`
PREFIX=${MY_DIR}/input

PKG_CONFIG_GIT_URL="git://anongit.freedesktop.org/pkg-config"
PKG_CONFIG="pkg-config"
PKG_CONFIG_VERSION="0.29.2"
PKG_CONFIG_URL="https://pkg-config.freedesktop.org/releases/"

FFMPEG_DIR="ffmpeg"
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

if [ ! -e $FFMPEG_DIR ]; then
 echo "===============clone FFmpeg================"
 $CLONE_GIT_COMMAND$FFMPEG_GIT_URL
fi

if [ ! -e $X264_DIR ]; then
 echo "===============clone libx264================"
 $CLONE_GIT_COMMAND$X264_GIT_URL
fi

#if [ ! -e $PKG_CONFIG ]; then
#echo "================clone pkg-config============="
# $CLONE_GIT_COMMAND$PKG_CONFIG_GIT_URL
#fi

echo "=================download pkgconfig==========="
if [ ! -e $PKG_CONFIG".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl -O $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz"\ 
        > $PKG_CONFIG".tar.gz"
 else
  wget $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz"\ 
        -O $PKG_CONFIG".tar.gz"
 fi
fi

echo "================unzip pkg-config=========="
if [ -e $PKG_CONFIG".tar.gz" ]; then
 if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION ]; then 
  rm -r $PKG_CONFIG"-"$PKG_CONFIG_VERSION
 fi 
 tar zxvf $PKG_CONFIG".tar.gz"
fi
 
echo "=================download yasm============="
if [ ! -e $YASM".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" > $YASM".tar.gz"
 else
  wget $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" -O $YASM".tar.gz"
 fi
fi

echo "==================unzip yasm================"
if [ -e $YASM".tar.gz" ]; then
 if [ -e $YASM"-"$YASM_VERSION ]; then 
  rm -r $YASM"-"$YASM_VERSION
 fi 
 tar zxvf $YASM".tar.gz"
fi

echo "=================install pkg-config========="
cd $PKG_CONFIG"-"$PKG_CONFIG_VERSION
#cd $PKG_CONFIG
./configure --with-internal-glib
make
sudo make install

echo "==================install yasm================"
cd ..
cd $YASM"-"$YASM_VERSION
./configure
make
sudo make install

echo "==================install x264================="
cd ..
cd $X264_DIR
$X264_CONFIGURE_COMMAND
make
sudo make install

echo "==================install ffmpeg==============="
cd ..
cd $FFMPEG_DIR
$FFMPEG_CONFIGURE_COMMAND
