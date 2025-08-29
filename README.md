# OpenCVBuilder

OpenCV Custom Builder

### 介绍

OpenCV在OCR中只是做图像的读取保存、编解码、缩放等，可以去除大部分功能模块，保留几个核心功能模块即可。

[模块定制说明](https://docs.opencv.org/4.9.0/db/d05/tutorial_config_reference.html)

最后利用Github Actions进行编译。

### 关于Windows静态链接CRT

编译选项添加BUILD_WITH_STATIC_CRT=ON

## 编译环境

### Android

| 操作系统         | ndk          |
|--------------|--------------|
| ubuntu 22.04 | 25.2.9519653 |

### HarmonyOS(ohos)

| 操作系统         | sdk   | ndk       |
|--------------|-------|-----------|
| ubuntu 22.04 | 4.1.4 | 4.1.10.5  |
| ubuntu 22.04 | 5.1.0 | 5.1.0.107 |

### Windows

| 操作系统 | vs版本   | JDK | ant     |
|------|--------|-----|---------|
| 2019 | vs2015 | 8   | 1.10.14 |
| 2019 | vs2017 | 8   | 1.10.14 |
| 2019 | vs2019 | 8   | 1.10.14 |
| 2022 | vs2022 | 8   | 1.10.14 |

- vs2019和vs2022支持arm64平台

### Ubuntu

| 操作系统         | gcc    | libc | binutils | JDK | ant     |
|--------------|--------|------|----------|-----|---------|
| ubuntu 14.04 | 4.8.4  | 2.19 | 2.24     | 8   | 1.10.14 |
| ubuntu 16.04 | 5.4.0  | 2.23 | 2.26.1   | 8   | 1.10.14 |
| ubuntu 18.04 | 7.5.0  | 2.27 | 2.30     | 8   | 1.10.14 |
| ubuntu 20.04 | 9.4.0  | 2.31 | 2.34     | 8   | 1.10.14 |
| ubuntu 22.04 | 11.4.0 | 2.35 | 2.38     | 8   | 1.10.14 |

- 因ubuntu14.04 arm64 gcc4.8.4 libwebp会导致编译错误，故BUILD_WEBP=OFF
- 因ubuntu14.04 386 gcc4.8.4 libopenexr会导致编译错误，故BUILD_OPENEXR=OFF

### zig toolchain

| 操作系统         | zig    |
|--------------|--------|
| ubuntu 22.04 | 0.13.0 |

### musl gcc toolchain

| 操作系统         | musl   |
|--------------|--------|
| ubuntu 22.04 | 11.3.1 |

### Macos

| 操作系统   | JDK | ant     |
|--------|-----|---------|
| 10(失效) | 8   | 1.10.14 |
| 11(失效) | 8   | 1.10.14 |
| 12     | 8   | 1.10.14 |
| 13     | 8   | 1.10.14 |
| 14     | 11  | 1.10.14 |

- github action 已不支持低版本macos runner

### 如果7z包解压出错

- 需要安装最新版的7zip工具，https://www.7-zip.org/download.html

### 关于Visual Studio 2022 MSVC编译器安装

- 删除旧版:```C:\Program Files (x86)\Microsoft Visual Studio\Installer\InstallCleanup.exe```
- https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-history
- 下载LTSC 17.12或选择以下链接
- https://aka.ms/vs/17/release.LTSC.17.12/vs_professional.exe
- https://aka.ms/vs/17/release.LTSC.17.12/vs_enterprise.exe
- 勾选: "使用 C++ 的桌面开发"
- 在"SDK、库和框架"中勾选：

```
适用于最新v143生成工具的C++ATL(ARM)
适用于最新v143生成工具的C++ATL(ARM64/ARM64EC)
适用于最新v143生成工具的C++ATL(x86和x64)
```

- 在"编译器、生成工具和运行时"中勾选：

```
MSVC v143 - VS 2022 C++ ARM 生成工具(最新)
MSVC v143 - VS 2022 C++ ARM64/ARM64EC 生成工具(最新)
MSVC v143 - VS 2022 C++ x64/x86 生成工具(最新)
```

## 其它说明

- 4.9.0 Windows WITH_OPENCL=ON, for opencv-rust