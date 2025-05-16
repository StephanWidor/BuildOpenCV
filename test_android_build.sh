#!/bin/bash
set -e
export ANDROID_ABI=arm64-v8a # armeabi-v7a # arm64-v8a # x86 # x86_64
export BUILD_FOLDER=build.android/$ANDROID_ABI
export NDK_PATH=/opt/android-sdk/ndk/29.0.13113456
export ANDROID_MIN_SDK_VERSION=28
export ANDROID_TARGET_SDK_VERSION=34
export ANDROID_NATIVE_API_LEVEL=24
export ANDROID_PLATFORM=android-30
export SDK_PATH=/opt/android-sdk
export NDK_BIN_PATH=$NDK_PATH/toolchains/llvm/prebuilt/linux-x86_64/bin
export JDK_PATH=/opt/android-studio/jbr
export ANDROID_STL=c++_static

mkdir -p $BUILD_FOLDER
cd $BUILD_FOLDER
rm -rf *

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_COLOR_DIAGNOSTICS=ON \
    -DANDROID_PLATFORM=$ANDROID_PLATFORM \
    -DCMAKE_C_COMPILER=$NDK_BIN_PATH/clang \
    -DCMAKE_CXX_COMPILER=$NDK_BIN_PATH/clang++ \
    -DANDROID_NDK=$NDK_PATH \
    -DANDROID_ABI=$ANDROID_ABI \
    -DANDROID_STL=$ANDROID_STL \
    -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake \
    ../..

cd ../..

