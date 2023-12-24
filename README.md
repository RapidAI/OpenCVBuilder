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
从v4.8.1开始，linux平台改用musl toolchain编译，并使用-static参数

### 手动编译说明

如果您的系统太新或太旧无法直接使用本仓库编译的包，请尝试手动编译。

#### Linux编译说明

1. 编译环境:

| 操作系统        | 基本软件包                                                                                          |
|-------------|------------------------------------------------------------------------------------------------|
| Ubuntu22.04 | [基本软件包](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2204-Readme.md) |

安装build-essential和cmake

```shell
sudo apt-get install build-essential cmake
```

2. 同步[OpenCV源代码](https://github.com/opencv/opencv) 到opencv文件夹

```shell
git clone https://github.com/opencv/opencv.git
```

3. 复制[编译脚本](build-opencv4.sh)和[cmake选项](opencv4_cmake_options.txt)
   到opencv文件夹，并赋予执行权限

```shell
chmod a+x build-opencv4.sh
```

4. 部署musl
   toolchain，部署方法参考工具链仓库的README，根据自己的目标平台下载对应的[工具链](https://github.com/benjaminwan/musl-cross-builder/releases)
5. 开始编译

```shell
./build-opencv4.sh "/opt/x86_64-linux-musl/bin/x86_64-linux-musl-gcc -static" "/opt/x86_64-linux-musl/bin/x86_64-linux-musl-g++ -static"
```

编译结果在：opencv/build-Release/install

#### macOS编译说明

1. 编译环境:

| 操作系统       | 基本软件包                                                                                       |
|------------|---------------------------------------------------------------------------------------------|
| macos12.72 | [基本软件包](https://github.com/actions/runner-images/blob/main/images/macos/macos-12-Readme.md) |

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

| 操作系统           | 基本软件包                                                                                            |
|----------------|--------------------------------------------------------------------------------------------------|
| Windows-vs2019 | [基本软件包](https://github.com/actions/runner-images/blob/main/images/windows/Windows2019-Readme.md) |

安装vs2019，并选中"C++桌面开发"

安装[cmake](https://cmake.org/download/)

2. 同步[OpenCV源代码](https://github.com/opencv/opencv) 到opencv文件夹

3. 复制编译脚本和cmake选项
   vs2019环境，复制[编译脚本vs2019](build-opencv4-vs2019.bat)和[cmake选项](opencv4_cmake_options.txt)到opencv文件夹

4. 开始菜单打开"x64 Native Tools Command Prompt for VS 2019"，
   运行对应的编译脚本，编译结果在：opencv/build-xxx-xxx-xx/install，后缀md代表链接动态CRT，后缀mt代表链接静态CRT

### 20220524 update

opencv 4.5.5 不使用任何并行库

### 20220614 update

opencv 4.6.0

### 20221013 update

- 默认编译环境改为vs2019
- windows平台，更早版本的包均为md版，从此版增加链接静态CRT版本(mt)
- 后缀md: BUILD_WITH_STATIC_CRT=OFF
- 后缀mt: BUILD_WITH_STATIC_CRT=ON

### 20221123 update

- BUILD_JAVA=ON, BUILD_opencv_java=ON, BUILD_opencv_flann=ON
- 输出java binding，位置在Release/install/share/java

### 20221231 update

- opencv 4.7.0

### 20230722 update

- opencv 4.8.0

### 20231224 update

- opencv 4.8.1
- Linux平台使用musl toolchain编译
- BUILD_JAVA=OFF, BUILD_opencv_java=OFF, BUILD_opencv_flann=OFF