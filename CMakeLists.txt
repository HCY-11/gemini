cmake_minimum_required(VERSION 3.16)
project(gemini VERSION 1.0.0 DESCRIPTION "Gemini Game Engine")

include(GNUInstallDirs)
include(./conan/conanbuildinfo.cmake)

add_definitions("-std=c++17")
add_definitions("-g")

add_definitions(-DGM_ENABLE_ASSERT)
add_definitions(-DGM_ROOTDIR="/home/henry/workspace/gemini/")

conan_basic_setup()

add_subdirectory(app)

add_subdirectory(gemini)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
