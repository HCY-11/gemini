cmake_minimum_required(VERSION 3.9)
project(Gemini VERSION 1.0.0 DESCRIPTION "Gemini Engine")
include(GNUInstallDirs)

add_library(Gemini SHARED 
    ./gemini/core/application.cpp
    ./gemini/logging/logger.cpp
)

set_target_properties(Gemini PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    PUBLIC_HEADER api/Gemini.h)
configure_file(Gemini.pc.in Gemini.pc @ONLY)
target_include_directories(Gemini PRIVATE . ./gemini/)
install(TARGETS Gemini
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES ${CMAKE_BINARY_DIR}/Gemini.pc
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/pkgconfig)