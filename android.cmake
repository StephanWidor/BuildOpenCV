set(SDK_PATH "/opt/android/android-sdk" CACHE PATH "")
set(NDK_PATH "/opt/android/android-sdk/ndk/21.3.6528147" CACHE PATH "")
set(NDK_BIN_PATH "${NDK_PATH}/toolchains/llvm/prebuilt/linux-x86_64/bin" CACHE PATH "")

set(OPENCV_BUILD_PLATFORM android)
set(OPENCV_PLATFORM_INSTALL_PATH "${OPENCV_INSTALL_PATH}/${OPENCV_BUILD_PLATFORM}")
set(OpenCV_DIR "${OPENCV_PLATFORM_INSTALL_PATH}/sdk/native/jni")
set(ABIS_TO_BUILD "armeabi-v7a;arm64-v8a;x86;x86_64")

function(make_abi ABI)
    message("Building ABI " ${ABI})
    set(ABI_BUILD_DIR "${OCV_BUILD_DIR}/${ABI}")
    file(MAKE_DIRECTORY ${ABI_BUILD_DIR})
    execute_process(
        COMMAND ${CMAKE_COMMAND}
            -GNinja
            -DCMAKE_C_COMPILER='${NDK_BIN_PATH}/clang'
            -DCMAKE_CXX_COMPILER='${NDK_BIN_PATH}/clang++'
            -DANDROID_NDK='${NDK_PATH}'
            -DCMAKE_TOOLCHAIN_FILE='${NDK_PATH}/build/cmake/android.toolchain.cmake'
            -DANDROID_SDK='$SDK_PATH'
            -DANDROID_NATIVE_API_LEVEL=21
            -DCMAKE_INSTALL_PREFIX='${OPENCV_PLATFORM_INSTALL_PATH}'
            -DCMAKE_BUILD_TYPE=Release
            -DWITH_TBB=ON
            -DANDROID_ABI=${ABI}
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_ANDROID_PROJECTS=OFF
            -DBUILD_ANDROID_EXAMPLES=OFF
            -DBUILD_PERF_TESTS=OFF
            -DBUILD_TESTS=OFF
            -DBUILD_FAT_JAVA_LIB=OFF
            -DBUILD_JAVA=OFF
            -DOPENCV_EXTRA_MODULES_PATH='${OCV_CONTRIB_DIR}'
            ../..
        WORKING_DIRECTORY "${ABI_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . --config Release --target all
        WORKING_DIRECTORY "${ABI_BUILD_DIR}"
        )
    execute_process(
        COMMAND ${CMAKE_COMMAND} --install .
        WORKING_DIRECTORY "${ABI_BUILD_DIR}"
        )

    # somehow we need to explicitly strip because debug symbols are also added in release build
    file(GLOB OCV_LIBS "${OPENCV_PLATFORM_INSTALL_PATH}/sdk/native/staticlibs/${ABI}/*.a")
    file(GLOB THIRDPARTY_LIBS "${OPENCV_PLATFORM_INSTALL_PATH}/sdk/native/3rdparty/libs/${ABI}/*.a")
    set(ALL_LIBS "${OCV_LIBS};${THIRDPARTY_LIBS}")
    set(STRIP_COMMAND "${NDK_BIN_PATH}/llvm-strip")
    foreach(LIB ${ALL_LIBS})
        execute_process(
            COMMAND ${STRIP_COMMAND} --strip-debug ${LIB}
            )
    endforeach()
endfunction()

function(build_opencv)
    foreach(ABI ${ABIS_TO_BUILD})
        make_abi(${ABI})
    endforeach()
endfunction()
