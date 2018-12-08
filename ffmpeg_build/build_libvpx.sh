#! /bin/bash
# VP8/VP9视频编码器，编译参数--enable-libvpx

set -e

LIBVPX="libvpx"
LIBVPX_URL="http://ftp.osuosl.org/pub/blfs/conglomeration/libvpx/"
LIBVPX_VERSION="1.7.0"
LIBVPX_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--enable-shared
--disable-static
--disable-examples
--disable-unit-tests
"

echo "==========================download libvpx=========================="
if [ ! -e $LIBVPX".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
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
 make
 make install
 make distclean
fi
echo "==========================libvpx build successful!=========================="
