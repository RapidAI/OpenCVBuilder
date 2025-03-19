# Set shell for Windows OSs:
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

cv := "4.11.0"
vs := "vs2022"

default:
  @just --list

# 编译opencv静态库
build_lib:  
  just _build "x64" "v143" "mt"
  just _build "x64" "v143" "md"
  just _build "x86" "v143" "mt"
  just _build "x86" "v143" "md"
  just _build "arm64" "v143" "mt"
  just _build "arm64" "v143" "md"

_build arch ver crt:
   @echo ".\build-opencv4-win.ps1 -VsArch {{arch}} -VsVer {{ver}} -VsCRT {{crt}}"
   .\build-opencv4-win.ps1 -VsArch {{arch}} -VsVer {{ver}} -VsCRT {{crt}}
   @echo "cp -r build-{{arch}}-{{ver}}-{{crt}}/install opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}"
   cp -r build-{{arch}}-{{ver}}-{{crt}}/install opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}
   @echo "7z a opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}.7z opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}"
   7z a opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}.7z opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}
   @echo "rm opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}} -r -fo"
   rm opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}} -r -fo

# 编译opencv java包
build_java: 
  just _java "x64" "v143" "mt"
  just _java "x64" "v143" "md"
  just _java "x86" "v143" "mt"
  just _java "x86" "v143" "md"
  just _java "arm64" "v143" "mt"
  just _java "arm64" "v143" "md"

_java arch ver crt:
  @echo ".\build-opencv4-win.ps1 -VsArch {{arch}} -VsVer {{ver}} -VsCRT {{crt}} -BuildJava"
  .\build-opencv4-win.ps1 -VsArch {{arch}} -VsVer {{ver}} -VsCRT {{crt}} -BuildJava
  @echo "cp -r build-{{arch}}-{{ver}}-{{crt}}/install/java opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java"
  cp -r build-{{arch}}-{{ver}}-{{crt}}/install/java opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java
  @echo "7z a opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java.7z opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java"
  7z a opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java.7z opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java
  @echo "rm opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java -r -fo"
  rm opencv-{{cv}}-windows-{{vs}}-{{arch}}-{{crt}}-java -r -fo