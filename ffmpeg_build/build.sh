#! /bin/bash

set -e

source ./config.sh

cd $MY_DIR

if [ -e "output" ]; then
 rm -rf output
fi
mkdir output
mkdir output/bin

source build_pkg_config.sh
source build_yasm.sh
source build_libx264.sh
source build_libfdk_aac.sh
source build_libmp3lame.sh
source build_libopus.sh
source build_libvpx.sh
source build_ffmpeg.sh
