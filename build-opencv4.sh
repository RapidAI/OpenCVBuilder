#!/usr/bin/env bash
# build opencv 4.5.x base on https://github.com/nihui/opencv-mobile/blob/master/opencv4_cmake_options.txt

function cmakeParams() {
  mkdir -p "build-$1"
  pushd "build-$1"
  cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_CONFIGURATION_TYPES=$1 \
    -DCMAKE_INSTALL_PREFIX=install \
    $OMP_FLAG \
    $(cat ../opencv4_cmake_options.txt) \
    ..
  cmake --build . -j $NUM_THREADS
  cmake --build . --target install
  popd
}

sysOS=$(uname -s)
NUM_THREADS=1

if [ -f /usr/local/opt/libomp/include/omp.h ]; then
  OMP_FLAG='-DOpenMP_C_FLAGS="-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include"
   -DOpenMP_CXX_FLAGS="-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include"
   -DOpenMP_CXX_LIB_NAMES="omp"
   -DOpenMP_C_LIB_NAMES="omp"'
fi

if [ $sysOS == "Darwin" ]; then
  #echo "I'm MacOS"
  NUM_THREADS=$(sysctl -n hw.ncpu)
elif [ $sysOS == "Linux" ]; then
  #echo "I'm Linux"
  NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
else
  echo "Other OS: $sysOS"
fi

cmakeParams "Release"
