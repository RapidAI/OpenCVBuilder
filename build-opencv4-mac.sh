#!/usr/bin/env bash
# ./build-opencv4-mac.sh "x86_64"
# ./build-opencv4-mac.sh "arm64"

if [ "$1" ]; then
  echo "TARGET_ARCH=$1"
  TARGET_ARCH="$1"
else
  echo "TARGET_ARCH use default x86_64"
  TARGET_ARCH="x86_64"
fi

NUM_THREADS=$(sysctl -n hw.ncpu)
BUILD_TYPE="Release"

mkdir -p "build-$BUILD_TYPE-$TARGET_ARCH"
pushd "build-$BUILD_TYPE-$TARGET_ARCH" || exit
cmake -DCMAKE_SYSTEM_NAME="Darwin" -DCMAKE_SYSTEM_PROCESSOR="$TARGET_ARCH" -DCMAKE_OSX_ARCHITECTURES="$TARGET_ARCH" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="10.9" \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
  -DCMAKE_INSTALL_PREFIX=install \
  $(cat ../opencv4_cmake_options.txt) \
    ..
cmake --build . --config $BUILD_TYPE -j $NUM_THREADS
cmake --build . --config $BUILD_TYPE --target install
popd