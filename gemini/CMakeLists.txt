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
    ./layers/layer.h
    ./layers/layer_stack.h
)

set(SOURCE_FILES 
    ./core/window.cpp
    ./core/application.cpp
    ./core/vma.cpp
    ./core/stb.cpp
    ./layers/layer.cpp
    ./layers/layer_stack.cpp
    ./graphics/device.cpp
    ./graphics/gpu.cpp
    ./graphics/instance.cpp
    ./graphics/pipeline.cpp
    ./graphics/shader.cpp
    ./graphics/render_pass.cpp
    ./graphics/surface.cpp
    ./graphics/command_pool.cpp
    ./graphics/swapchain.cpp
    ./graphics/descriptor_set_handler.cpp
    ./graphics/buffers/framebuffers.cpp
    ./graphics/buffers/buffer.cpp
    ./graphics/buffers/vertex_buffer.cpp
    ./graphics/buffers/index_buffer.cpp
    ./graphics/buffers/uniform_buffer.cpp
    ./graphics/images/image.cpp
    ./graphics/images/depth_image.cpp
    ./graphics/images/textured_image.cpp
    ./graphics/entities/render_object.cpp
    ./graphics/math/math.cpp
    ./graphics/graphics_layer.cpp
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
