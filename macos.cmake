set(OPENCV_BUILD_PLATFORM macos)
set(OPENCV_PLATFORM_INSTALL_PATH "${OPENCV_INSTALL_PATH}/${OPENCV_BUILD_PLATFORM}")

function(build_opencv)
    execute_process(
        COMMAND ${CMAKE_COMMAND}
            -DCMAKE_OSX_ARCHITECTURES=x86_64
            -DCMAKE_BUILD_TYPE=Release
            -DCMAKE_INSTALL_PREFIX='${OPENCV_PLATFORM_INSTALL_PATH}'
            -DBUILD_PERF_TESTS=OFF
            -DBUILD_TESTS=OFF
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_opencv_apps=OFF
            -DBUILD_opencv_rgbd=OFF
            -DBUILD_opencv_python2=OFF
            -DBUILD_opencv_python3=OFF
            -DBUILD_FAT_JAVA_LIB=OFF
            -DBUILD_JAVA=OFF
            -DWITH_TBB=ON
            -DBUILD_TBB=ON
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
    set(OpenCV_DIR "${OPENCV_PLATFORM_INSTALL_PATH}/lib/cmake/opencv4")
endmacro()
