#! /bin/bash
# https://www.cnblogs.com/candycaicai/p/4689459.html
set -e

SYSTEM=`uname`
MY_DIR=`pwd`
PREFIX=${MY_DIR}/output

PKG_CONFIG_GIT_URL="git://anongit.freedesktop.org/pkg-config"
PKG_CONFIG="pkg-config"
PKG_CONFIG_VERSION="0.29.2"
PKG_CONFIG_URL="https://pkg-config.freedesktop.org/releases/"

FFMPEG_DIR="FFmpeg"
FFMPEG_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--enable-gpl
--enable-version3
--enable-nonfree
--enable-shared
--enable-debug
--enable-libx264
"

X264_DIR="x264"
X264_GIT_URL="http://git.videolan.org/git/x264.git x264"
X264_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
--enable-static
--disable-asm
"

LIBVPX="libvpx"
LIBVPX_URL="http://ftp.osuosl.org/pub/blfs/conglomeration/libvpx/"
LIBVPX_VERSION="1.7.0"
LIBVPX_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--disable-examples 
--disable-unit-tests
"

OPUS="opus"
OPUS_URL="http://downloads.xiph.org/releases/opus/"
OPUS_VERSION="1.1"
OPUS_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--disable-shared
"

FDK_AAC="fdk-aac"
FDK_AAC_VERSION="2.0.0"
FDK_AAC_URL="https://downloads.sourceforge.net/opencore-amr/"
FDK_AAC_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--bindir=$PREFIX/bin
--disable-shared
"

LAME="lame"
LAME_VERSION="3.100"
LAME_URL="https://sourceforge.net/projects/lame/files/lame/3.100/lame"
LAME_CONFIGURE_COMMAND="./configure
--prefix=$PREFIX
--enable-nasm
--disable-shared
"

YASM="yasm"
YASM_DOWNLOAD_URL="http://www.tortall.net/projects/yasm/releases/"
YASM_VERSION="1.2.0"
YASM_CONFIGURE_COMMAND="./configure 
--prefix=$PREFIX
--bindir=$PREFIX/bin"

CLONE_GIT_COMMAND="git clone "
FFMPEG_GIT_URL="git@github.com:FFmpeg/FFmpeg.git"

cd $MY_DIR

if [ -e "output" ]; then
 rm -rf output 
 mkdir output
 mkdir output/bin
else
 mkdir output
fi

if [ ! -e $FFMPEG_DIR ]; then
 echo "==========================clone FFmpeg=========================="
 $CLONE_GIT_COMMAND$FFMPEG_GIT_URL
fi

if [ ! -e $X264_DIR ]; then
 echo "==========================clone x264=========================="
 $CLONE_GIT_COMMAND$X264_GIT_URL
fi

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

echo "==========================download opus=========================="
if [ ! -e $OPUS".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl $OPUS_URL$OPUS"-"$OPUS_VERSION".tar.gz" > $OPUS".tar.gz"
 else
  wget $OPUS_URL$OPUS"-"$OPUS_VERSION".tar.gz" -O $OPUS".tar.gz"
 fi
fi
 
echo "==========================unzip opus=========================="
if [ -e $OPUS".tar.gz" ]; then
 if [ -e $OPUS"-"$OPUS_VERSION ]; then
  rm -rf $OPUS"-"$OPUS_VERSION
 fi
 tar zxvf $OPUS".tar.gz"
fi

echo "==========================download lame=========================="
if [ ! -e $LAME".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl $LAME_URL$LAME"-"$LAME_VERSION".tar.gz" > $LAME".tar.gz"
 else
  wget $LAME_URL$LAME"-"$LAME_VERSION".tar.gz" -O $LAME".tar.gz"
 fi
fi

echo "==========================unzip lame=========================="
if [ -e $LAME".tar.gz" ]; then
 if [ -e $LAME"-"$LAME_VERSION ]; then
  rm -rf $LAME"-"$LAME_VERSION
 fi
 tar zxvf $LAME".tar.gz"
fi

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


echo "==========================download pkg-config=========================="
if [ ! -e $PKG_CONFIG".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
  curl $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" > $PKG_CONFIG".tar.gz"
 else
  wget $PKG_CONFIG_URL$PKG_CONFIG"-"$PKG_CONFIG_VERSION".tar.gz" -O $PKG_CONFIG".tar.gz"
 fi
fi

echo "==========================unzip pkg-config=========================="
if [ -e $PKG_CONFIG".tar.gz" ]; then
 if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION ]; then 
  rm -rf $PKG_CONFIG"-"$PKG_CONFIG_VERSION
 fi 
 tar zxvf $PKG_CONFIG".tar.gz"
fi
 
echo "==========================download yasm=========================="
if [ ! -e $YASM".tar.gz" ]; then
 if [ $SYSTEM == "Darwin" ]; then
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

echo "==========================build pkg-config=========================="
if [ -e $PKG_CONFIG"-"$PKG_CONFIG_VERSION ]; then
 cd $PKG_CONFIG"-"$PKG_CONFIG_VERSION
 ./configure --with-internal-glib
 make
 sudo make install
 make distclean
fi
echo "==========================pkg-config build successful!=========================="


echo "==========================build opus=========================="
if [ -e $OPUS"-"$OPUS_VERSION ]; then
 cd $OPUS"-"$OPUS_VERSION
 $OPUS_CONFIGURE_COMMAND
 make
 sudo make install
 make distclean
fi
echo "==========================opus build successful!=========================="

echo "==========================build lame=========================="
cd ..
if [ -e $LAME"-"$LAME_VERSION ]; then
 cd $LAME"-"$LAME_VERSION
 $LAME_CONFIGURE_COMMAND
 make
 sudo make install
 make distclean
fi
echo "==========================lame build successful!=========================="


echo "==========================build fdk_aac=========================="
cd ..
if [ -e $FDK_AAC"-"$FDK_AAC_VERSION ]; then
 cd $FDK_AAC"-"$FDK_AAC_VERSION
 $FDK_AAC_CONFIGURE_COMMAND
 make
 sudo make install
 make distclean
fi
echo "==========================fdk_aac build successful!=========================="


echo "==========================build yasm=========================="
cd ..
if [ -e $YASM"-"$YASM_VERSION ]; then
 cd $YASM"-"$YASM_VERSION
 $YASM_CONFIGURE_COMMAND
 make
 sudo make install
 make distclean
fi
echo "==========================yasm build successful!=========================="


echo "==========================build x264=========================="
cd ..
if [ -e $X264_DIR ]; then
 cd $X264_DIR
 $X264_CONFIGURE_COMMAND
 make
 sudo make install
 make distclean
fi
echo "==========================x264 build successful!=========================="

echo "==========================build libvpx=========================="
if [ -e $LIBVPX"-"$LIBVPX_VERSION ]; then
 cd $LIBVPX"-"$LIBVPX_VERSION
 $LIBVPX_CONFIGURE_COMMAND
 make
 sudo make install
 make distclean
 fi
echo "==========================libpx build successful!=========================="

echo "==========================build ffmpeg=========================="
cd ..
if [ -e $FFMPEG_DIR ]; then
 cd $FFMPEG_DIR
 $FFMPEG_CONFIGURE_COMMAND
 make
 sudo make install
 make distclean
fi
echo "==========================ffmpeg build successful!=========================="
