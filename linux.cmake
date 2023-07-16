set(OPENCV_BUILD_PLATFORM linux)
set(OPENCV_PLATFORM_INSTALL_PATH "${OPENCV_INSTALL_PATH}/${OPENCV_BUILD_PLATFORM}")

function(build_opencv)
    execute_process(
        COMMAND ${CMAKE_COMMAND}
            -DCMAKE_BUILD_TYPE=Release
            -DCMAKE_INSTALL_PREFIX='${OPENCV_PLATFORM_INSTALL_PATH}'
            -DBUILD_PERF_TESTS=OFF
            -DBUILD_TESTS=OFF
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_opencv_apps=OFF
            -DBUILD_FAT_JAVA_LIB=OFF
            -DBUILD_JAVA=OFF
            -DWITH_TBB=ON
            -DBUILD_TBB=ON
            -DBUILD_opencv_python2=OFF
            -DBUILD_opencv_python3=OFF
            -DWITH_EIGEN=OFF
            -DINSTALL_BIN_EXAMPLES=OFF
            -DOPENCV_EXTRA_MODULES_PATH='${OCV_CONTRIB_DIR}'
            ..
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build .
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --install .
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
endfunction()

macro(set_ocv_dir)
    # don't know why, but on Ubuntu, gcc10.3 we have a lib folder, but on Fedora, gcc 11.1 we have lib64 folder
    if(EXISTS "${OPENCV_PLATFORM_INSTALL_PATH}/lib/cmake/opencv4")
        set(OpenCV_DIR "${OPENCV_PLATFORM_INSTALL_PATH}/lib/cmake/opencv4")
    elseif(EXISTS "${OPENCV_PLATFORM_INSTALL_PATH}/lib64/cmake/opencv4")
        set(OpenCV_DIR "${OPENCV_PLATFORM_INSTALL_PATH}/lib64/cmake/opencv4")
    endif()
endmacro()
