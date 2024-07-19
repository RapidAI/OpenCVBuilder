#!/usr/bin/env bash

HOST_OS=$(uname -s)
NUM_THREADS=1
BUILD_TYPE=Release

if [ $HOST_OS == "Linux" ]; then
    NUM_THREADS=$(nproc)
else
    echo "Unsupported OS: $HOST_OS"
    exit 0
fi

while getopts "n:p:" arg; do
    case $arg in
    n)
        echo "n's arg:$OPTARG"
        export TOOLCHAIN_NAME="$OPTARG"
        ;;
    p)
        echo "p's arg:$OPTARG"
        export TOOLCHAIN_PATH="$OPTARG"
        ;;
    ?)
        echo -e "unkonw argument."
        exit 1
        ;;
    esac
done
echo "TOOLCHAIN_NAME=$TOOLCHAIN_NAME, TOOLCHAIN_PATH=$TOOLCHAIN_PATH"

if [ -z "$TOOLCHAIN_NAME" ] || [ -z "$TOOLCHAIN_PATH" ]; then
    echo -e "empty TOOLCHAIN_NAME or TOOLCHAIN_PATH."
    echo -e "usage: ./build-opencv3-musl-gcc.sh -n 'aarch64-linux-musl' -p '/opt/aarch64-linux-musl'"
    exit 1
fi

export PATH=$TOOLCHAIN_PATH/bin:$PATH

BUILD_OUTPUT_PATH="build-$BUILD_TYPE-$TOOLCHAIN_NAME"
BUILD_INSTALL_PATH="$BUILD_OUTPUT_PATH/install"

mkdir -p "$BUILD_OUTPUT_PATH"
cmake --compile-no-warning-as-error \
    -B"$BUILD_OUTPUT_PATH" \
    -DCMAKE_TOOLCHAIN_FILE=musl-cross.toolchain.cmake \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
    -DCMAKE_INSTALL_PREFIX="$BUILD_INSTALL_PATH" \
    $(cat opencv3_cmake_options.txt)

cmake --build $BUILD_OUTPUT_PATH --config $BUILD_TYPE --parallel $NUM_THREADS --target install
