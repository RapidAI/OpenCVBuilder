#!/usr/bin/env bash

function cmakeParams() {
  mkdir -p "build-$1"
  pushd "build-$1"
  $OHOS_CMAKE -DCMAKE_BUILD_TYPE=Release -DCMAKE_CONFIGURATION_TYPES=Release \
    -DCMAKE_INSTALL_PREFIX=install \
    -DCMAKE_TOOLCHAIN_FILE="$OHOS_NDK/build/cmake/ohos.toolchain.cmake" \
    -DOHOS_ARCH="$1" \
    $(cat ../opencv4_cmake_options.txt) -DBUILD_opencv_world=OFF \
    ..
  $OHOS_CMAKE --build . --config Release -j $NUM_THREADS
  $OHOS_CMAKE --build . --config Release --target install
  popd
}

sysOS=$(uname -s)
NUM_THREADS=1

if [ $sysOS == "Darwin" ]; then
  #echo "I'm MacOS"
  NUM_THREADS=$(sysctl -n hw.ncpu)
elif [ $sysOS == "Linux" ]; then
  #echo "I'm Linux"
  NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
else
  echo "Other OS: $sysOS"
fi

if [ "$1" ]; then
 echo "set OHOS_NDK=$1"
 export OHOS_NDK="$1"
 export OHOS_CMAKE="$1/build-tools/cmake/bin/cmake"
else
 echo "input OHOS_NDK is empty, use default"
fi

# build
cmakeParams "x86_64"
cmakeParams "armeabi-v7a"
cmakeParams "arm64-v8a"

# pack
mkdir opencv-ohos
cp -rf build-x86_64/install opencv-ohos/x86_64
cp -rf build-armeabi-v7a/install opencv-ohos/armeabi-v7a
cp -rf build-arm64-v8a/install opencv-ohos/arm64-v8a