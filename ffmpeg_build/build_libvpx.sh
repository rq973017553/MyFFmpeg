#! /bin/bash
# VP8/VP9视频编码器，编译参数--enable-libvpx

set -e

PATH=$PATH:$PREFIX/bin

LIBVPX="libvpx"
LIBVPX_URL="http://ftp.osuosl.org/pub/blfs/conglomeration/libvpx/"
LIBVPX_VERSION="1.11.0"
LIBVPX_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--disable-examples
--disable-unit-tests
--enable-vp9-highbitdepth
--as=yasm
"

if [[ "$enableShared" == true  ]]; then
 LIBVPX_CONFIGURE_COMMAND=$LIBVPX_CONFIGURE_COMMAND"
 --enable-shared
 --disable-static
 "
else
 LIBVPX_CONFIGURE_COMMAND=$LIBVPX_CONFIGURE_COMMAND"
 --enable-static
 --disable-shared
 "
fi

echo "==========================download libvpx=========================="
if [ ! -e $LIBVPX".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $LIBVPX_URL$LIBVPX"-"$LIBVPX_VERSION".tar.gz" > $LIBVPX".tar.gz"
 else
  wget $LIBVPX_URL$LIBVPX"-"$LIBVPX_VERSION".tar.gz" -O $LIBVPX".tar.gz"
 fi
fi
 
echo "==========================unzip libvpx=========================="
if [ -e $LIBVPX".tar.gz" ]; then
 if [ -e $LIBVPX"-"$LIBVPX_VERSION ]; then
  rm -rf $LIBVPX"-"$LIBVPX_VERSION
 fi
 tar zxvf $LIBVPX".tar.gz"
fi

echo "==========================build libvpx=========================="
if [ -e $LIBVPX"-"$LIBVPX_VERSION ]; then
 cd $LIBVPX"-"$LIBVPX_VERSION
 $LIBVPX_CONFIGURE_COMMAND
 make clean
 make -j${cpu_num}
 make install
fi
cd $MY_DIR
echo "==========================libvpx build successful!=========================="
