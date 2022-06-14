# OpenCVBuilder

OpenCV Custom Builder

### 介绍

OpenCV在OCR中只是做图像的读取保存、编解码、缩放等，可以去除大部分功能模块，保留几个核心功能模块即可。

在[opencv-mobile](https://github.com/nihui/opencv-mobile) 的基础上进行修改，并保留imgcodecs模块。

[模块定制说明](https://docs.opencv.org/4.5.0/db/d05/tutorial_config_reference.html)

最后利用Github Actions进行编译。

### 20220614 update
opencv 4.6.0

### 20220524 update
opencv 4.5.5 不使用任何并行库

### 手动编译说明

如果您的系统太新或太旧无法直接使用本仓库编译的包，请尝试手动编译。

#### Linux编译说明

1. 编译环境:

| 操作系统 | 基本软件包 |
| ------- | ------- |
| Ubuntu18.04 | [基本软件包](https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu1804-README.md) |

安装build-essential和cmake

```shell
sudo apt-get install build-essential cmake
```

2. 同步[OpenCV源代码](https://github.com/opencv/opencv) 到opencv文件夹

3. 复制[编译脚本](build-opencv4.sh)和[cmake选项](opencv4_cmake_options.txt)
   到opencv文件夹，并执行```chmod a+x build-opencv4.sh &&./build-opencv4.sh```
   编译结果在：opencv/build-Release/install

#### macOS编译说明

1. 编译环境:

| 操作系统 | 基本软件包 |
| ------- | ------- |
| macos10.15 | [基本软件包](https://github.com/actions/virtual-environments/blob/macOS-10.15/20210327.1/images/macos/macos-10.15-Readme.md) |

安装[Xcode](https://developer.apple.com/download/more) > 12

安装[HomeBrew](https://brew.sh/)

安装libomp
```brew install cmake libomp```

安装CommandLineTools

```shell
brew doctor
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```

2. 同步[OpenCV源代码](https://github.com/opencv/opencv) 到opencv文件夹

3. 复制[编译脚本](build-opencv4.sh)和[cmake选项](opencv4_cmake_options.txt)
   到opencv文件夹，并执行```chmod a+x build-opencv4.sh &&./build-opencv4.sh```
   编译结果在：opencv/build-Release/install

#### windows编译说明

1. 编译环境:

| 操作系统 | 基本软件包 |
| ------- | ------- |
| Windows-vs2017 | [基本软件包](https://github.com/actions/virtual-environments/blob/win16/20210329.1/images/win/Windows2016-Readme.md) |
| Windows-vs2019 | [基本软件包](https://github.com/actions/virtual-environments/blob/win19/20210316.1/images/win/Windows2019-Readme.md) |

安装vs2017或者vs2019，并选中"C++桌面开发"

安装[cmake](https://cmake.org/download/)

2. 同步[OpenCV源代码](https://github.com/opencv/opencv) 到opencv文件夹

3. 复制编译脚本和cmake选项

vs2017环境，复制[编译脚本vs2017](build-opencv4-vs2017.bat)和[cmake选项](opencv4_cmake_options.txt)到opencv文件夹

vs2019环境，复制[编译脚本vs2019](build-opencv4-vs2019.bat)和[cmake选项](opencv4_cmake_options.txt)到opencv文件夹

4. 开始菜单打开"x64 Native Tools Command Prompt for VS 2019"或"适用于 VS2017 的 x64 本机工具"，
   运行对应的编译脚本，编译结果在：opencv/build-xxx-xxx/install