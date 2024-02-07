:: build opencv 4 for windows by benjaminwan
@ECHO OFF
chcp 65001
cls
SETLOCAL EnableDelayedExpansion

IF "%1"=="" (
    echo input VS_VER none, use v142
	set VS_VER="v142"
)^
ELSE (
	echo input VS_VER:%1
    set VS_VER="%1"
)

IF "%2"=="" (
    echo input CRT none, use mt
	set CRT="mt"
)^
ELSE (
	echo input CRT:%2
    set CRT="%2"
)

for /f "Delims=" %%x in (opencv4_cmake_options.txt) do set OPTIONS=!OPTIONS!%%x 

call :cmakeParams "x64" %VS_VER% %CRT%
call :cmakeParams "Win32" %VS_VER% %CRT%
GOTO:EOF

:cmakeParams
mkdir "build-%~1-%~2-%~3"
pushd "build-%~1-%~2-%~3"
if "%~3" == "md" (
    set STATIC_CRT_ENABLED="OFF"
)^
else (
    set STATIC_CRT_ENABLED="ON"
)
cmake -A "%~1" -T "%~2,host=x64" -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_CONFIGURATION_TYPES=Release ^
  -DBUILD_WITH_STATIC_CRT=%STATIC_CRT_ENABLED% %OPTIONS% ^
  -DBUILD_FAT_JAVA_LIB=ON ^
  -DBUILD_JAVA=ON ^
  -DBUILD_opencv_java=ON ^
  -DBUILD_opencv_flann=ON ^
  ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd
GOTO:EOF