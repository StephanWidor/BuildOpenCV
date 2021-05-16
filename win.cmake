set(OPENCV_BUILD_PLATFORM win)
set(OPENCV_PLATFORM_INSTALL_PATH "${OPENCV_INSTALL_PATH}/${OPENCV_BUILD_PLATFORM}")

function(build_opencv)
    execute_process(
        COMMAND ${CMAKE_COMMAND}
            -DCMAKE_INSTALL_PREFIX='${OPENCV_PLATFORM_INSTALL_PATH}'
            -DBUILD_PERF_TESTS=OFF
            -DBUILD_TESTS=OFF
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_WITH_STATIC_CRT=OFF
            -DBUILD_opencv_apps=OFF
            -DBUILD_FAT_JAVA_LIB=OFF
            -DBUILD_JAVA=OFF
            -DBUILD_opencv_python2=OFF
            -DBUILD_opencv_python3=OFF
            -DWITH_EIGEN=OFF
            -DINSTALL_BIN_EXAMPLES=OFF
            -DOPENCV_EXTRA_MODULES_PATH='${OCV_CONTRIB_DIR}'
            ..
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . --target install --config Debug
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . --target install --config Release
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
endfunction()

macro(set_ocv_dir)
    set(OpenCV_DIR "${OPENCV_PLATFORM_INSTALL_PATH}")
endmacro()
