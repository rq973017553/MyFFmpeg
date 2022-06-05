#! /bin/bash
# 编译vpx和ffmpeg的时候需要用到的yasm开源汇编库
set -e

YASM="yasm"
YASM_DOWNLOAD_URL="http://www.tortall.net/projects/yasm/releases/"
YASM_VERSION="1.3.0"
YASM_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
"
echo "==========================download yasm=========================="
if [ ! -e $YASM"-"$YASM_VERSION".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" > $YASM"-"$YASM_VERSION".tar.gz"
 else
  wget $YASM_DOWNLOAD_URL$YASM"-"$YASM_VERSION".tar.gz" -O $YASM"-"$YASM_VERSION".tar.gz"
 fi
fi
 
echo "==========================unzip yasm=========================="
if [ -e $YASM"-"$YASM_VERSION".tar.gz" ]; then
 if [ -e $YASM"-"$YASM_VERSION ]; then
  rm -rf $YASM"-"$YASM_VERSION
 fi
 tar zxvf $YASM"-"$YASM_VERSION".tar.gz"
fi

echo "==========================build yasm=========================="
if [ -e $YASM"-"$YASM_VERSION ]; then
 cd $YASM"-"$YASM_VERSION
 $YASM_CONFIGURE_COMMAND
 make clean
 make -j${cpu_num}
 make install
fi
cd $MY_DIR
echo "==========================yasm build successful!=========================="

