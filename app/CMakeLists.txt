set(SOURCE_FILES sandbox_app.cpp)

add_executable(sandbox ${SOURCE_FILES})

target_include_directories(sandbox PRIVATE .. ../gemini/)
target_link_libraries(sandbox gemini ${CONAN_LIBS})

add_compile_options(-Wall -Wextra -Wpedantic -Werror)