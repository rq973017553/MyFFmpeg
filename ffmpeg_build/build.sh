#########################################################################
# sudo apt-get update // 从服务器获取软件列表，并在本地保存为文件
# sudo apt-get upgrade // 本地安装软件与本地软件列表对比，如本地安装版本低，会提示更新
#
# sudo apt-get install git // 下载源码
# sudo apt-get install vim // 编辑器
# sudo apt-get install make // 编译工具
# sudo apt-get install cmake // x265所需要的编译工具
#
# 解决ffplay播放视频报错:Could not initialize SDL - No available video device问题
# sudo apt-get install libx11-dev
# sudo apt-get install xorg-dev
#
# 解决ffplay播放音频报错:Could not initialize SDL - Audio target 'pulse' not available,以及No such audio device问题
# sudo apt-get install libpulse-dev
# 以下这两个我只安装了libasound2也是可以的，如果不行就两个都安装
# sudo apt-get install libasound2
# sudo apt-get install libasound2-dev
#########################################################################

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
. build_sdl2.sh
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
