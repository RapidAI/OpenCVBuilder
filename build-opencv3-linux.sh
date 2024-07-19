#!/usr/bin/env bash
# ./build-opencv3-linux.sh -n 386
# ./build-opencv3-linux.sh -n amd64
# ./build-opencv3-linux.sh -n arm
# ./build-opencv3-linux.sh -n arm64
# ./build-opencv3-linux.sh -n ppc64le

HOST_OS=$(uname -s)
NUM_THREADS=1
BUILD_TYPE=Release

if [ "$HOST_OS" == "Linux" ]; then
    NUM_THREADS=$(nproc)
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
    echo -e "usage: ./build-opencv3-linux.sh -n amd64"
    exit 1
fi

# get gcc version
export _compiler=$(which gcc)
MAJOR=$(echo __GNUC__ | $_compiler -E -xc - | tail -n 1)
MINOR=$(echo __GNUC_MINOR__ | $_compiler -E -xc - | tail -n 1)
PATCH_LEVEL=$(echo __GNUC_PATCHLEVEL__ | $_compiler -E -xc - | tail -n 1)

if [ "$HOST_OS" == "Linux" ] && [ "$TARGET_ARCH" == "arm64" ] && [ "$MAJOR.$MINOR.$PATCH_LEVEL" == "4.8.4" ]; then
    echo "Linux arm64 gcc version is 4.8.4, turn off libwebp"
    DISABLE_OPTION="-DBUILD_WEBP=OFF -DWITH_WEBP=OFF"
elif [ "$HOST_OS" == "Linux" ] && [ "$TARGET_ARCH" == "386" ] && [ "$MAJOR.$MINOR.$PATCH_LEVEL" == "4.8.4" ]; then
    echo "Linux 386 gcc version is 4.8.4, turn off openexr"
    DISABLE_OPTION="-DBUILD_OPENEXR=OFF -DWITH_OPENEXR=OFF"
else
    echo "Other gcc version"
    DISABLE_OPTION=""
fi

BUILD_OUTPUT_PATH="build-$BUILD_TYPE-$TARGET_ARCH"
BUILD_INSTALL_PATH="$BUILD_OUTPUT_PATH/install"
mkdir -p "$BUILD_OUTPUT_PATH"

cmake --compile-no-warning-as-error \
    -B"$BUILD_OUTPUT_PATH" \
    -DCMAKE_INSTALL_PREFIX="$BUILD_INSTALL_PATH" \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
    $(cat opencv3_cmake_options.txt) \
    $DISABLE_OPTION \
    $JAVA_FLAG

cmake --build $BUILD_OUTPUT_PATH --config $BUILD_TYPE --parallel $NUM_THREADS --target install
