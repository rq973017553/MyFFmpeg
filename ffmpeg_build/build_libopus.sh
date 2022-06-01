#! /bin/bash
# 编码Opus音频

set -e

OPUS="opus"
OPUS_URL="http://downloads.xiph.org/releases/opus/"
OPUS_VERSION="1.3.1"
OPUS_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
"

if [[ "$enableShared" == true  ]]; then
 OPUS_CONFIGURE_COMMAND=$OPUS_CONFIGURE_COMMAND"
 --enable-shared
 --disable-static
 "
else
 OPUS_CONFIGURE_COMMAND=$OPUS_CONFIGURE_COMMAND"
 --enable-static
 --disable-shared
 "
fi

echo "==========================download libopus=========================="
if [ ! -e $OPUS".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $OPUS_URL$OPUS"-"$OPUS_VERSION".tar.gz" > $OPUS".tar.gz"
 else
  wget $OPUS_URL$OPUS"-"$OPUS_VERSION".tar.gz" -O $OPUS".tar.gz"
 fi
fi
 
echo "==========================unzip libopus=========================="
if [ -e $OPUS".tar.gz" ]; then
 if [ -e $OPUS"-"$OPUS_VERSION ]; then
  rm -rf $OPUS"-"$OPUS_VERSION
 fi
 tar zxvf $OPUS".tar.gz"
fi

echo "==========================build libopus=========================="
if [ -e $OPUS"-"$OPUS_VERSION ]; then
 cd $OPUS"-"$OPUS_VERSION
 $OPUS_CONFIGURE_COMMAND
 make clean
 make -j${cpu_num}
 make install
fi
cd $MY_DIR
echo "==========================libopus build successful!=========================="
