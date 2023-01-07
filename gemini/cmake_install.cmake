# Install script for directory: /home/henry/workspace/gemini/gemini

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so.1.0.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/henry/workspace/gemini/lib/libgemini.so.1.0.0"
    "/home/henry/workspace/gemini/lib/libgemini.so.1"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so.1.0.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib:/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/lib:/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib:/home/henry/.conan/data/vulkan-loader/1.2.172/_/_/package/4e7002e5f4df25945a2013e2f82418a3ba8ba05c/lib:/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib:/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/lib:/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib:/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/lib:/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib:/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib:/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/lib:/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib:/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib:"
           NEW_RPATH "")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/henry/workspace/gemini/lib/libgemini.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so"
         OLD_RPATH "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib:/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/lib:/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib:/home/henry/.conan/data/vulkan-loader/1.2.172/_/_/package/4e7002e5f4df25945a2013e2f82418a3ba8ba05c/lib:/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib:/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/lib:/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib:/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/lib:/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib:/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib:/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/lib:/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib:/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgemini.so")
    endif()
  endif()
endif()

