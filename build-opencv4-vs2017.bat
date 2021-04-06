:: build opencv 4.5.x for windows by benjaminwan
@ECHO OFF
chcp 65001
cls
SETLOCAL EnableDelayedExpansion

for /f "Delims=" %%x in (opencv4_cmake_options.txt) do set OPTIONS=!OPTIONS!%%x 

::call :cmakeParams "Visual Studio 14 2015" "v140" "x64"
::call :cmakeParams "Visual Studio 14 2015" "v140" "Win32"

call :cmakeParams "Visual Studio 15 2017" "v141" "x64"
call :cmakeParams "Visual Studio 15 2017" "v141" "Win32"
GOTO:EOF

:cmakeParams
mkdir "build-%~2-%~3"
pushd "build-%~2-%~3"
cmake -G "%~1" -T "%~2,host=x64" -A "%~3" -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_CONFIGURATION_TYPES=Release ^
  %OPTIONS% ^
  ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd
GOTO:EOF