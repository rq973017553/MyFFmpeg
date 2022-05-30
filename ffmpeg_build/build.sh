#! /bin/bash

set -e

source ./config.sh

cd $MY_DIR

if [ -e "output" ]; then
 rm -rf output
fi
mkdir output
mkdir output/bin

. build_pkg_config.sh
. build_libfdk_aac.sh
. build_libmp3lame.sh
. build_libopus.sh
. build_yasm.sh
. build_libvpx.sh
. build_libx264.sh
. build_ffmpeg.sh
