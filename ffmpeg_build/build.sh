#! /bin/bash

set -e

source ./tools.sh
source ./config.sh

cd $MY_DIR

startTime=`date +%Y%m%d-%H:%M:%S`
startTime_s=`date +%s`

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
. build_libx265.sh
. build_ffmpeg.sh


endTime=`date +%Y%m%d-%H:%M:%S`
endTime_s=`date +%s`

sumTime=$[ $endTime_s - $startTime_s ]

echo "Total Compilation Time $sumTime seconds"

echo "==========================test ffmpeg!=========================="

if [[ "$enableShared" == true  ]]; then
 export LD_LIBRARY_PATH=$MY_DIR/output/lib/
 cd $MY_DIR/output/bin
 ./ffmpeg -version
else
 cd $MY_DIR/output/bin
 ./ffmpeg -version
fi
