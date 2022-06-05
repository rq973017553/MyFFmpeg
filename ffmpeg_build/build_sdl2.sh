#! /bin/bash
# SDL2 生成ffplay需要
set -e

SDL2="SDL2"
SDL2_VERSION="2.0.22"
SDL2_URL="http://www.libsdl.org/release/"
SDL2_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
"

if [[ "$enableShared" == true  ]]; then
 SDL2_CONFIGURE_COMMAND=$SDL2_CONFIGURE_COMMAND"
 --enable-shared
 --disable-static
 "
else
 SDL2_CONFIGURE_COMMAND=$SDL2_CONFIGURE_COMMAND"
 --enable-static
 --disable-shared
 "
fi

echo "==========================download SDL2=========================="
if [ ! -e $SDL2"-"$SDL2_VERSION".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $SDL2_URL$SDL2"-"$SDL2_VERSION".tar.gz" > $SDL2"-"$SDL2_VERSION".tar.gz"
 else
  wget $SDL2_URL$SDL2"-"$SDL2_VERSION".tar.gz" -O $SDL2"-"$SDL2_VERSION".tar.gz"
 fi
fi
 
echo "==========================unzip SDL2=========================="
if [ -e $SDL2"-"$SDL2_VERSION".tar.gz" ]; then
 if [ -e $SDL2"-"$SDL2_VERSION ]; then
  rm -rf $SDL2"-"$SDL2_VERSION
 fi
 tar zxvf $SDL2"-"$SDL2_VERSION".tar.gz"
fi

echo "==========================build SDL2=========================="
if [ -e $SDL2"-"$SDL2_VERSION ]; then
 cd $SDL2"-"$SDL2_VERSION
 $SDL2_CONFIGURE_COMMAND
 make clean
 make -j${cpu_num}
 make install
fi
cd $MY_DIR
echo "==========================SDL2 build successful!=========================="
