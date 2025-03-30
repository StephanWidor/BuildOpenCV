cmake_minimum_required(VERSION 3.25)
project(BuildOpenCV LANGUAGES CXX)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

option(FORCE_RELEASE_BUILD "Force a release build, even if parent is a debug build" ON)

if(FORCE_RELEASE_BUILD)
    set(OCV_BUILD_TYPE Release)
else()
    set(OCV_BUILD_TYPE ${CMAKE_BUILD_TYPE})
endif()

add_library(${PROJECT_NAME} STATIC dummy.cpp)

set(OCV_VERSION_TO_USE "4.11.0")
find_package(OpenCV QUIET)

set(OpenCV_STATIC ON)

if(OpenCV_FOUND)
    if(${OpenCV_VERSION} STREQUAL ${OCV_VERSION_TO_USE})
        set(USE_SYSTEM_OCV ON)
    endif()
endif()

if(USE_SYSTEM_OCV)
    message("Found OpenCV ${OpenCV_VERSION} on system, will use that")
else()
    message("Did not find OpenCV on system, will have to download and build it")
    
    include(common.cmake)
    clone_ocv()
    prepare_folders()
    
    if(ANDROID)
        include(android.cmake)
    elseif(APPLE)
        include(macos.cmake)
    elseif(UNIX)
        include(linux.cmake)
    elseif(WIN32)
        include(win.cmake)
    endif()
    
    build_ocv()
    find_ocv()
endif()

target_link_libraries(${PROJECT_NAME} INTERFACE ${OpenCV_LIBS})    
