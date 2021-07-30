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
    ./layers/graphics_layer.h
    ./layers/layer_stack.h
    ./graphics/device.h
    ./graphics/gpu.h
    ./graphics/instance.h
    ./graphics/pipelines.h
    ./graphics/render_pass.h
    ./graphics/surface.h
    ./graphics/swapchain.h
    ./graphics/entities/vertex.h
    ./graphics/entities/mesh.h
    ./graphics/entities/entity.h
    ./graphics/entities/transform.h
    ./graphics/entities/camera.h
    ./graphics/buffers/framebuffers.h
    ./graphics/buffers/buffer.h
    ./graphics/buffers/vertex_buffer.h
    ./graphics/buffers/index_buffer.h
    ./graphics/pools/command_pool.h
)

set(SOURCE_FILES 
    ./core/window.cpp
    ./core/application.cpp
    ./core/vma.cpp
    ./layers/layer.cpp
    ./layers/graphics_layer.cpp
    ./layers/layer_stack.cpp
    ./graphics/device.cpp
    ./graphics/gpu.cpp
    ./graphics/instance.cpp
    ./graphics/pipelines.cpp
    ./graphics/render_pass.cpp
    ./graphics/surface.cpp
    ./graphics/swapchain.cpp
    ./graphics/buffers/framebuffers.cpp
    ./graphics/buffers/buffer.cpp
    ./graphics/buffers/vertex_buffer.cpp
    ./graphics/buffers/index_buffer.cpp
    ./graphics/pools/command_pool.cpp
    ./graphics/entities/entity.cpp
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
