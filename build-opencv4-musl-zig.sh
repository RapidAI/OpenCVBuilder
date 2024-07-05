#!/usr/bin/env bash
# ./build-opencv4-musl-zig.sh "aarch64_be-linux-musl" OK
# ./build-opencv4-musl-zig.sh "aarch64-linux-musl" OK
# ./build-opencv4-musl-zig.sh "armeb-linux-musleabi" error: sub-compilation of compiler_rt failed
# ./build-opencv4-musl-zig.sh "armeb-linux-musleabihf" error: sub-compilation of compiler_rt failed
# ./build-opencv4-musl-zig.sh "arm-linux-musleabi" OK
# ./build-opencv4-musl-zig.sh "arm-linux-musleabihf" OK
# ./build-opencv4-musl-zig.sh "thumb-linux-musleabi" OK
# ./build-opencv4-musl-zig.sh "thumb-linux-musleabihf" OK
# ./build-opencv4-musl-zig.sh "x86-linux-musl" OK
# ./build-opencv4-musl-zig.sh "loongarch64-linux-musl" is not able to compile a simple test program.
# ./build-opencv4-musl-zig.sh "m68k-linux-musl" is not able to compile a simple test program.
# ./build-opencv4-musl-zig.sh "mips64el-linux-musl" OK
# ./build-opencv4-musl-zig.sh "mips64-linux-musl" OK
# ./build-opencv4-musl-zig.sh "mipsel-linux-musl" OK
# ./build-opencv4-musl-zig.sh "mips-linux-musl" OK
# ./build-opencv4-musl-zig.sh "powerpc64le-linux-musl" OK
# ./build-opencv4-musl-zig.sh "powerpc64-linux-musl" OK
# ./build-opencv4-musl-zig.sh "powerpc-linux-musl" OK
# ./build-opencv4-musl-zig.sh "riscv32-linux-musl" is not able to compile a simple test program.
# ./build-opencv4-musl-zig.sh "riscv64-linux-musl" OK
# ./build-opencv4-musl-zig.sh "s390x-linux-musl" error: unknown target CPU 'generic'
# ./build-opencv4-musl-zig.sh "wasm32-freestanding-musl" is not able to compile a simple test program.
# ./build-opencv4-musl-zig.sh "wasm32-wasi-musl" fatal error: too many errors emitted, stopping now [-ferror-limit=]
# ./build-opencv4-musl-zig.sh "x86_64-linux-musl" OK
if [ "$1" ]; then
  echo "TOOLCHAIN_TARGET=$1"
  export TOOLCHAIN_TARGET="$1"
else
  echo "Default build target: x86_64-linux-musl"
  export TOOLCHAIN_TARGET="x86_64-linux-musl"
fi

HOST_OS=$(uname -s)
HOST_ARCH=$(uname -m)
NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
BUILD_TYPE="Release"

mkdir -p "build-$BUILD_TYPE-$TOOLCHAIN_TARGET"
pushd "build-$BUILD_TYPE-$TOOLCHAIN_TARGET" || exit

cmake -DCMAKE_TOOLCHAIN_FILE=../zig-musl.toolchain.cmake \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
  -DCMAKE_INSTALL_PREFIX=install \
  $(cat ../opencv4_cmake_options.txt) \
  ..
cmake --build . --config $BUILD_TYPE -j $NUM_THREADS
cmake --build . --config $BUILD_TYPE --target install
popd