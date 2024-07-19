#!/usr/bin/env bash
# ./build-opencv3-mac.sh -n x86_64
# ./build-opencv3-mac.sh -n arm64

HOST_OS=$(uname -s)
NUM_THREADS=1
BUILD_TYPE=Release

if [ "$HOST_OS" == "Darwin" ]; then
    NUM_THREADS=$(sysctl -n hw.ncpu)
else
    echo "Unsupported OS: $HOST_OS"
    exit 0
fi

JAVA_FLAG=""
TARGET_ARCH=""

while getopts "n:j" arg; do
    case $arg in
    n)
        echo "n(TARGET_ARCH):$OPTARG"
        TARGET_ARCH="$OPTARG"
        ;;
    j)
        echo "j's arg:$OPTARG"
        JAVA_FLAG="-DBUILD_FAT_JAVA_LIB=ON -DBUILD_JAVA=ON -DBUILD_opencv_java=ON -DBUILD_opencv_flann=ON"
        ;;
    ?)
        echo -e "unkonw argument."
        exit 1
        ;;
    esac
done

if [ -z "$TARGET_ARCH" ]; then
    echo -e "empty TARGET_ARCH."
    echo -e "usage1: ./build-opencv3-linux.sh -n x86_64"
    echo -e "usage2: ./build-opencv3-linux.sh -n arm64"
    exit 1
fi

BUILD_OUTPUT_PATH="build-$BUILD_TYPE-$TARGET_ARCH"
BUILD_INSTALL_PATH="$BUILD_OUTPUT_PATH/install"
mkdir -p "$BUILD_OUTPUT_PATH"

cmake --compile-no-warning-as-error \
    -B"$BUILD_OUTPUT_PATH" \
    -DCMAKE_INSTALL_PREFIX="$BUILD_INSTALL_PATH" \
    -DCMAKE_SYSTEM_NAME="Darwin" -DCMAKE_OSX_DEPLOYMENT_TARGET="10.9" \
    -DCMAKE_SYSTEM_PROCESSOR="$TARGET_ARCH" -DCMAKE_OSX_ARCHITECTURES="$TARGET_ARCH" \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
    $(cat opencv3_cmake_options.txt) \
    $JAVA_FLAG

cmake --build $BUILD_OUTPUT_PATH --config $BUILD_TYPE --parallel $NUM_THREADS --target install
