function(build_ocv)
    execute_process(
        COMMAND ${CMAKE_COMMAND}
            -B${OCV_BUILD_DIR}
            -DCMAKE_BUILD_TYPE=${OCV_BUILD_TYPE}
            -DCMAKE_INSTALL_PREFIX='${OCV_INSTALL_DIR}'
            -DBUILD_PERF_TESTS=OFF
            -DBUILD_TESTS=OFF
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_opencv_apps=OFF
            -DBUILD_opencv_rgbd=OFF
            -DBUILD_opencv_python2=OFF
            -DBUILD_opencv_python3=OFF
            -DBUILD_FAT_JAVA_LIB=OFF
            -DBUILD_JAVA=OFF
            -DWITH_EIGEN=OFF
            -DINSTALL_BIN_EXAMPLES=OFF
            -DOPENCV_EXTRA_MODULES_PATH='${OCV_CONTRIB_DIR}/modules'
            -DCMAKE_COLOR_DIAGNOSTICS=ON
            .
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
    )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -j
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
    )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --install .
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
    )
endfunction()

macro(find_ocv)
    set(OpenCV_DIR "${OCV_INSTALL_DIR}/lib/cmake/opencv4")
    find_package(OpenCV REQUIRED PATHS "${OpenCV_DIR}" NO_DEFAULT_PATH)
endmacro()
