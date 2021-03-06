#! /bin/bash
# 编码AAC音频，编译参数--enable-libfdk-aac
set -e

FDK_AAC="fdk-aac"
FDK_AAC_VERSION="2.0.0"
FDK_AAC_URL="https://downloads.sourceforge.net/opencore-amr/"
FDK_AAC_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
--disable-shared
--enable-static
"

echo "==========================download fdk-aac=========================="
if [ ! -e $FDK_AAC".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl $FDK_AAC_URL$FDK_AAC"-"$FDK_AAC_VERSION".tar.gz" > $FDK_AAC".tar.gz"
 else
  wget $FDK_AAC_URL$FDK_AAC"-"$FDK_AAC_VERSION".tar.gz" -O $FDK_AAC".tar.gz"
 fi
fi
 
echo "==========================unzip fdk-aac=========================="
if [ -e $FDK_AAC".tar.gz" ]; then
 if [ -e $FDK_AAC"-"$FDK_AAC_VERSION ]; then
  rm -rf $FDK_AAC"-"$FDK_AAC_VERSION
 fi
 tar zxvf $FDK_AAC".tar.gz"
fi

echo "==========================build fdk_aac=========================="
if [ -e $FDK_AAC"-"$FDK_AAC_VERSION ]; then
 cd $FDK_AAC"-"$FDK_AAC_VERSION
 $FDK_AAC_CONFIGURE_COMMAND
 make clean
 make
 make install
fi
cd ..
echo "==========================fdk_aac build successful!=========================="
