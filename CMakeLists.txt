cmake_minimum_required(VERSION 3.25)
project(BuildOpenCV LANGUAGES CXX)
set(CMAKE_INCLUDE_CURRENT_DIR ON)


option(OCV_BUILD_ANYWAY "Build OpenCV, even if found by find_package" OFF)
option(OCV_FORCE_RELEASE_BUILD "Force a release build, even if parent is a debug build" ON)

add_library(${PROJECT_NAME} INTERFACE)

set(OCV_VERSION_TO_USE "4.11.0")
set(OpenCV_STATIC ON)

find_package(OpenCV ${OCV_VERSION_TO_USE} EXACT QUIET)

if(OpenCV_FOUND AND NOT OCV_BUILD_ANYWAY)
    message("Found OpenCV ${OpenCV_VERSION} on system, will use that")
else()
    message("Will download and build OpenCV ${OpenCV_VERSION}, this may take a while...")
    
    if(OCV_FORCE_RELEASE_BUILD)
        message("Forcing Release build of OpenCV")
        set(OCV_BUILD_TYPE Release)
    else()
        message("Setting OpenCV build type to ${CMAKE_BUILD_TYPE}")
        set(OCV_BUILD_TYPE ${CMAKE_BUILD_TYPE})
    endif()

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
