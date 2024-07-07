#!/usr/bin/env bash
# ./build-opencv3-linux-java.sh "386"
# ./build-opencv3-linux-java.sh "amd64"
# ./build-opencv3-linux-java.sh "arm"
# ./build-opencv3-linux-java.sh "arm64"
# ./build-opencv3-linux-java.sh "ppc64le"

if [ "$1" ]; then
  echo "TARGET_ARCH=$1"
  export TARGET_ARCH="$1"
else
  echo "Default target: amd64"
  export TARGET_ARCH="amd64"
fi

HOST_OS=$(uname -s)
NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
BUILD_TYPE="Release"

# get gcc version
export compiler=$(which gcc)
MAJOR=$(echo __GNUC__ | $compiler -E -xc - | tail -n 1)
MINOR=$(echo __GNUC_MINOR__ | $compiler -E -xc - | tail -n 1)
PATCHLEVEL=$(echo __GNUC_PATCHLEVEL__ | $compiler -E -xc - | tail -n 1)

if [ $HOST_OS == "Linux" ] && [ $TARGET_ARCH == "arm64" ] && [ "$MAJOR.$MINOR.$PATCHLEVEL" == "4.8.4" ]; then
  echo "Linux arm64 gcc version is 4.8.4, turn off libwebp"
  DISABLE_OPTION="-DBUILD_WEBP=OFF -DWITH_WEBP=OFF"
elif [ $HOST_OS == "Linux" ] && [ $TARGET_ARCH == "386" ] && [ "$MAJOR.$MINOR.$PATCHLEVEL" == "4.8.4" ]; then
  echo "Linux 386 gcc version is 4.8.4, turn off openexr"
  DISABLE_OPTION="-DBUILD_OPENEXR=OFF -DWITH_OPENEXR=OFF"
else
  echo "Other gcc version"
  DISABLE_OPTION=""
fi

mkdir -p "build-$BUILD_TYPE"
pushd "build-$BUILD_TYPE"
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
  -DCMAKE_INSTALL_PREFIX=install \
  $(cat ../opencv3_cmake_options.txt) \
  $DISABLE_OPTION \
  -DBUILD_FAT_JAVA_LIB=ON \
  -DBUILD_JAVA=ON \
  -DBUILD_opencv_java=ON \
  -DBUILD_opencv_flann=ON \
  ..
cmake --build . -j $NUM_THREADS
cmake --build . --target install
popd

