function(build_ocv)
    execute_process(
        COMMAND ${CMAKE_COMMAND}
            -B${OCV_BUILD_DIR}
            -DCMAKE_BUILD_TYPE=${OCV_BUILD_TYPE}
            -DCMAKE_INSTALL_PREFIX='${OCV_INSTALL_DIR}'
            -DBUILD_WITH_STATIC_CRT=OFF
            -DWITH_ZLIB_NG=ON
            -DBUILD_PERF_TESTS=OFF
            -DBUILD_TESTS=OFF
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_opencv_apps=OFF
            -DBUILD_FAT_JAVA_LIB=OFF
            -DBUILD_JAVA=OFF
            -DBUILD_opencv_python2=OFF
            -DBUILD_opencv_python3=OFF
            -DWITH_EIGEN=OFF
            -DINSTALL_BIN_EXAMPLES=OFF
            -DOPENCV_EXTRA_MODULES_PATH='${OCV_CONTRIB_DIR}/modules'
            -DCMAKE_COLOR_DIAGNOSTICS=ON
            .
        WORKING_DIRECTORY "${OCV_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . --config ${OCV_BUILD_TYPE} -j -- /p:CL_MPCount=8
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --install . --config ${OCV_BUILD_TYPE}
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
endfunction()

macro(find_ocv)
    set(OpenCV_DIR "${OCV_INSTALL_DIR}")
    find_package(OpenCV REQUIRED)
endmacro()
