cmake_minimum_required(VERSION 3.10)

include(GNUInstallDirs)

project(Gemini VERSION 1.0.0 DESCRIPTION "Gemini C++/Vulkan Engine")

add_library(Gemini STATIC
    ./gemini/core/window.cpp
    ./gemini/graphics/instance.cpp
    ./gemini/graphics/gpu.cpp
    ./gemini/graphics/device.cpp
    ./gemini/graphics/swapchain.cpp
    ./gemini/graphics/surface.cpp
    ./gemini/graphics/renderpass.cpp
    ./gemini/graphics/renderer.cpp
    ./gemini/graphics/pipelines.cpp
    ./gemini/graphics/vma.cpp
    ./gemini/util/callbacks.cpp
    ./gemini/app/iapp.cpp
)

set_target_properties(Gemini PROPERTIES VERSION ${PROJECT_VERSION})

configure_file(Gemini.pc.in Gemini.pc @ONLY)
target_include_directories(Gemini PRIVATE . ./gemini/)
target_compile_features(Gemini PRIVATE cxx_std_17)

install(TARGETS Gemini
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(FILES ${CMAKE_BINARY_DIR}/Gemini.pc DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/pkgconfig)