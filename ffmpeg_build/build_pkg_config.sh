#! /bin/bash

set -e

PKG_CONFIG="pkg-config"
PKG_CONFIG_VERSION="0.29.2"
PKG_CONFIG_URL="https://pkg-config.freedesktop.org/releases/"
PKG_CONFIG_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--with-internal-glib
"

if [[ "$enableShared" == true  ]]; then
 PKG_CONFIG_CONFIGURE_COMMAND=$PKG_CONFIG_CONFIGURE_COMMAND"
 --enable-shared
 "
else
 PKG_CONFIG_CONFIGURE_COMMAND=$PKG_CONFIG_CONFIGURE_COMMAND"
 --enable-static
 "
fi

echo "==========================download pkg-config=========================="
if [ ! -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" ]; then
 if [[ $SYSTEM == "Darwin" ]]; then
  curl $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" > $PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz"
 else
  wget $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" -O $PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz"
 fi
fi
 
echo "==========================unzip pkg-config=========================="
if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" ]; then
 if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION ]; then
  rm -rf $PKG_CONFIG"-"$PKG_CONFIG_VERSION
 fi
 tar zxvf $PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz"
fi

echo "==========================build pkg-config=========================="
if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION ]; then
 cd $PKG_CONFIG"-"$PKG_CONFIG_VERSION
 $PKG_CONFIG_CONFIGURE_COMMAND
 make clean
 make -j${cpu_num}
 make install
fi
cd $MY_DIR
echo "==========================pkg-config build successful!=========================="
