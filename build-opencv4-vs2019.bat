:: build opencv 4.6.x for windows by benjaminwan
@ECHO OFF
chcp 65001
cls
SETLOCAL EnableDelayedExpansion

for /f "Delims=" %%x in (opencv4_cmake_options.txt) do set OPTIONS=!OPTIONS!%%x 

call :cmakeParams "v142" "x64" "md"
call :cmakeParams "v142" "Win32" "md"
call :cmakeParams "v142" "x64" "mt"
call :cmakeParams "v142" "Win32" "mt"
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
cmake -T "%~1,host=x64" -A "%~2" -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_CONFIGURATION_TYPES=Release ^
  -DBUILD_WITH_STATIC_CRT=%STATIC_CRT_ENABLED% %OPTIONS% ^
  ..
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%
cmake --build . --config Release --target install
popd
GOTO:EOF