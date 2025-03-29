set(OCV_GIT_URL "https://github.com/opencv/opencv.git")
set(OCV_CONTRIB_GIT_URL "https://github.com/opencv/opencv_contrib.git")
set(OCV_DIR "${CMAKE_CURRENT_BINARY_DIR}/opencv")
set(OCV_CONTRIB_DIR "${CMAKE_CURRENT_BINARY_DIR}/opencv_contrib")
set(OCV_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/opencv-build")
set(OCV_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/OpenCV-${OCV_VERSION_TO_USE}")

find_package(Git REQUIRED)

function(clone_ocv)
    if(EXISTS ${OCV_DIR})
        message("${OCV_DIR} exists, will only checkout ${OCV_VERSION_TO_USE}")
        execute_process(
            COMMAND ${GIT_EXECUTABLE} checkout ${OCV_VERSION_TO_USE}
            WORKING_DIRECTORY ${OCV_DIR}
        )
    else()
        message("Will clone OpenCV ${OCV_VERSION_TO_USE} into ${OCV_DIR}")
        execute_process(
            COMMAND ${GIT_EXECUTABLE} clone -b ${OCV_VERSION_TO_USE} --single-branch ${OCV_GIT_URL}
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        )
    endif()
    if(EXISTS ${OCV_CONTRIB_DIR})
        message("${OCV_CONTRIB_DIR} exists, will only checkout ${OCV_VERSION_TO_USE}")
        execute_process(
            COMMAND ${GIT_EXECUTABLE} checkout ${OCV_VERSION_TO_USE}
            WORKING_DIRECTORY ${OCV_CONTRIB_DIR}
        )
    else()
        message("Will clone OpenCV-contrib ${OCV_VERSION_TO_USE} into ${OCV_CONTRIB_DIR}")
        execute_process(
            COMMAND ${GIT_EXECUTABLE} clone -b ${OCV_VERSION_TO_USE} --single-branch ${OCV_CONTRIB_GIT_URL}
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        )
    endif()
endfunction()

function(prepare_folders)
    if(EXISTS ${OCV_BUILD_DIR})
        message("OpenCV build directory existent. Will not clean before starting build")
    else()
        file(MAKE_DIRECTORY ${OCV_BUILD_DIR})
    endif()
    if(EXISTS ${OCV_INSTALL_DIR})
        file(REMOVE_RECURSE ${OCV_INSTALL_DIR})
    endif()
    file(MAKE_DIRECTORY ${OCV_INSTALL_DIR})
endfunction()
