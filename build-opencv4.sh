#!/usr/bin/env bash
# build opencv 4.6.x base on https://github.com/nihui/opencv-mobile/blob/master/opencv4_cmake_options.txt

function cmakeParams() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_CONFIGURATION_TYPES=$1 \
    -DCMAKE_INSTALL_PREFIX=install \
    $(cat ../opencv4_cmake_options.txt) \
    ..
  cmake --build . --config $1 -j $NUM_THREADS
  cmake --build . --config $1 --target install
  popd
}

sysOS=$(uname -s)
NUM_THREADS=1

if [ $sysOS == "Darwin" ]; then
  #echo "I'm MacOS"
  NUM_THREADS=$(sysctl -n hw.ncpu)
  cmakeParams "Release"
elif [ $sysOS == "Linux" ]; then
  #echo "I'm Linux"
  NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
  cmakeParams "Release"
else
  echo "Other OS: $sysOS"
fi
