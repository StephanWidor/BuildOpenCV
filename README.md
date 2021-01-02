# BuildOpenCV

Script for building OpenCV with contrib modules for different platforms.
This is for static lib usage in C++, building shared libs, and java and python interfaces are disabled.

## Usage

`./build.sh <Platform = linux, android, macos, or win> <OpenCV_Version = e.g. 4.5.1, master, ...>`

The script will checkout the opencv and opencv_contrib submodules according to `OpenCV_Version`, run cmake and
make, and install resulting package to `OpenCV-OpenCV_Version/Platform` in the local repo folder.

### Linux

`Platform = linux`, and cross compiling for `android` are supported. `android` will build archives for
`armeabi-v7a, arm64-v8a, x86, and x86_64`.
Paths in scripts to toolchains etc are set like they are on my computer. Might have to be adapted for others...

### Mac

Only `Platform = macos` is tested. Again, Paths in scripts to toolchains etc are set like they are on my computer.
Might have to be adapted for others... Might well be that cross compiling for `android` also works if you adapt
paths accordingly.

### Windows

Only `Platform = win` is tested.

## Prerequisites

Installed compilers, cmake, clang, android sdk and ndk, git-bash on Win...


For deeper insights have a look at the [opencv GitHub page](https://github.com/opencv/opencv)
