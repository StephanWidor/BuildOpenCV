function(build_ocv)
    execute_process(
        COMMAND ${CMAKE_COMMAND}
            -B${OCV_BUILD_DIR}
            -DCMAKE_BUILD_TYPE=${OCV_BUILD_TYPE}
            -DCMAKE_PREFIX_PATH='${CMAKE_PREFIX_PATH}'
            -DCMAKE_INSTALL_PREFIX='${OCV_INSTALL_DIR}'
            -DCMAKE_C_COMPILER='${CMAKE_C_COMPILER}'
            -DCMAKE_CXX_COMPILER='${CMAKE_CXX_COMPILER}'
            -DANDROID_NDK='${ANDROID_NDK}'
            -DCMAKE_TOOLCHAIN_FILE='${CMAKE_TOOLCHAIN_FILE}'
            -DANDROID_SDK='${ANDROID_SDK}'
            -DANDROID_SDK_ROOT='${ANDROID_SDK_ROOT}'
            -DANDROID_MIN_SDK_VERSION='${ANDROID_MIN_SDK_VERSION}'
            -DANDROID_TARGET_SDK_VERSION='${ANDROID_TARGET_SDK_VERSION}'
            -DANDROID_NATIVE_API_LEVEL=${ANDROID_NATIVE_API_LEVEL}
            -DANDROID_PLATFORM=${ANDROID_PLATFORM}
            -DANDROID_STL=${ANDROID_STL}
            -DANDROID_ABI=${ANDROID_ABI}
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_ANDROID_PROJECTS=OFF
            -DBUILD_ANDROID_EXAMPLES=OFF
            -DBUILD_PERF_TESTS=OFF
            -DBUILD_TESTS=OFF
            -DBUILD_FAT_JAVA_LIB=OFF
            -DBUILD_JAVA=OFF
            -DBUILD_opencv_python2=OFF
            -DBUILD_opencv_python3=OFF
            -DOPENCV_EXTRA_MODULES_PATH='${OCV_CONTRIB_DIR}/modules'
            -DCMAKE_COLOR_DIAGNOSTICS=ON
            .
        WORKING_DIRECTORY "${OCV_DIR}"
    )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . --config ${OCV_BUILD_TYPE} --target all -j
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --install .
        WORKING_DIRECTORY "${OCV_BUILD_DIR}"
        )
endfunction()

macro(find_ocv)
    set(OpenCV_DIR "${OCV_INSTALL_DIR}/sdk/native/jni")
    find_package(Iconv REQUIRED)
    find_package(OpenCV REQUIRED)
endmacro()
