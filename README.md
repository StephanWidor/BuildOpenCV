# BuildOpenCV

OpenCV uses cmake, but unfortunately, it is not that easy to just add it as add_subdirectory in a cmake project.
Also cmake's ExternalProject or FetchContent doesn't seem to really work.
This is a workaround: The cmake project here downloads opencv, builds and installs it into build folder in the configure step,
and makes it available to parent projects.
You can then use OpenCV by adding this as a submodule to your cmake project and do
```
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/BuildOpenCV)
...
target_link_libraries(${TARGET_NAME} PRIVATE BuildOpenCV)
```

Works on my Arch Linux, also for cross compiling for android. Not sure about dependencies that I have installed by chance though...
Mac and Windows might work, but have not been tested.
