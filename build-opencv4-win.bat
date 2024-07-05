:: build opencv 4 for windows by benjaminwan
:: build-opencv4-win.bat x64 v142 md
:: build-opencv4-win.bat Win32 v142 md
:: build-opencv4-win.bat ARM64 v142 md

@ECHO OFF
chcp 65001
cls
SETLOCAL EnableDelayedExpansion

IF "%1"=="" (
    echo input VS_ARCH none, use x64
	set VS_ARCH="x64"
)^
ELSE (
	echo input VS_ARCH:%1
    set VS_ARCH="%1"
)

IF "%2"=="" (
    echo input VS_VER none, use v142
	set VS_VER="v142"
)^
ELSE (
	echo input VS_VER:%2
    set VS_VER="%2"
)

IF "%3"=="" (
    echo input VS_CRT none, use mt
	set VS_CRT="mt"
)^
ELSE (
	echo input VS_CRT:%3
    set VS_CRT="%3"
)

for /f "Delims=" %%x in (opencv4_cmake_options.txt) do set OPTIONS=!OPTIONS! %%x

call :cmakeParams %VS_ARCH% %VS_VER% %VS_CRT%
GOTO:EOF

:cmakeParams
mkdir "build-%~1-%~2-%~3"
pushd "build-%~1-%~2-%~3"
if "%~1" == "ARM64" (
    set ARM64_INTRINSICS="-DCV_ENABLE_INTRINSICS=OFF"
)^
else (
    set ARM64_INTRINSICS=""
)
if "%~3" == "md" (
    set STATIC_CRT_ENABLED="OFF"
)^
else (
    set STATIC_CRT_ENABLED="ON"
)
cmake -A "%~1" -T "%~2,host=x64" ^
  -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SYSTEM_PROCESSOR="%~1" ^
  -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_CONFIGURATION_TYPES=Release ^
  -DBUILD_WITH_STATIC_CRT=%STATIC_CRT_ENABLED% %ARM64_INTRINSICS% %OPTIONS% ^
  ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd
GOTO:EOF