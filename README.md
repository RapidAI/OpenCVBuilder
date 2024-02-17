# OpenCVBuilder

OpenCV Custom Builder

### 介绍

OpenCV在OCR中只是做图像的读取保存、编解码、缩放等，可以去除大部分功能模块，保留几个核心功能模块即可。

在[opencv-mobile](https://github.com/nihui/opencv-mobile) 的基础上进行修改，并保留imgcodecs模块。

[模块定制说明](https://docs.opencv.org/4.5.0/db/d05/tutorial_config_reference.html)

最后利用Github Actions进行编译。

### 关于Windows静态链接CRT

编译选项添加BUILD_WITH_STATIC_CRT=ON

## 编译环境
### Android
| 操作系统 | ndk  |
|---|---|
| ubuntu 22.04 | 25.2.9519653  |

### Windows
| 操作系统 | vs版本  | JDK | ant |
|---|---|-----|---|
| 2019 | vs2017 | 8 | 1.10.14 |
| 2019 | vs2019 | 8 | 1.10.14 |
| 2022 | vs2022 | 8 | 1.10.14 |

### Ubuntu
| 操作系统 | gcc  | libc | binutils | JDK| ant|
|---|---|---|---|---|---|
| ubuntu 14.04 | 4.8.4  | 2.19 | 2.24 | 8 | 1.10.14 |
| ubuntu 16.04 | 5.4.0  | 2.23 | 2.26.1 | 8 | 1.10.14 |
| ubuntu 18.04 | 7.5.0  | 2.27 | 2.30 | 8 | 1.10.14 |
| ubuntu 20.04 | 9.4.0  | 2.31 | 2.34 | 8 | 1.10.14 |
| ubuntu 22.04 | 11.4.0 | 2.35 | 2.38 | 8 | 1.10.14 |

### Musl
| 操作系统 | musl  |
|---|---|
| ubuntu 22.04 | 11.3.1  |

### Macos
| 操作系统  | JDK | ant|
|---|---|---|
| 10 | 8 | 1.10.14 |
| 11 | 8 | 1.10.14 |
| 12 | 8 | 1.10.14 |
| 13 | 8 | 1.10.14 |



