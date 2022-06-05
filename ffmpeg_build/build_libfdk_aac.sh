#! /bin/bash
# 编码AAC音频，ffmpeg通过编译参数--enable-libfdk-aac来开启
set -e

FDK_AAC="fdk-aac"
FDK_AAC_VERSION="2.0.2"
FDK_AAC_URL="https://downloads.sourceforge.net/opencore-amr/"
FDK_AAC_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
"

if [[ "$enableShared" == true  ]]; then
 FDK_AAC_CONFIGURE_COMMAND=$FDK_AAC_CONFIGURE_COMMAND"
 --enable-shared
 --disable-static
 "
else
 FDK_AAC_CONFIGURE_COMMAND=$FDK_AAC_CONFIGURE_COMMAND"
 --enable-static
 --disable-shared
 "
fi

echo "==========================download fdk-aac=========================="
if [ ! -e $FDK_AAC"-"$FDK_AAC_VERSION".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $FDK_AAC_URL$FDK_AAC"-"$FDK_AAC_VERSION".tar.gz" > $FDK_AAC"-"$FDK_AAC_VERSION".tar.gz"
 else
  wget $FDK_AAC_URL$FDK_AAC"-"$FDK_AAC_VERSION".tar.gz" -O $FDK_AAC"-"$FDK_AAC_VERSION".tar.gz"
 fi
fi
 
echo "==========================unzip fdk-aac=========================="
if [ -e $FDK_AAC"-"$FDK_AAC_VERSION".tar.gz" ]; then
 if [ -e $FDK_AAC"-"$FDK_AAC_VERSION ]; then
  rm -rf $FDK_AAC"-"$FDK_AAC_VERSION
 fi
 tar zxvf $FDK_AAC"-"$FDK_AAC_VERSION".tar.gz"
fi

echo "==========================build fdk_aac=========================="
if [ -e $FDK_AAC"-"$FDK_AAC_VERSION ]; then
 cd $FDK_AAC"-"$FDK_AAC_VERSION
 $FDK_AAC_CONFIGURE_COMMAND
 make clean
 make -j${cpu_num}
 make install
fi
cd $MY_DIR
echo "==========================fdk_aac build successful!=========================="
