set(HEADER_FILES
    ./core/core.h
    ./core/application.h
    ./core/keycodes.h
    ./core/mousecodes.h
    ./core/window.h
    ./events/keyboard_events.h
    ./events/mouse_events.h
    ./events/app_events.h
    ./events/event.h
    ./logging/logger.h
)

set(SOURCE_FILES 
    ./core/window.cpp
    ./core/application.cpp
)

add_library(gemini SHARED 
    ${SOURCE_FILES}
)

set_target_properties(gemini PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

target_include_directories(gemini PUBLIC . ${CONAN_INCLUDE_DIRS})
target_link_libraries(gemini ${CONAN_LIBS})

install(TARGETS gemini
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

target_precompile_headers(gemini PRIVATE ${HEADER_FILES})