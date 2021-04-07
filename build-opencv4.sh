#!/usr/bin/env bash
# build opencv 4.5.x base on https://github.com/nihui/opencv-mobile/blob/master/opencv4_cmake_options.txt

function cmakeParamsMac() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_CONFIGURATION_TYPES=$1 \
    -DCMAKE_INSTALL_PREFIX=install \
    -DOpenMP_C_FLAGS="-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include" \
    -DOpenMP_CXX_FLAGS="-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include" \
    -DOpenMP_CXX_LIB_NAMES="omp" \
    -DOpenMP_C_LIB_NAMES="omp" \
    -DOpenMP_omp_LIBRARY=/usr/local/opt/libomp/lib/libomp.dylib \
    $(cat ../opencv4_cmake_options.txt) \
    ..
  cmake --build . --config $1 -j $NUM_THREADS
  cmake --build . --config $1 --target install
  popd
}

function cmakeParamsLinux() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_CONFIGURATION_TYPES=$1 \
    -DCMAKE_INSTALL_PREFIX=install \
    $(cat ../opencv4_cmake_options.txt) \
    ..
  cmake --build . --config $1 -j $NUM_THREADS
  cmake --build . --config $1 --target install
  popd
}

sysOS=$(uname -s)
NUM_THREADS=1

if [ $sysOS == "Darwin" ]; then
  #echo "I'm MacOS"
  NUM_THREADS=$(sysctl -n hw.ncpu)
  cmakeParamsMac "Release"
elif [ $sysOS == "Linux" ]; then
  #echo "I'm Linux"
  NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
  cmakeParamsLinux "Release"
else
  echo "Other OS: $sysOS"
fi
