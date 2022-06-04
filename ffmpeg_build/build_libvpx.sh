#! /bin/bash
# VP8/VP9视频编码器，ffmpeg通过编译参数--enable-libvpx来开启

set -e

PATH=$PATH:$PREFIX/bin # 设置环境变量，将$PREFIX/bin目录下的可执行二进制文件设置进去，方便调用

LIBVPX="libvpx"
LIBVPX_URL="http://ftp.osuosl.org/pub/blfs/conglomeration/libvpx/"
LIBVPX_VERSION="1.11.0"
LIBVPX_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--enable-vp8
--enable-vp9
--enable-vp9-highbitdepth
--enable-vp9-postproc
--enable-vp9-temporal-denoising
--disable-examples
--disable-unit-tests
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
if [ ! -e $LIBVPX"-"$LIBVPX_VERSION".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $LIBVPX_URL$LIBVPX"-"$LIBVPX_VERSION".tar.gz" > $LIBVPX"-"$LIBVPX_VERSION".tar.gz"
 else
  wget $LIBVPX_URL$LIBVPX"-"$LIBVPX_VERSION".tar.gz" -O $LIBVPX"-"$LIBVPX_VERSION".tar.gz"
 fi
fi
 
echo "==========================unzip libvpx=========================="
if [ -e $LIBVPX"-"$LIBVPX_VERSION".tar.gz" ]; then
 if [ -e $LIBVPX"-"$LIBVPX_VERSION ]; then
  rm -rf $LIBVPX"-"$LIBVPX_VERSION
 fi
 tar zxvf $LIBVPX"-"$LIBVPX_VERSION".tar.gz"
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
