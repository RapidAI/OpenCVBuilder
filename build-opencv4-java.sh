#!/usr/bin/env bash
# build opencv 4.x base on https://github.com/nihui/opencv-mobile/blob/master/opencv4_cmake_options.txt

function cmakeBuild() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_BUILD_TYPE=$1 \
    -DCMAKE_CONFIGURATION_TYPES=$1 \
    -DCMAKE_INSTALL_PREFIX=install \
    $(cat ../opencv4_cmake_options.txt) \
    -DBUILD_FAT_JAVA_LIB=ON \
    -DBUILD_JAVA=ON \
    -DBUILD_opencv_java=ON \
    -DBUILD_opencv_flann=ON \
    ..
  cmake --build . -j $NUM_THREADS
  cmake --build . --target install
  popd
}

function cmakeCrossBuild() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_TOOLCHAIN_FILE=../musl-cross.toolchain.cmake \
    -DCMAKE_BUILD_TYPE=$1 \
    -DCMAKE_CONFIGURATION_TYPES=$1 \
    -DCMAKE_INSTALL_PREFIX=install \
    $(cat ../opencv4_cmake_options.txt) \
    -DBUILD_FAT_JAVA_LIB=ON \
    -DBUILD_JAVA=ON \
    -DBUILD_opencv_java=ON \
    -DBUILD_opencv_flann=ON \
    ..
  cmake --build . -j $NUM_THREADS
  cmake --build . --target install
  popd
}

sysOS=$(uname -s)
NUM_THREADS=1

if [ $sysOS == "Darwin" ]; then
  #echo "I'm MacOS"
  NUM_THREADS=$(sysctl -n hw.ncpu)
  cmakeBuild "Release"
elif [ $sysOS == "Linux" ]; then
  #echo "I'm Linux"
  NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
  if [ "$1" ] && [ "$2" ]; then
    echo "TOOLCHAIN_NAME=$1"
    echo "TOOLCHAIN_PATH=$2"
    export TOOLCHAIN_NAME="$1"
    export TOOLCHAIN_PATH="$2"
    echo "cross build"
    cmakeCrossBuild "Release"
  else
    echo "native build"
    cmakeBuild "Release"
  fi
else
  echo "Other OS: $sysOS"
fi

