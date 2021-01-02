#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "usage: ./build.sh <Platform = linux, macos, win, or android> <OpenCV version>"
    exit 1
fi

PLATFORM=$1
CV_VERSION=$2

OCV_CONTRIB_DIR="$(pwd)/opencv_contrib/modules"

git submodule update --init --recursive
cd opencv
FORMER_OPENCV_BRANCH="$(git name-rev --name-only HEAD)"
git checkout $CV_VERSION
cd ..
cd opencv_contrib
FORMER_OPENCV_CONTRIB_BRANCH="$(git name-rev --name-only HEAD)"
git checkout $CV_VERSION
cd ..

INSTALL_DIR="$(pwd)/OpenCV-${CV_VERSION}/${PLATFORM}"
if [ -d "${INSTALL_DIR}" ]; then
    echo "deleting old install directory" ${INSTALL_DIR}
    rm -rf "${INSTALL_DIR}"
fi

cd opencv

# we want to rebuild
if [ -d build/${PLATFORM} ]; then
    echo "deleting old build directory" build/${PLATFORM}
    rm -rf build/${PLATFORM}
fi
mkdir -p build/${PLATFORM}
cd build/${PLATFORM}

if [ $PLATFORM == linux ]; then
    source ../../../build_linux.config
elif [ $PLATFORM == macos ]; then
    source ../../../build_macos.config
elif [ $PLATFORM == android ]; then
    source ../../../build_android.config
elif [ $PLATFORM == win ]; then
    source ../../../build_win.config
else
    echo "Unknown Platform. Possible values are 'linux', 'macos', 'win', and 'android'"
    exit 1
fi
echo "Building OpenCV-" $CV_VERSION "for Platform" $PLATFORM
do_cmake_build

cd ..
rm -rf ${PLATFORM}
cd ../..

cd opencv
git checkout ${FORMER_OPENCV_BRANCH}
cd ..
cd opencv_contrib
git checkout ${FORMER_OPENCV_CONTRIB_BRANCH}
cd ..
