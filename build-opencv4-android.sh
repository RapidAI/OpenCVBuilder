#!/usr/bin/env bash

function cmakeParams() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CONFIGURATION_TYPES=Release \
    -DCMAKE_INSTALL_PREFIX=install \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI="$1" -DANDROID_ARM_NEON=ON \
    $(cat ../opencv4_cmake_options.txt) -DBUILD_opencv_world=OFF \
    ..
  cmake --build . --config Release -j $NUM_THREADS
  cmake --build . --config Release --target install
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
 echo "set ANDROID_NDK=$1"
 export ANDROID_NDK="$1"
else
 echo "input ANDROID_NDK is empty, use default"
fi

# build
cmakeParams "armeabi-v7a"
cmakeParams "arm64-v8a"
cmakeParams "x86"
cmakeParams "x86_64"

# pack
mkdir opencv-android
cp -rf build-x86/install/* opencv-android/
cp -rf build-x86_64/install/* opencv-android/
cp -rf build-armeabi-v7a/install/* opencv-android/
cp -rf build-arm64-v8a/install/* opencv-android/
