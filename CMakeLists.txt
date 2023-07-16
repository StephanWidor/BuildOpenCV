cmake_minimum_required(VERSION 3.16)
project(OpenCV LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(OPENCV_VERSION 4.8.0 CACHE STRING "")

find_package(Git REQUIRED)

set(OPENCV_INSTALL_PATH "${CMAKE_CURRENT_SOURCE_DIR}/OpenCV-${OPENCV_VERSION}")
set(OCV_BUILD_DIR "${CMAKE_CURRENT_SOURCE_DIR}/opencv/build")
set(OCV_CONTRIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/opencv_contrib/modules")
if(ANDROID)
    include(android.cmake)
elseif(APPLE)
    include(macos.cmake)
elseif(UNIX)
    include(linux.cmake)
elseif(WIN32)
    include(win.cmake)
endif()

function(ocv_checkout OCV_BRANCH)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} checkout ${OCV_BRANCH}
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/opencv"
        )
    execute_process(
        COMMAND ${GIT_EXECUTABLE} checkout ${OCV_BRANCH}
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/opencv_contrib"
        )
endfunction()

if(NOT EXISTS "${OPENCV_PLATFORM_INSTALL_PATH}")
    message("Need to build OpenCV for ${OPENCV_BUILD_PLATFORM}")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
        )
    execute_process(
        COMMAND ${GIT_EXECUTABLE} name-rev --name-only HEAD
        OUTPUT_VARIABLE FORMER_OPENCV_BRANCH
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/opencv"
        )
    ocv_checkout(${OPENCV_VERSION})
    if(EXISTS ${OCV_BUILD_DIR})
        file(REMOVE_RECURSE ${OCV_BUILD_DIR})
    endif()
    file(MAKE_DIRECTORY ${OCV_BUILD_DIR})
    build_opencv()
endif()
set_ocv_dir()
set(OpenCV_STATIC ON)
find_package(OpenCV ${OPENCV_VERSION} REQUIRED)
add_library(${PROJECT_NAME} STATIC dummy.cpp)
target_include_directories(${PROJECT_NAME} PUBLIC "${OpenCV_INCLUDE_DIRS}")
target_link_libraries(${PROJECT_NAME}
   PUBLIC
   ${OpenCV_LIBS}
   )
