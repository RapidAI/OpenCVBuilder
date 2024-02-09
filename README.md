# OpenCVBuilder

OpenCV Custom Builder

### 介绍

OpenCV在OCR中只是做图像的读取保存、编解码、缩放等，可以去除大部分功能模块，保留几个核心功能模块即可。

在[opencv-mobile](https://github.com/nihui/opencv-mobile) 的基础上进行修改，并保留imgcodecs模块。

[模块定制说明](https://docs.opencv.org/4.5.0/db/d05/tutorial_config_reference.html)

最后利用Github Actions进行编译。

### 关于Windows静态链接CRT

编译选项添加BUILD_WITH_STATIC_CRT=ON

### 关于LINUX musl工具链编译
