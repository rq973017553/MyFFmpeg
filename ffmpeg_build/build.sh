#! /bin/bash

set -e

source ./config.sh

cd $MY_DIR

PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

if [ -e "output" ]; then
 rm -rf output
fi
mkdir output
mkdir output/bin

source build_pkg_config.sh
cd ..

source build_yasm.sh
cd ..

source build_libx264.sh
cd ..

source build_libfdk_aac.sh
cd ..

source build_libmp3lame.sh
cd ..

source build_libopus.sh
cd ..

source build_libvpx.sh
cd ..

source build_ffmpeg.sh
