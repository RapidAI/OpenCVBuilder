<#
.SYNOPSIS build opencv for windows by benjaminwan
.DESCRIPTION
This is a powershell script for builid opencv in windows.
Put this script to opencv root path, and then run .\build-opencv-win.ps1
attentions:
  1) Set ExecutionPolicy before run this script: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

.PARAMETER VsArch 
By default, we run this script on 64 bits Windows, this param is x64.
Other options are for cross-compiling.
  a) .\build-opencv-win.ps1 -VsArch x64
  b) .\build-opencv-win.ps1 -VsArch x86
  c) .\build-opencv-win.ps1 -VsArch arm64
  d) .\build-opencv-win.ps1 -VsArch arm64ec
.PARAMETER VsVer
By default, this param is v143
  a) .\build-opencv-win.ps1 -VsVer v140 # VS2015
  b) .\build-opencv-win.ps1 -VsVer v141 # VS2017
  c) .\build-opencv-win.ps1 -VsVer v142 # VS2019
  d) .\build-opencv-win.ps1 -VsVer v143 # VS2022
.PARAMETER VsCRT
  a) .\build-opencv-win.ps1 -VsCRT md
  b) .\build-opencv-win.ps1 -VsCRT mt
.PARAMETER BuildJava
By default, this param is set to False.
.\build-opencv-win.ps1 -BuildJava
.PARAMETER BuildType
By default, this param is set to Release.
  a) .\build-opencv-win.ps1 -BuildType Release
  b) .\build-opencv-win.ps1 -BuildType Debug
  c) .\build-opencv-win.ps1 -BuildType MinSizeRel
  d) .\build-opencv-win.ps1 -BuildType RelWithDebInfo
#>

param (
    [Parameter(Mandatory = $false)]
    [ValidateSet('x64', 'x86', 'arm64', 'arm64ec')]
    [string] $VsArch = "x64",

    [Parameter(Mandatory = $false)]
    [ValidateSet('v140', 'v141', 'v142', 'v143')]
    [string] $VsVer = 'v143',

    [Parameter(Mandatory = $false)]
    [ValidateSet('mt', 'md')]
    [string] $VsCRT = 'md',

    [Parameter(Mandatory = $false)]
    [switch] $BuildJava = $false,

    [Parameter(Mandatory = $false)]
    [ValidateSet('Release', 'Debug', 'MinSizeRel', 'RelWithDebInfo')]
    [string] $BuildType = 'Release'
)

#Set-PSDebug -Trace 1
Set-PSDebug -Trace 0

# 清屏
Clear-Host

Write-Host "Params: VsArch=$VsArch VsVer=$VsVer VsCRT=$VsCRT BuildJava=$BuildJava BuildType=$BuildType"

$genArgs = @();

switch ($VsArch)
{
    x64 {
        $ArchFlag = "x64";
    }
    x86 {
        $ArchFlag = "Win32";
    }
    arm64 {
        $ArchFlag = "ARM64";
    }
    arm64ec {
        $ArchFlag = "ARM64EC";
    }
    default {
        exit
    }
}

$genArgs += ('-A {0}'-f $ArchFlag);
$genArgs += ('-T {0},host=x64' -f $VsVer);
$genArgs += ('-DCMAKE_SYSTEM_PROCESSOR={0}' -f $ArchFlag);
$genArgs += ('-DCMAKE_SYSTEM_NAME=Windows');
$genArgs += ('-DCMAKE_BUILD_TYPE={0}' -f $BuildType);
$genArgs += ('-DCMAKE_CONFIGURATION_TYPES={0}' -f $BuildType);

$OptionsFile = "opencv3_cmake_options.txt"

if (!(Test-Path -Path $OptionsFile -PathType leaf))
{
    Write-Host "Error: Can't find file $OptionsFile"
    exit
}
Get-Content "$OptionsFile" | ForEach-Object { $genArgs += ("$_") }

if (($VsArch -eq "arm64") -and ($VsArch -eq "arm64ec"))
{
    $genArgs += ('-DCV_ENABLE_INTRINSICS=OFF');
}

if ($VsCRT -eq "mt")
{
    $genArgs += ('-DBUILD_WITH_STATIC_CRT=ON');
}
else
{
    $genArgs += ('-DBUILD_WITH_STATIC_CRT=OFF');
}

if ($BuildJava)
{
    $genArgs += ('-DBUILD_FAT_JAVA_LIB=ON');
    $genArgs += ('-DBUILD_JAVA=ON');
    $genArgs += ('-DBUILD_opencv_java=ON');
    $genArgs += ('-DBUILD_opencv_flann=ON');
}
#for opencv-rust
$genArgs += ('-DWITH_OPENCL=ON');

$OutPutPath = "build-$VsArch-$VsVer-$VsCRT"

if (!(Test-Path -Path $OutPutPath))
{
    Write-Host "Create path:$OutPutPath"
    New-Item -Path "$OutPutPath" -ItemType Directory
}
$genArgs += ('-DCMAKE_INSTALL_PREFIX={0}/install' -f $OutPutPath);
$genArgs += ('-B{0}' -f $OutPutPath);

# Create the generate call
$genCall = ('cmake {0}' -f ($genArgs -Join ' '));

Write-Host $genCall;
Invoke-Expression $genCall

# Create the build call
$LogicalProcessorsNum = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
$buildArgs += @('--build', $OutPutPath, '--config', $BuildType, '--parallel', $LogicalProcessorsNum, '--target install');
$buildCall = ('cmake {0}' -f ($buildArgs -Join ' '));

Write-Host $buildCall;
Invoke-Expression $buildCall;


