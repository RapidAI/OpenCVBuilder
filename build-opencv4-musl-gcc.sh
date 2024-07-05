#!/usr/bin/env bash
#./build-opencv4-musl-gcc.sh "aarch64-linux-musl" "/opt/aarch64-linux-musl"
#./build-opencv4-musl-gcc.sh "aarch64_be-linux-musl" "/opt/aarch64_be-linux-musl"
#./build-opencv4-musl-gcc.sh "arm-linux-musleabi" "/opt/arm-linux-musleabi"
#./build-opencv4-musl-gcc.sh "arm-linux-musleabihf" "/opt/arm-linux-musleabihf"
#./build-opencv4-musl-gcc.sh "armeb-linux-musleabi" "/opt/armeb-linux-musleabi"
#./build-opencv4-musl-gcc.sh "armeb-linux-musleabihf" "/opt/armeb-linux-musleabihf"
#./build-opencv4-musl-gcc.sh "armel-linux-musleabi" "/opt/armel-linux-musleabi"
#./build-opencv4-musl-gcc.sh "armel-linux-musleabihf" "/opt/armel-linux-musleabihf"
#./build-opencv4-musl-gcc.sh "armv5l-linux-musleabi" "/opt/armv5l-linux-musleabi"
#./build-opencv4-musl-gcc.sh "armv5l-linux-musleabihf" "/opt/armv5l-linux-musleabihf"
#./build-opencv4-musl-gcc.sh "armv6-linux-musleabi" "/opt/armv6-linux-musleabi"
#./build-opencv4-musl-gcc.sh "armv6-linux-musleabihf" "/opt/armv6-linux-musleabihf"
#./build-opencv4-musl-gcc.sh "armv7l-linux-musleabihf" "/opt/armv7l-linux-musleabihf"
#./build-opencv4-musl-gcc.sh "armv7m-linux-musleabi" "/opt/armv7m-linux-musleabi"
#./build-opencv4-musl-gcc.sh "armv7r-linux-musleabihf" "/opt/armv7r-linux-musleabihf"
#./build-opencv4-musl-gcc.sh "i486-linux-musl" "/opt/i486-linux-musl"
#./build-opencv4-musl-gcc.sh "i686-linux-musl" "/opt/i686-linux-musl"
#./build-opencv4-musl-gcc.sh "m68k-linux-musl" "/opt/m68k-linux-musl"
#./build-opencv4-musl-gcc.sh "microblaze-linux-musl" "/opt/microblaze-linux-musl"
#./build-opencv4-musl-gcc.sh "microblazeel-linux-musl" "/opt/microblazeel-linux-musl"
#./build-opencv4-musl-gcc.sh "mips-linux-musl" "/opt/mips-linux-musl"
#./build-opencv4-musl-gcc.sh "mips-linux-muslsf" "/opt/mips-linux-muslsf"
#./build-opencv4-musl-gcc.sh "mips-linux-musln32sf" "/opt/mips-linux-musln32sf"
#./build-opencv4-musl-gcc.sh "mips64-linux-musl" "/opt/mips64-linux-musl"
#./build-opencv4-musl-gcc.sh "mips64-linux-musln32" "/opt/mips64-linux-musln32"
#./build-opencv4-musl-gcc.sh "mips64-linux-musln32sf" "/opt/mips64-linux-musln32sf"
#./build-opencv4-musl-gcc.sh "mips64el-linux-musl" "/opt/mips64el-linux-musl"
#./build-opencv4-musl-gcc.sh "mips64el-linux-musln32" "/opt/mips64el-linux-musln32"
#./build-opencv4-musl-gcc.sh "mips64el-linux-musln32sf" "/opt/mips64el-linux-musln32sf"
#./build-opencv4-musl-gcc.sh "mipsel-linux-musl" "/opt/mipsel-linux-musl"
#./build-opencv4-musl-gcc.sh "mipsel-linux-musln32" "/opt/mipsel-linux-musln32"
#./build-opencv4-musl-gcc.sh "mipsel-linux-musln32sf" "/opt/mipsel-linux-musln32sf"
#./build-opencv4-musl-gcc.sh "mipsel-linux-muslsf" "/opt/mipsel-linux-muslsf"
#./build-opencv4-musl-gcc.sh "or1k-linux-musl" "/opt/or1k-linux-musl"
#./build-opencv4-musl-gcc.sh "powerpc-linux-musl" "/opt/powerpc-linux-musl"
#./build-opencv4-musl-gcc.sh "powerpc-linux-muslsf" "/opt/powerpc-linux-muslsf"
#./build-opencv4-musl-gcc.sh "powerpc64-linux-musl" "/opt/powerpc64-linux-musl"
#./build-opencv4-musl-gcc.sh "powerpc64le-linux-musl" "/opt/powerpc64le-linux-musl"
#./build-opencv4-musl-gcc.sh "powerpcle-linux-musl" "/opt/powerpcle-linux-musl"
#./build-opencv4-musl-gcc.sh "powerpcle-linux-muslsf" "/opt/powerpcle-linux-muslsf"
#./build-opencv4-musl-gcc.sh "riscv32-linux-musl" "/opt/riscv32-linux-musl"
#./build-opencv4-musl-gcc.sh "riscv64-linux-musl" "/opt/riscv64-linux-musl"
#./build-opencv4-musl-gcc.sh "s390x-linux-musl" "/opt/s390x-linux-musl"
#./build-opencv4-musl-gcc.sh "sh2-linux-musl" "/opt/sh2-linux-musl"
#./build-opencv4-musl-gcc.sh "sh2-linux-muslfdpic" "/opt/sh2-linux-muslfdpic"
#./build-opencv4-musl-gcc.sh "sh2eb-linux-musl" "/opt/sh2eb-linux-musl"
#./build-opencv4-musl-gcc.sh "sh2eb-linux-muslfdpic" "/opt/sh2eb-linux-muslfdpic"
#./build-opencv4-musl-gcc.sh "sh4-linux-musl" "/opt/sh4-linux-musl"
#./build-opencv4-musl-gcc.sh "sh4eb-linux-musl" "/opt/sh4eb-linux-musl"
#./build-opencv4-musl-gcc.sh "x86_64-linux-musl" "/opt/x86_64-linux-musl"
#./build-opencv4-musl-gcc.sh "x86_64-linux-muslx32" "/opt/x86_64-linux-muslx32"

if [ "$1" ]; then
  echo "TOOLCHAIN_NAME=$1"
  export TOOLCHAIN_NAME="$1"
else
  echo "Default toolchain name: x86_64-linux-musl"
  export TOOLCHAIN_NAME="x86_64-linux-musl"
fi

if [ "$2" ] ; then
  echo "TOOLCHAIN_PATH=$2"
  export TOOLCHAIN_PATH=$2
else
  echo "Error: Must input a path to toolchain!"
  exit
fi

HOST_OS=$(uname -s)
NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
BUILD_TYPE="Release"

mkdir -p "build-$BUILD_TYPE-$TOOLCHAIN_NAME"
pushd "build-$BUILD_TYPE-$TOOLCHAIN_NAME" || exit

cmake -DCMAKE_TOOLCHAIN_FILE=../musl-cross.toolchain.cmake \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
  -DCMAKE_INSTALL_PREFIX=install \
  $(cat ../opencv4_cmake_options.txt) \
    ..
cmake --build . --config $BUILD_TYPE -j $NUM_THREADS
cmake --build . --config $BUILD_TYPE --target install
popd
