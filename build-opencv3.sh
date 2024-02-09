#!/usr/bin/env bash
# build opencv 3.x

function cmakeBuild() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_BUILD_TYPE=$1 \
    -DCMAKE_CONFIGURATION_TYPES=$1 \
    -DCMAKE_INSTALL_PREFIX=install \
    $(cat ../opencv3_cmake_options.txt) \
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
    $(cat ../opencv3_cmake_options.txt) \
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
