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
        COMMAND ${CMAKE_COMMAND} --build . -j
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
    )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --install .
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
    )
endfunction()

macro(find_ocv)
    # don't know why, but seems on some builds we have lib folder, while on others it is lib64
    if(EXISTS "${OCV_INSTALL_DIR}/lib/cmake/opencv4")
        set(OpenCV_DIR "${OCV_INSTALL_DIR}/lib/cmake/opencv4")
    elseif(EXISTS "${OCV_INSTALL_DIR}/lib64/cmake/opencv4")
        set(OpenCV_DIR "${OCV_INSTALL_DIR}/lib64/cmake/opencv4")
    endif()
    
    find_package(OpenCV REQUIRED)
    find_package(OpenEXR REQUIRED)
    find_package(Iconv REQUIRED)
endmacro()
