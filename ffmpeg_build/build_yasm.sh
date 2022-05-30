#! /bin/bash

set -e

YASM="yasm"
YASM_DOWNLOAD_URL="http://www.tortall.net/projects/yasm/releases/"
YASM_VERSION="1.3.0"
YASM_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
--enable-static
--disable-shared
"


echo "==========================download yasm=========================="
if [ ! -e $YASM".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" > $YASM".tar.gz"
 else
  wget $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" -O $YASM".tar.gz"
 fi
fi
 
echo "==========================unzip yasm=========================="
if [ -e $YASM".tar.gz" ]; then
 if [ -e $YASM"-"$YASM_VERSION ]; then
  rm -rf $YASM"-"$YASM_VERSION
 fi
 tar zxvf $YASM".tar.gz"
fi

echo "==========================build yasm=========================="
if [ -e $YASM"-"$YASM_VERSION ]; then
 cd $YASM"-"$YASM_VERSION
 $YASM_CONFIGURE_COMMAND
 make clean
 make
 make install
fi
cd ..
echo "==========================yasm build successful!=========================="

