cmake_minimum_required(VERSION 3.16)
project(gemini VERSION 1.0.0 DESCRIPTION "Gemini Game Engine")

include(GNUInstallDirs)
include(./conan/conanbuildinfo.cmake)

add_definitions("-std=c++20")
add_definitions("-g")

conan_basic_setup()

add_subdirectory(app)

add_subdirectory(gemini)
