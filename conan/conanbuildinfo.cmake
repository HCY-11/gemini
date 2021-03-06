include(CMakeParseArguments)

macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS SUFFIX BUILD_TYPE)
    if(APPLE)
        if(CMAKE_BUILD_TYPE)
            set(_BTYPE ${CMAKE_BUILD_TYPE})
        elseif(NOT BUILD_TYPE STREQUAL "")
            set(_BTYPE ${BUILD_TYPE})
        endif()
        if(_BTYPE)
            if(${_BTYPE} MATCHES "Debug|_DEBUG")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "Release|_RELEASE")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "RelWithDebInfo|_RELWITHDEBINFO")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "MinSizeRel|_MINSIZEREL")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            endif()
        endif()
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAME ${_FRAMEWORK} PATHS ${CONAN_FRAMEWORK_DIRS${SUFFIX}} CMAKE_FIND_ROOT_PATH_BOTH)
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${CONAN_FRAMEWORK_DIRS${SUFFIX}}")
            endif()
        endforeach()
    endif()
endmacro()


#################
###  GLFW
#################
set(CONAN_GLFW_ROOT "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722")
set(CONAN_INCLUDE_DIRS_GLFW "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/include")
set(CONAN_LIB_DIRS_GLFW "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib")
set(CONAN_BIN_DIRS_GLFW )
set(CONAN_RES_DIRS_GLFW )
set(CONAN_SRC_DIRS_GLFW )
set(CONAN_BUILD_DIRS_GLFW "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/"
			"/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_GLFW )
set(CONAN_LIBS_GLFW glfw3)
set(CONAN_PKG_LIBS_GLFW glfw3)
set(CONAN_SYSTEM_LIBS_GLFW m pthread dl rt)
set(CONAN_FRAMEWORKS_GLFW )
set(CONAN_FRAMEWORKS_FOUND_GLFW "")  # Will be filled later
set(CONAN_DEFINES_GLFW )
set(CONAN_BUILD_MODULES_PATHS_GLFW "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib/cmake/conan-official-glfw-targets.cmake")
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_GLFW )

set(CONAN_C_FLAGS_GLFW "")
set(CONAN_CXX_FLAGS_GLFW "")
set(CONAN_SHARED_LINKER_FLAGS_GLFW "")
set(CONAN_EXE_LINKER_FLAGS_GLFW "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_GLFW_LIST "")
set(CONAN_CXX_FLAGS_GLFW_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_GLFW_LIST "")
set(CONAN_EXE_LINKER_FLAGS_GLFW_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_GLFW "${CONAN_FRAMEWORKS_GLFW}" "_GLFW" "")
# Append to aggregated values variable
set(CONAN_LIBS_GLFW ${CONAN_PKG_LIBS_GLFW} ${CONAN_SYSTEM_LIBS_GLFW} ${CONAN_FRAMEWORKS_FOUND_GLFW})


#################
###  SPDLOG
#################
set(CONAN_SPDLOG_ROOT "/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a")
set(CONAN_INCLUDE_DIRS_SPDLOG "/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/include")
set(CONAN_LIB_DIRS_SPDLOG "/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/lib")
set(CONAN_BIN_DIRS_SPDLOG )
set(CONAN_RES_DIRS_SPDLOG )
set(CONAN_SRC_DIRS_SPDLOG )
set(CONAN_BUILD_DIRS_SPDLOG "/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/")
set(CONAN_FRAMEWORK_DIRS_SPDLOG )
set(CONAN_LIBS_SPDLOG spdlog)
set(CONAN_PKG_LIBS_SPDLOG spdlog)
set(CONAN_SYSTEM_LIBS_SPDLOG pthread)
set(CONAN_FRAMEWORKS_SPDLOG )
set(CONAN_FRAMEWORKS_FOUND_SPDLOG "")  # Will be filled later
set(CONAN_DEFINES_SPDLOG "-DSPDLOG_COMPILED_LIB"
			"-DSPDLOG_FMT_EXTERNAL")
set(CONAN_BUILD_MODULES_PATHS_SPDLOG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_SPDLOG "SPDLOG_COMPILED_LIB"
			"SPDLOG_FMT_EXTERNAL")

set(CONAN_C_FLAGS_SPDLOG "")
set(CONAN_CXX_FLAGS_SPDLOG "")
set(CONAN_SHARED_LINKER_FLAGS_SPDLOG "")
set(CONAN_EXE_LINKER_FLAGS_SPDLOG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_SPDLOG_LIST "")
set(CONAN_CXX_FLAGS_SPDLOG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_SPDLOG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_SPDLOG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_SPDLOG "${CONAN_FRAMEWORKS_SPDLOG}" "_SPDLOG" "")
# Append to aggregated values variable
set(CONAN_LIBS_SPDLOG ${CONAN_PKG_LIBS_SPDLOG} ${CONAN_SYSTEM_LIBS_SPDLOG} ${CONAN_FRAMEWORKS_FOUND_SPDLOG})


#################
###  IMGUI
#################
set(CONAN_IMGUI_ROOT "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e")
set(CONAN_INCLUDE_DIRS_IMGUI "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/include")
set(CONAN_LIB_DIRS_IMGUI "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib")
set(CONAN_BIN_DIRS_IMGUI "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/bin")
set(CONAN_RES_DIRS_IMGUI "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/res")
set(CONAN_SRC_DIRS_IMGUI "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/res/bindings")
set(CONAN_BUILD_DIRS_IMGUI "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/")
set(CONAN_FRAMEWORK_DIRS_IMGUI )
set(CONAN_LIBS_IMGUI imgui)
set(CONAN_PKG_LIBS_IMGUI imgui)
set(CONAN_SYSTEM_LIBS_IMGUI m)
set(CONAN_FRAMEWORKS_IMGUI )
set(CONAN_FRAMEWORKS_FOUND_IMGUI "")  # Will be filled later
set(CONAN_DEFINES_IMGUI )
set(CONAN_BUILD_MODULES_PATHS_IMGUI )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_IMGUI )

set(CONAN_C_FLAGS_IMGUI "")
set(CONAN_CXX_FLAGS_IMGUI "")
set(CONAN_SHARED_LINKER_FLAGS_IMGUI "")
set(CONAN_EXE_LINKER_FLAGS_IMGUI "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_IMGUI_LIST "")
set(CONAN_CXX_FLAGS_IMGUI_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_IMGUI_LIST "")
set(CONAN_EXE_LINKER_FLAGS_IMGUI_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_IMGUI "${CONAN_FRAMEWORKS_IMGUI}" "_IMGUI" "")
# Append to aggregated values variable
set(CONAN_LIBS_IMGUI ${CONAN_PKG_LIBS_IMGUI} ${CONAN_SYSTEM_LIBS_IMGUI} ${CONAN_FRAMEWORKS_FOUND_IMGUI})


#################
###  GLM
#################
set(CONAN_GLM_ROOT "/home/henry/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_GLM "/home/henry/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_GLM )
set(CONAN_BIN_DIRS_GLM )
set(CONAN_RES_DIRS_GLM )
set(CONAN_SRC_DIRS_GLM )
set(CONAN_BUILD_DIRS_GLM "/home/henry/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_GLM )
set(CONAN_LIBS_GLM )
set(CONAN_PKG_LIBS_GLM )
set(CONAN_SYSTEM_LIBS_GLM )
set(CONAN_FRAMEWORKS_GLM )
set(CONAN_FRAMEWORKS_FOUND_GLM "")  # Will be filled later
set(CONAN_DEFINES_GLM )
set(CONAN_BUILD_MODULES_PATHS_GLM )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_GLM )

set(CONAN_C_FLAGS_GLM "")
set(CONAN_CXX_FLAGS_GLM "")
set(CONAN_SHARED_LINKER_FLAGS_GLM "")
set(CONAN_EXE_LINKER_FLAGS_GLM "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_GLM_LIST "")
set(CONAN_CXX_FLAGS_GLM_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_GLM_LIST "")
set(CONAN_EXE_LINKER_FLAGS_GLM_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_GLM "${CONAN_FRAMEWORKS_GLM}" "_GLM" "")
# Append to aggregated values variable
set(CONAN_LIBS_GLM ${CONAN_PKG_LIBS_GLM} ${CONAN_SYSTEM_LIBS_GLM} ${CONAN_FRAMEWORKS_FOUND_GLM})


#################
###  VULKAN-MEMORY-ALLOCATOR
#################
set(CONAN_VULKAN-MEMORY-ALLOCATOR_ROOT "/home/henry/.conan/data/vulkan-memory-allocator/2.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_VULKAN-MEMORY-ALLOCATOR "/home/henry/.conan/data/vulkan-memory-allocator/2.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_BIN_DIRS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_RES_DIRS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_SRC_DIRS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_BUILD_DIRS_VULKAN-MEMORY-ALLOCATOR "/home/henry/.conan/data/vulkan-memory-allocator/2.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_LIBS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_SYSTEM_LIBS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_FRAMEWORKS_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR "")  # Will be filled later
set(CONAN_DEFINES_VULKAN-MEMORY-ALLOCATOR )
set(CONAN_BUILD_MODULES_PATHS_VULKAN-MEMORY-ALLOCATOR )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VULKAN-MEMORY-ALLOCATOR )

set(CONAN_C_FLAGS_VULKAN-MEMORY-ALLOCATOR "")
set(CONAN_CXX_FLAGS_VULKAN-MEMORY-ALLOCATOR "")
set(CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR "")
set(CONAN_EXE_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST "")
set(CONAN_CXX_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR "${CONAN_FRAMEWORKS_VULKAN-MEMORY-ALLOCATOR}" "_VULKAN-MEMORY-ALLOCATOR" "")
# Append to aggregated values variable
set(CONAN_LIBS_VULKAN-MEMORY-ALLOCATOR ${CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR} ${CONAN_SYSTEM_LIBS_VULKAN-MEMORY-ALLOCATOR} ${CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR})


#################
###  VULKAN-LOADER
#################
set(CONAN_VULKAN-LOADER_ROOT "/home/henry/.conan/data/vulkan-loader/1.2.172/_/_/package/4e7002e5f4df25945a2013e2f82418a3ba8ba05c")
set(CONAN_INCLUDE_DIRS_VULKAN-LOADER "/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/res/vulkan/registry")
set(CONAN_LIB_DIRS_VULKAN-LOADER "/home/henry/.conan/data/vulkan-loader/1.2.172/_/_/package/4e7002e5f4df25945a2013e2f82418a3ba8ba05c/lib")
set(CONAN_BIN_DIRS_VULKAN-LOADER )
set(CONAN_RES_DIRS_VULKAN-LOADER )
set(CONAN_SRC_DIRS_VULKAN-LOADER )
set(CONAN_BUILD_DIRS_VULKAN-LOADER "/home/henry/.conan/data/vulkan-loader/1.2.172/_/_/package/4e7002e5f4df25945a2013e2f82418a3ba8ba05c/")
set(CONAN_FRAMEWORK_DIRS_VULKAN-LOADER )
set(CONAN_LIBS_VULKAN-LOADER vulkan)
set(CONAN_PKG_LIBS_VULKAN-LOADER vulkan)
set(CONAN_SYSTEM_LIBS_VULKAN-LOADER dl pthread m)
set(CONAN_FRAMEWORKS_VULKAN-LOADER )
set(CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER "")  # Will be filled later
set(CONAN_DEFINES_VULKAN-LOADER )
set(CONAN_BUILD_MODULES_PATHS_VULKAN-LOADER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VULKAN-LOADER )

set(CONAN_C_FLAGS_VULKAN-LOADER "")
set(CONAN_CXX_FLAGS_VULKAN-LOADER "")
set(CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER "")
set(CONAN_EXE_LINKER_FLAGS_VULKAN-LOADER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VULKAN-LOADER_LIST "")
set(CONAN_CXX_FLAGS_VULKAN-LOADER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VULKAN-LOADER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER "${CONAN_FRAMEWORKS_VULKAN-LOADER}" "_VULKAN-LOADER" "")
# Append to aggregated values variable
set(CONAN_LIBS_VULKAN-LOADER ${CONAN_PKG_LIBS_VULKAN-LOADER} ${CONAN_SYSTEM_LIBS_VULKAN-LOADER} ${CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER})


#################
###  TINYOBJLOADER
#################
set(CONAN_TINYOBJLOADER_ROOT "/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e")
set(CONAN_INCLUDE_DIRS_TINYOBJLOADER "/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/include")
set(CONAN_LIB_DIRS_TINYOBJLOADER "/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib")
set(CONAN_BIN_DIRS_TINYOBJLOADER )
set(CONAN_RES_DIRS_TINYOBJLOADER )
set(CONAN_SRC_DIRS_TINYOBJLOADER )
set(CONAN_BUILD_DIRS_TINYOBJLOADER "/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/"
			"/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_TINYOBJLOADER )
set(CONAN_LIBS_TINYOBJLOADER tinyobjloader)
set(CONAN_PKG_LIBS_TINYOBJLOADER tinyobjloader)
set(CONAN_SYSTEM_LIBS_TINYOBJLOADER )
set(CONAN_FRAMEWORKS_TINYOBJLOADER )
set(CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER "")  # Will be filled later
set(CONAN_DEFINES_TINYOBJLOADER )
set(CONAN_BUILD_MODULES_PATHS_TINYOBJLOADER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_TINYOBJLOADER )

set(CONAN_C_FLAGS_TINYOBJLOADER "")
set(CONAN_CXX_FLAGS_TINYOBJLOADER "")
set(CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER "")
set(CONAN_EXE_LINKER_FLAGS_TINYOBJLOADER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_TINYOBJLOADER_LIST "")
set(CONAN_CXX_FLAGS_TINYOBJLOADER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_TINYOBJLOADER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER "${CONAN_FRAMEWORKS_TINYOBJLOADER}" "_TINYOBJLOADER" "")
# Append to aggregated values variable
set(CONAN_LIBS_TINYOBJLOADER ${CONAN_PKG_LIBS_TINYOBJLOADER} ${CONAN_SYSTEM_LIBS_TINYOBJLOADER} ${CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER})


#################
###  STB
#################
set(CONAN_STB_ROOT "/home/henry/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_STB "/home/henry/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_STB )
set(CONAN_BIN_DIRS_STB )
set(CONAN_RES_DIRS_STB )
set(CONAN_SRC_DIRS_STB )
set(CONAN_BUILD_DIRS_STB "/home/henry/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_STB )
set(CONAN_LIBS_STB )
set(CONAN_PKG_LIBS_STB )
set(CONAN_SYSTEM_LIBS_STB )
set(CONAN_FRAMEWORKS_STB )
set(CONAN_FRAMEWORKS_FOUND_STB "")  # Will be filled later
set(CONAN_DEFINES_STB "-DSTB_TEXTEDIT_KEYTYPE=unsigned")
set(CONAN_BUILD_MODULES_PATHS_STB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_STB "STB_TEXTEDIT_KEYTYPE=unsigned")

set(CONAN_C_FLAGS_STB "")
set(CONAN_CXX_FLAGS_STB "")
set(CONAN_SHARED_LINKER_FLAGS_STB "")
set(CONAN_EXE_LINKER_FLAGS_STB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_STB_LIST "")
set(CONAN_CXX_FLAGS_STB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_STB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_STB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_STB "${CONAN_FRAMEWORKS_STB}" "_STB" "")
# Append to aggregated values variable
set(CONAN_LIBS_STB ${CONAN_PKG_LIBS_STB} ${CONAN_SYSTEM_LIBS_STB} ${CONAN_FRAMEWORKS_FOUND_STB})


#################
###  SPIRV-CROSS
#################
set(CONAN_SPIRV-CROSS_ROOT "/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83")
set(CONAN_INCLUDE_DIRS_SPIRV-CROSS "/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/include"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/include/spirv_cross")
set(CONAN_LIB_DIRS_SPIRV-CROSS "/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/lib")
set(CONAN_BIN_DIRS_SPIRV-CROSS "/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/bin")
set(CONAN_RES_DIRS_SPIRV-CROSS )
set(CONAN_SRC_DIRS_SPIRV-CROSS )
set(CONAN_BUILD_DIRS_SPIRV-CROSS "/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_SPIRV-CROSS )
set(CONAN_LIBS_SPIRV-CROSS spirv-cross-c spirv-cross-hlsl spirv-cross-msl spirv-cross-cpp spirv-cross-glsl spirv-cross-reflect spirv-cross-util spirv-cross-core)
set(CONAN_PKG_LIBS_SPIRV-CROSS spirv-cross-c spirv-cross-hlsl spirv-cross-msl spirv-cross-cpp spirv-cross-glsl spirv-cross-reflect spirv-cross-util spirv-cross-core)
set(CONAN_SYSTEM_LIBS_SPIRV-CROSS m stdc++)
set(CONAN_FRAMEWORKS_SPIRV-CROSS )
set(CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS "")  # Will be filled later
set(CONAN_DEFINES_SPIRV-CROSS "-DSPIRV_CROSS_NAMESPACE_OVERRIDE=spirv_cross")
set(CONAN_BUILD_MODULES_PATHS_SPIRV-CROSS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_SPIRV-CROSS "SPIRV_CROSS_NAMESPACE_OVERRIDE=spirv_cross")

set(CONAN_C_FLAGS_SPIRV-CROSS "")
set(CONAN_CXX_FLAGS_SPIRV-CROSS "")
set(CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS "")
set(CONAN_EXE_LINKER_FLAGS_SPIRV-CROSS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_SPIRV-CROSS_LIST "")
set(CONAN_CXX_FLAGS_SPIRV-CROSS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_SPIRV-CROSS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS "${CONAN_FRAMEWORKS_SPIRV-CROSS}" "_SPIRV-CROSS" "")
# Append to aggregated values variable
set(CONAN_LIBS_SPIRV-CROSS ${CONAN_PKG_LIBS_SPIRV-CROSS} ${CONAN_SYSTEM_LIBS_SPIRV-CROSS} ${CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS})


#################
###  OPENGL
#################
set(CONAN_OPENGL_ROOT "/home/henry/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_OPENGL )
set(CONAN_LIB_DIRS_OPENGL )
set(CONAN_BIN_DIRS_OPENGL )
set(CONAN_RES_DIRS_OPENGL )
set(CONAN_SRC_DIRS_OPENGL )
set(CONAN_BUILD_DIRS_OPENGL "/home/henry/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_OPENGL )
set(CONAN_LIBS_OPENGL )
set(CONAN_PKG_LIBS_OPENGL )
set(CONAN_SYSTEM_LIBS_OPENGL GL)
set(CONAN_FRAMEWORKS_OPENGL )
set(CONAN_FRAMEWORKS_FOUND_OPENGL "")  # Will be filled later
set(CONAN_DEFINES_OPENGL )
set(CONAN_BUILD_MODULES_PATHS_OPENGL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENGL )

set(CONAN_C_FLAGS_OPENGL "")
set(CONAN_CXX_FLAGS_OPENGL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENGL_LIST "")
set(CONAN_CXX_FLAGS_OPENGL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENGL "${CONAN_FRAMEWORKS_OPENGL}" "_OPENGL" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENGL ${CONAN_PKG_LIBS_OPENGL} ${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL})


#################
###  XORG
#################
set(CONAN_XORG_ROOT "/home/henry/.conan/data/xorg/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_XORG "/usr/include/freetype2"
			"/usr/include/libpng16"
			"/usr/include/harfbuzz"
			"/usr/include/glib-2.0"
			"/usr/lib/glib-2.0/include")
set(CONAN_LIB_DIRS_XORG )
set(CONAN_BIN_DIRS_XORG )
set(CONAN_RES_DIRS_XORG )
set(CONAN_SRC_DIRS_XORG )
set(CONAN_BUILD_DIRS_XORG "/home/henry/.conan/data/xorg/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_XORG )
set(CONAN_LIBS_XORG )
set(CONAN_PKG_LIBS_XORG )
set(CONAN_SYSTEM_LIBS_XORG X11 X11-xcb xcb fontenc ICE SM Xau Xaw7 Xt Xcomposite Xcursor Xdamage Xfixes Xdmcp Xext Xft Xi Xinerama xkbfile Xmu Xmuu Xpm Xrandr Xrender XRes Xss Xtst Xv XvMC Xxf86vm xcb-xkb xcb-icccm xcb-image xcb-shm xcb-keysyms xcb-randr xcb-render xcb-render-util xcb-shape xcb-sync xcb-xfixes xcb-xinerama xcb-util xcb-dri3)
set(CONAN_FRAMEWORKS_XORG )
set(CONAN_FRAMEWORKS_FOUND_XORG "")  # Will be filled later
set(CONAN_DEFINES_XORG "-D_DEFAULT_SOURCE"
			"-D_BSD_SOURCE"
			"-DHAS_FCHOWN"
			"-DHAS_STICKY_DIR_BIT")
set(CONAN_BUILD_MODULES_PATHS_XORG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_XORG "_DEFAULT_SOURCE"
			"_BSD_SOURCE"
			"HAS_FCHOWN"
			"HAS_STICKY_DIR_BIT")

set(CONAN_C_FLAGS_XORG "")
set(CONAN_CXX_FLAGS_XORG "")
set(CONAN_SHARED_LINKER_FLAGS_XORG "")
set(CONAN_EXE_LINKER_FLAGS_XORG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_XORG_LIST "")
set(CONAN_CXX_FLAGS_XORG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_XORG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_XORG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_XORG "${CONAN_FRAMEWORKS_XORG}" "_XORG" "")
# Append to aggregated values variable
set(CONAN_LIBS_XORG ${CONAN_PKG_LIBS_XORG} ${CONAN_SYSTEM_LIBS_XORG} ${CONAN_FRAMEWORKS_FOUND_XORG})


#################
###  FMT
#################
set(CONAN_FMT_ROOT "/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e")
set(CONAN_INCLUDE_DIRS_FMT "/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/include")
set(CONAN_LIB_DIRS_FMT "/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib")
set(CONAN_BIN_DIRS_FMT )
set(CONAN_RES_DIRS_FMT )
set(CONAN_SRC_DIRS_FMT )
set(CONAN_BUILD_DIRS_FMT "/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/")
set(CONAN_FRAMEWORK_DIRS_FMT )
set(CONAN_LIBS_FMT fmt)
set(CONAN_PKG_LIBS_FMT fmt)
set(CONAN_SYSTEM_LIBS_FMT )
set(CONAN_FRAMEWORKS_FMT )
set(CONAN_FRAMEWORKS_FOUND_FMT "")  # Will be filled later
set(CONAN_DEFINES_FMT )
set(CONAN_BUILD_MODULES_PATHS_FMT )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FMT )

set(CONAN_C_FLAGS_FMT "")
set(CONAN_CXX_FLAGS_FMT "")
set(CONAN_SHARED_LINKER_FLAGS_FMT "")
set(CONAN_EXE_LINKER_FLAGS_FMT "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FMT_LIST "")
set(CONAN_CXX_FLAGS_FMT_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FMT_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FMT_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FMT "${CONAN_FRAMEWORKS_FMT}" "_FMT" "")
# Append to aggregated values variable
set(CONAN_LIBS_FMT ${CONAN_PKG_LIBS_FMT} ${CONAN_SYSTEM_LIBS_FMT} ${CONAN_FRAMEWORKS_FOUND_FMT})


#################
###  VULKAN-HEADERS
#################
set(CONAN_VULKAN-HEADERS_ROOT "/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_VULKAN-HEADERS "/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/res/vulkan/registry")
set(CONAN_LIB_DIRS_VULKAN-HEADERS )
set(CONAN_BIN_DIRS_VULKAN-HEADERS )
set(CONAN_RES_DIRS_VULKAN-HEADERS "/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/res")
set(CONAN_SRC_DIRS_VULKAN-HEADERS )
set(CONAN_BUILD_DIRS_VULKAN-HEADERS "/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_VULKAN-HEADERS )
set(CONAN_LIBS_VULKAN-HEADERS )
set(CONAN_PKG_LIBS_VULKAN-HEADERS )
set(CONAN_SYSTEM_LIBS_VULKAN-HEADERS )
set(CONAN_FRAMEWORKS_VULKAN-HEADERS )
set(CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS "")  # Will be filled later
set(CONAN_DEFINES_VULKAN-HEADERS )
set(CONAN_BUILD_MODULES_PATHS_VULKAN-HEADERS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VULKAN-HEADERS )

set(CONAN_C_FLAGS_VULKAN-HEADERS "")
set(CONAN_CXX_FLAGS_VULKAN-HEADERS "")
set(CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS "")
set(CONAN_EXE_LINKER_FLAGS_VULKAN-HEADERS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VULKAN-HEADERS_LIST "")
set(CONAN_CXX_FLAGS_VULKAN-HEADERS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VULKAN-HEADERS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS "${CONAN_FRAMEWORKS_VULKAN-HEADERS}" "_VULKAN-HEADERS" "")
# Append to aggregated values variable
set(CONAN_LIBS_VULKAN-HEADERS ${CONAN_PKG_LIBS_VULKAN-HEADERS} ${CONAN_SYSTEM_LIBS_VULKAN-HEADERS} ${CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS})


#################
###  WAYLAND
#################
set(CONAN_WAYLAND_ROOT "/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052")
set(CONAN_INCLUDE_DIRS_WAYLAND "/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/include")
set(CONAN_LIB_DIRS_WAYLAND "/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/lib")
set(CONAN_BIN_DIRS_WAYLAND "/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/bin")
set(CONAN_RES_DIRS_WAYLAND "/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/res")
set(CONAN_SRC_DIRS_WAYLAND )
set(CONAN_BUILD_DIRS_WAYLAND "/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/")
set(CONAN_FRAMEWORK_DIRS_WAYLAND )
set(CONAN_LIBS_WAYLAND wayland-server wayland-cursor wayland-egl wayland-client)
set(CONAN_PKG_LIBS_WAYLAND wayland-server wayland-cursor wayland-egl wayland-client)
set(CONAN_SYSTEM_LIBS_WAYLAND pthread m)
set(CONAN_FRAMEWORKS_WAYLAND )
set(CONAN_FRAMEWORKS_FOUND_WAYLAND "")  # Will be filled later
set(CONAN_DEFINES_WAYLAND )
set(CONAN_BUILD_MODULES_PATHS_WAYLAND )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_WAYLAND )

set(CONAN_C_FLAGS_WAYLAND "")
set(CONAN_CXX_FLAGS_WAYLAND "")
set(CONAN_SHARED_LINKER_FLAGS_WAYLAND "")
set(CONAN_EXE_LINKER_FLAGS_WAYLAND "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_WAYLAND_LIST "")
set(CONAN_CXX_FLAGS_WAYLAND_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_WAYLAND_LIST "")
set(CONAN_EXE_LINKER_FLAGS_WAYLAND_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_WAYLAND "${CONAN_FRAMEWORKS_WAYLAND}" "_WAYLAND" "")
# Append to aggregated values variable
set(CONAN_LIBS_WAYLAND ${CONAN_PKG_LIBS_WAYLAND} ${CONAN_SYSTEM_LIBS_WAYLAND} ${CONAN_FRAMEWORKS_FOUND_WAYLAND})


#################
###  LIBFFI
#################
set(CONAN_LIBFFI_ROOT "/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646")
set(CONAN_INCLUDE_DIRS_LIBFFI "/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/include")
set(CONAN_LIB_DIRS_LIBFFI "/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib")
set(CONAN_BIN_DIRS_LIBFFI )
set(CONAN_RES_DIRS_LIBFFI )
set(CONAN_SRC_DIRS_LIBFFI )
set(CONAN_BUILD_DIRS_LIBFFI "/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/")
set(CONAN_FRAMEWORK_DIRS_LIBFFI )
set(CONAN_LIBS_LIBFFI ffi)
set(CONAN_PKG_LIBS_LIBFFI ffi)
set(CONAN_SYSTEM_LIBS_LIBFFI )
set(CONAN_FRAMEWORKS_LIBFFI )
set(CONAN_FRAMEWORKS_FOUND_LIBFFI "")  # Will be filled later
set(CONAN_DEFINES_LIBFFI "-DFFI_BUILDING")
set(CONAN_BUILD_MODULES_PATHS_LIBFFI )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBFFI "FFI_BUILDING")

set(CONAN_C_FLAGS_LIBFFI "")
set(CONAN_CXX_FLAGS_LIBFFI "")
set(CONAN_SHARED_LINKER_FLAGS_LIBFFI "")
set(CONAN_EXE_LINKER_FLAGS_LIBFFI "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBFFI_LIST "")
set(CONAN_CXX_FLAGS_LIBFFI_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBFFI_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBFFI_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBFFI "${CONAN_FRAMEWORKS_LIBFFI}" "_LIBFFI" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBFFI ${CONAN_PKG_LIBS_LIBFFI} ${CONAN_SYSTEM_LIBS_LIBFFI} ${CONAN_FRAMEWORKS_FOUND_LIBFFI})


#################
###  LIBXML2
#################
set(CONAN_LIBXML2_ROOT "/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d")
set(CONAN_INCLUDE_DIRS_LIBXML2 "/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/include"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/include/libxml2")
set(CONAN_LIB_DIRS_LIBXML2 "/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib")
set(CONAN_BIN_DIRS_LIBXML2 "/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/bin")
set(CONAN_RES_DIRS_LIBXML2 )
set(CONAN_SRC_DIRS_LIBXML2 )
set(CONAN_BUILD_DIRS_LIBXML2 "/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_LIBXML2 )
set(CONAN_LIBS_LIBXML2 xml2)
set(CONAN_PKG_LIBS_LIBXML2 xml2)
set(CONAN_SYSTEM_LIBS_LIBXML2 m pthread)
set(CONAN_FRAMEWORKS_LIBXML2 )
set(CONAN_FRAMEWORKS_FOUND_LIBXML2 "")  # Will be filled later
set(CONAN_DEFINES_LIBXML2 "-DLIBXML_STATIC")
set(CONAN_BUILD_MODULES_PATHS_LIBXML2 "/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib/cmake/conan-official-libxml2-variables.cmake")
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXML2 "LIBXML_STATIC")

set(CONAN_C_FLAGS_LIBXML2 "")
set(CONAN_CXX_FLAGS_LIBXML2 "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXML2 "")
set(CONAN_EXE_LINKER_FLAGS_LIBXML2 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXML2_LIST "")
set(CONAN_CXX_FLAGS_LIBXML2_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXML2_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXML2_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXML2 "${CONAN_FRAMEWORKS_LIBXML2}" "_LIBXML2" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXML2 ${CONAN_PKG_LIBS_LIBXML2} ${CONAN_SYSTEM_LIBS_LIBXML2} ${CONAN_FRAMEWORKS_FOUND_LIBXML2})


#################
###  EXPAT
#################
set(CONAN_EXPAT_ROOT "/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f")
set(CONAN_INCLUDE_DIRS_EXPAT "/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/include")
set(CONAN_LIB_DIRS_EXPAT "/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/lib")
set(CONAN_BIN_DIRS_EXPAT )
set(CONAN_RES_DIRS_EXPAT )
set(CONAN_SRC_DIRS_EXPAT )
set(CONAN_BUILD_DIRS_EXPAT "/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/")
set(CONAN_FRAMEWORK_DIRS_EXPAT )
set(CONAN_LIBS_EXPAT expat)
set(CONAN_PKG_LIBS_EXPAT expat)
set(CONAN_SYSTEM_LIBS_EXPAT )
set(CONAN_FRAMEWORKS_EXPAT )
set(CONAN_FRAMEWORKS_FOUND_EXPAT "")  # Will be filled later
set(CONAN_DEFINES_EXPAT "-DXML_STATIC")
set(CONAN_BUILD_MODULES_PATHS_EXPAT )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_EXPAT "XML_STATIC")

set(CONAN_C_FLAGS_EXPAT "")
set(CONAN_CXX_FLAGS_EXPAT "")
set(CONAN_SHARED_LINKER_FLAGS_EXPAT "")
set(CONAN_EXE_LINKER_FLAGS_EXPAT "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_EXPAT_LIST "")
set(CONAN_CXX_FLAGS_EXPAT_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_EXPAT_LIST "")
set(CONAN_EXE_LINKER_FLAGS_EXPAT_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_EXPAT "${CONAN_FRAMEWORKS_EXPAT}" "_EXPAT" "")
# Append to aggregated values variable
set(CONAN_LIBS_EXPAT ${CONAN_PKG_LIBS_EXPAT} ${CONAN_SYSTEM_LIBS_EXPAT} ${CONAN_FRAMEWORKS_FOUND_EXPAT})


#################
###  ZLIB
#################
set(CONAN_ZLIB_ROOT "/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646")
set(CONAN_INCLUDE_DIRS_ZLIB "/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/include")
set(CONAN_LIB_DIRS_ZLIB "/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib")
set(CONAN_BIN_DIRS_ZLIB )
set(CONAN_RES_DIRS_ZLIB )
set(CONAN_SRC_DIRS_ZLIB )
set(CONAN_BUILD_DIRS_ZLIB "/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/")
set(CONAN_FRAMEWORK_DIRS_ZLIB )
set(CONAN_LIBS_ZLIB z)
set(CONAN_PKG_LIBS_ZLIB z)
set(CONAN_SYSTEM_LIBS_ZLIB )
set(CONAN_FRAMEWORKS_ZLIB )
set(CONAN_FRAMEWORKS_FOUND_ZLIB "")  # Will be filled later
set(CONAN_DEFINES_ZLIB )
set(CONAN_BUILD_MODULES_PATHS_ZLIB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ZLIB )

set(CONAN_C_FLAGS_ZLIB "")
set(CONAN_CXX_FLAGS_ZLIB "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ZLIB_LIST "")
set(CONAN_CXX_FLAGS_ZLIB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ZLIB "${CONAN_FRAMEWORKS_ZLIB}" "_ZLIB" "")
# Append to aggregated values variable
set(CONAN_LIBS_ZLIB ${CONAN_PKG_LIBS_ZLIB} ${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB})


#################
###  LIBICONV
#################
set(CONAN_LIBICONV_ROOT "/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646")
set(CONAN_INCLUDE_DIRS_LIBICONV "/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/include")
set(CONAN_LIB_DIRS_LIBICONV "/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib")
set(CONAN_BIN_DIRS_LIBICONV "/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/bin")
set(CONAN_RES_DIRS_LIBICONV )
set(CONAN_SRC_DIRS_LIBICONV )
set(CONAN_BUILD_DIRS_LIBICONV "/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/")
set(CONAN_FRAMEWORK_DIRS_LIBICONV )
set(CONAN_LIBS_LIBICONV iconv charset)
set(CONAN_PKG_LIBS_LIBICONV iconv charset)
set(CONAN_SYSTEM_LIBS_LIBICONV )
set(CONAN_FRAMEWORKS_LIBICONV )
set(CONAN_FRAMEWORKS_FOUND_LIBICONV "")  # Will be filled later
set(CONAN_DEFINES_LIBICONV )
set(CONAN_BUILD_MODULES_PATHS_LIBICONV )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBICONV )

set(CONAN_C_FLAGS_LIBICONV "")
set(CONAN_CXX_FLAGS_LIBICONV "")
set(CONAN_SHARED_LINKER_FLAGS_LIBICONV "")
set(CONAN_EXE_LINKER_FLAGS_LIBICONV "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBICONV_LIST "")
set(CONAN_CXX_FLAGS_LIBICONV_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBICONV_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBICONV_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBICONV "${CONAN_FRAMEWORKS_LIBICONV}" "_LIBICONV" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBICONV ${CONAN_PKG_LIBS_LIBICONV} ${CONAN_SYSTEM_LIBS_LIBICONV} ${CONAN_FRAMEWORKS_FOUND_LIBICONV})


### Definition of global aggregated variables ###

set(CONAN_PACKAGE_NAME None)
set(CONAN_PACKAGE_VERSION None)

set(CONAN_SETTINGS_ARCH "x86_64")
set(CONAN_SETTINGS_ARCH_BUILD "x86_64")
set(CONAN_SETTINGS_BUILD_TYPE "Release")
set(CONAN_SETTINGS_COMPILER "gcc")
set(CONAN_SETTINGS_COMPILER_LIBCXX "libstdc++11")
set(CONAN_SETTINGS_COMPILER_VERSION "11")
set(CONAN_SETTINGS_OS "Linux")
set(CONAN_SETTINGS_OS_BUILD "Linux")

set(CONAN_DEPENDENCIES glfw spdlog imgui glm vulkan-memory-allocator vulkan-loader tinyobjloader stb spirv-cross opengl xorg fmt vulkan-headers wayland libffi libxml2 expat zlib libiconv)
# Storing original command line args (CMake helper) flags
set(CONAN_CMD_CXX_FLAGS ${CONAN_CXX_FLAGS})

set(CONAN_CMD_SHARED_LINKER_FLAGS ${CONAN_SHARED_LINKER_FLAGS})
set(CONAN_CMD_C_FLAGS ${CONAN_C_FLAGS})
# Defining accumulated conan variables for all deps

set(CONAN_INCLUDE_DIRS "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/include"
			"/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/include"
			"/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/include"
			"/home/henry/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/henry/.conan/data/vulkan-memory-allocator/2.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/include"
			"/home/henry/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/include"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/include/spirv_cross"
			"/usr/include/freetype2"
			"/usr/include/libpng16"
			"/usr/include/harfbuzz"
			"/usr/include/glib-2.0"
			"/usr/lib/glib-2.0/include"
			"/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/include"
			"/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/res/vulkan/registry"
			"/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/include"
			"/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/include"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/include"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/include/libxml2"
			"/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/include"
			"/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/include"
			"/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/include" ${CONAN_INCLUDE_DIRS})
set(CONAN_LIB_DIRS "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib"
			"/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/lib"
			"/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib"
			"/home/henry/.conan/data/vulkan-loader/1.2.172/_/_/package/4e7002e5f4df25945a2013e2f82418a3ba8ba05c/lib"
			"/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/lib"
			"/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib"
			"/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/lib"
			"/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib"
			"/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/lib"
			"/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib"
			"/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/lib" ${CONAN_LIB_DIRS})
set(CONAN_BIN_DIRS "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/bin"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/bin"
			"/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/bin"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/bin"
			"/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/bin" ${CONAN_BIN_DIRS})
set(CONAN_RES_DIRS "/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/res"
			"/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/res"
			"/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/res" ${CONAN_RES_DIRS})
set(CONAN_FRAMEWORK_DIRS  ${CONAN_FRAMEWORK_DIRS})
set(CONAN_LIBS glfw3 spdlog imgui vulkan tinyobjloader spirv-cross-c spirv-cross-hlsl spirv-cross-msl spirv-cross-cpp spirv-cross-glsl spirv-cross-reflect spirv-cross-util spirv-cross-core fmt wayland-server wayland-cursor wayland-egl wayland-client ffi xml2 expat z iconv charset ${CONAN_LIBS})
set(CONAN_PKG_LIBS glfw3 spdlog imgui vulkan tinyobjloader spirv-cross-c spirv-cross-hlsl spirv-cross-msl spirv-cross-cpp spirv-cross-glsl spirv-cross-reflect spirv-cross-util spirv-cross-core fmt wayland-server wayland-cursor wayland-egl wayland-client ffi xml2 expat z iconv charset ${CONAN_PKG_LIBS})
set(CONAN_SYSTEM_LIBS rt dl stdc++ GL X11 X11-xcb xcb fontenc ICE SM Xau Xaw7 Xt Xcomposite Xcursor Xdamage Xfixes Xdmcp Xext Xft Xi Xinerama xkbfile Xmu Xmuu Xpm Xrandr Xrender XRes Xss Xtst Xv XvMC Xxf86vm xcb-xkb xcb-icccm xcb-image xcb-shm xcb-keysyms xcb-randr xcb-render xcb-render-util xcb-shape xcb-sync xcb-xfixes xcb-xinerama xcb-util xcb-dri3 m pthread ${CONAN_SYSTEM_LIBS})
set(CONAN_FRAMEWORKS  ${CONAN_FRAMEWORKS})
set(CONAN_FRAMEWORKS_FOUND "")  # Will be filled later
set(CONAN_DEFINES "-DXML_STATIC"
			"-DLIBXML_STATIC"
			"-DFFI_BUILDING"
			"-D_DEFAULT_SOURCE"
			"-D_BSD_SOURCE"
			"-DHAS_FCHOWN"
			"-DHAS_STICKY_DIR_BIT"
			"-DSPIRV_CROSS_NAMESPACE_OVERRIDE=spirv_cross"
			"-DSTB_TEXTEDIT_KEYTYPE=unsigned"
			"-DSPDLOG_COMPILED_LIB"
			"-DSPDLOG_FMT_EXTERNAL" ${CONAN_DEFINES})
set(CONAN_BUILD_MODULES_PATHS "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib/cmake/conan-official-glfw-targets.cmake"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib/cmake/conan-official-libxml2-variables.cmake" ${CONAN_BUILD_MODULES_PATHS})
set(CONAN_CMAKE_MODULE_PATH "/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/"
			"/home/henry/.conan/data/glfw/3.3.4/_/_/package/3e7c626a326fdadc4c93f195efa1603f300bf722/lib/cmake"
			"/home/henry/.conan/data/spdlog/1.8.5/_/_/package/9451767843c5bfb2f2cab883e38fce1040a9cf5a/"
			"/home/henry/.conan/data/imgui/1.83/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/"
			"/home/henry/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/henry/.conan/data/vulkan-memory-allocator/2.3.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/henry/.conan/data/vulkan-loader/1.2.172/_/_/package/4e7002e5f4df25945a2013e2f82418a3ba8ba05c/"
			"/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/"
			"/home/henry/.conan/data/tinyobjloader/1.0.6/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/lib/cmake"
			"/home/henry/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/"
			"/home/henry/.conan/data/spirv-cross/20210115/_/_/package/8ec29ba679bbc8a24b0ef024c5fec2c20f043b83/lib/cmake"
			"/home/henry/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/henry/.conan/data/xorg/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/henry/.conan/data/fmt/7.1.3/_/_/package/6557f18ca99c0b6a233f43db00e30efaa525e27e/"
			"/home/henry/.conan/data/vulkan-headers/1.2.172/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/henry/.conan/data/wayland/1.18.0/_/_/package/75fce0356cb5cb051db7304f58922551d4ffb052/"
			"/home/henry/.conan/data/libffi/3.3/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/"
			"/home/henry/.conan/data/libxml2/2.9.10/_/_/package/c61ca912b16446c0f482bc52de12394fa7e40f1d/lib/cmake"
			"/home/henry/.conan/data/expat/2.2.10/_/_/package/2bf99ee01cda593d5986afc64acf262ad576354f/"
			"/home/henry/.conan/data/zlib/1.2.11/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/"
			"/home/henry/.conan/data/libiconv/1.16/_/_/package/dfbe50feef7f3c6223a476cd5aeadb687084a646/" ${CONAN_CMAKE_MODULE_PATH})

set(CONAN_CXX_FLAGS " ${CONAN_CXX_FLAGS}")
set(CONAN_SHARED_LINKER_FLAGS " ${CONAN_SHARED_LINKER_FLAGS}")
set(CONAN_EXE_LINKER_FLAGS " ${CONAN_EXE_LINKER_FLAGS}")
set(CONAN_C_FLAGS " ${CONAN_C_FLAGS}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND "${CONAN_FRAMEWORKS}" "" "")
# Append to aggregated values variable: Use CONAN_LIBS instead of CONAN_PKG_LIBS to include user appended vars
set(CONAN_LIBS ${CONAN_LIBS} ${CONAN_SYSTEM_LIBS} ${CONAN_FRAMEWORKS_FOUND})


###  Definition of macros and functions ###

macro(conan_define_targets)
    if(${CMAKE_VERSION} VERSION_LESS "3.1.2")
        message(FATAL_ERROR "TARGETS not supported by your CMake version!")
    endif()  # CMAKE > 3.x
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CONAN_CMD_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CONAN_CMD_C_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${CONAN_CMD_SHARED_LINKER_FLAGS}")


    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES "${CONAN_SYSTEM_LIBS_GLFW} ${CONAN_FRAMEWORKS_FOUND_GLFW} CONAN_PKG::opengl CONAN_PKG::xorg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW}" "${CONAN_LIB_DIRS_GLFW}"
                                  CONAN_PACKAGE_TARGETS_GLFW "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES}"
                                  "" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_GLFW_DEBUG} ${CONAN_FRAMEWORKS_FOUND_GLFW_DEBUG} CONAN_PKG::opengl CONAN_PKG::xorg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_DEBUG}" "${CONAN_LIB_DIRS_GLFW_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_GLFW_DEBUG "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG}"
                                  "debug" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_GLFW_RELEASE} ${CONAN_FRAMEWORKS_FOUND_GLFW_RELEASE} CONAN_PKG::opengl CONAN_PKG::xorg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_RELEASE}" "${CONAN_LIB_DIRS_GLFW_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_GLFW_RELEASE "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE}"
                                  "release" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_GLFW_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_GLFW_RELWITHDEBINFO} CONAN_PKG::opengl CONAN_PKG::xorg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_GLFW_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_GLFW_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_GLFW_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_GLFW_MINSIZEREL} CONAN_PKG::opengl CONAN_PKG::xorg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_MINSIZEREL}" "${CONAN_LIB_DIRS_GLFW_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_GLFW_MINSIZEREL "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" glfw)

    add_library(CONAN_PKG::glfw INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_GLFW} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_GLFW_RELEASE} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_GLFW_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_GLFW_MINSIZEREL} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_GLFW_DEBUG} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_GLFW}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_GLFW_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_GLFW_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_GLFW_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_GLFW_DEBUG}>)
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_GLFW}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_GLFW_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_GLFW_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_GLFW_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_GLFW_DEBUG}>)
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_GLFW_LIST} ${CONAN_CXX_FLAGS_GLFW_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_GLFW_RELEASE_LIST} ${CONAN_CXX_FLAGS_GLFW_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_GLFW_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_GLFW_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_GLFW_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_GLFW_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_GLFW_DEBUG_LIST}  ${CONAN_CXX_FLAGS_GLFW_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_SPDLOG} ${CONAN_FRAMEWORKS_FOUND_SPDLOG} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG}" "${CONAN_LIB_DIRS_SPDLOG}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES}"
                                  "" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_SPDLOG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_DEBUG} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_DEBUG}" "${CONAN_LIB_DIRS_SPDLOG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_DEBUG "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG}"
                                  "debug" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_SPDLOG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_RELEASE} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_RELEASE}" "${CONAN_LIB_DIRS_SPDLOG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_RELEASE "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE}"
                                  "release" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_SPDLOG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_RELWITHDEBINFO} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_SPDLOG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_SPDLOG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_MINSIZEREL} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_MINSIZEREL}" "${CONAN_LIB_DIRS_SPDLOG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_MINSIZEREL "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" spdlog)

    add_library(CONAN_PKG::spdlog INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_SPDLOG} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_SPDLOG_RELEASE} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_SPDLOG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_SPDLOG_MINSIZEREL} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_SPDLOG_DEBUG} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_SPDLOG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_SPDLOG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_SPDLOG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_SPDLOG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_SPDLOG_DEBUG}>)
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_SPDLOG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_DEBUG}>)
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_SPDLOG_LIST} ${CONAN_CXX_FLAGS_SPDLOG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_SPDLOG_RELEASE_LIST} ${CONAN_CXX_FLAGS_SPDLOG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_SPDLOG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_SPDLOG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_SPDLOG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_SPDLOG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_SPDLOG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES "${CONAN_SYSTEM_LIBS_IMGUI} ${CONAN_FRAMEWORKS_FOUND_IMGUI} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI}" "${CONAN_LIB_DIRS_IMGUI}"
                                  CONAN_PACKAGE_TARGETS_IMGUI "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES}"
                                  "" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_IMGUI_DEBUG} ${CONAN_FRAMEWORKS_FOUND_IMGUI_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_DEBUG}" "${CONAN_LIB_DIRS_IMGUI_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_DEBUG "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG}"
                                  "debug" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_IMGUI_RELEASE} ${CONAN_FRAMEWORKS_FOUND_IMGUI_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_RELEASE}" "${CONAN_LIB_DIRS_IMGUI_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_RELEASE "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE}"
                                  "release" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_IMGUI_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_IMGUI_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_IMGUI_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_IMGUI_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_IMGUI_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_MINSIZEREL}" "${CONAN_LIB_DIRS_IMGUI_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_MINSIZEREL "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" imgui)

    add_library(CONAN_PKG::imgui INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_IMGUI} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_IMGUI_RELEASE} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_IMGUI_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_IMGUI_MINSIZEREL} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_IMGUI_DEBUG} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_IMGUI}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_IMGUI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_IMGUI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_IMGUI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_IMGUI_DEBUG}>)
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_IMGUI}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_IMGUI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_IMGUI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_IMGUI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_IMGUI_DEBUG}>)
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_IMGUI_LIST} ${CONAN_CXX_FLAGS_IMGUI_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_IMGUI_RELEASE_LIST} ${CONAN_CXX_FLAGS_IMGUI_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_IMGUI_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_IMGUI_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_IMGUI_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_IMGUI_DEBUG_LIST}  ${CONAN_CXX_FLAGS_IMGUI_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES "${CONAN_SYSTEM_LIBS_GLM} ${CONAN_FRAMEWORKS_FOUND_GLM} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM}" "${CONAN_LIB_DIRS_GLM}"
                                  CONAN_PACKAGE_TARGETS_GLM "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}"
                                  "" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_GLM_DEBUG} ${CONAN_FRAMEWORKS_FOUND_GLM_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_DEBUG}" "${CONAN_LIB_DIRS_GLM_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_GLM_DEBUG "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}"
                                  "debug" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_GLM_RELEASE} ${CONAN_FRAMEWORKS_FOUND_GLM_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_RELEASE}" "${CONAN_LIB_DIRS_GLM_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_GLM_RELEASE "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}"
                                  "release" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_GLM_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_GLM_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_GLM_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_GLM_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_GLM_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_GLM_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_MINSIZEREL}" "${CONAN_LIB_DIRS_GLM_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_GLM_MINSIZEREL "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" glm)

    add_library(CONAN_PKG::glm INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_GLM} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_GLM_RELEASE} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_GLM_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_GLM_MINSIZEREL} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_GLM_DEBUG} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_GLM}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_GLM_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_GLM_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_GLM_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_GLM_DEBUG}>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_GLM}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_GLM_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_GLM_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_GLM_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_GLM_DEBUG}>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_GLM_LIST} ${CONAN_CXX_FLAGS_GLM_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_GLM_RELEASE_LIST} ${CONAN_CXX_FLAGS_GLM_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_GLM_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_GLM_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_GLM_DEBUG_LIST}  ${CONAN_CXX_FLAGS_GLM_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES "${CONAN_SYSTEM_LIBS_VULKAN-MEMORY-ALLOCATOR} ${CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR} CONAN_PKG::vulkan-headers")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR}" "${CONAN_LIB_DIRS_VULKAN-MEMORY-ALLOCATOR}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES}"
                                  "" vulkan-memory-allocator)
    set(_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_VULKAN-MEMORY-ALLOCATOR_DEBUG} ${CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR_DEBUG} CONAN_PKG::vulkan-headers")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEBUG}" "${CONAN_LIB_DIRS_VULKAN-MEMORY-ALLOCATOR_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_DEBUG "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_DEBUG}"
                                  "debug" vulkan-memory-allocator)
    set(_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_VULKAN-MEMORY-ALLOCATOR_RELEASE} ${CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR_RELEASE} CONAN_PKG::vulkan-headers")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_RELEASE}" "${CONAN_LIB_DIRS_VULKAN-MEMORY-ALLOCATOR_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_RELEASE "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELEASE}"
                                  "release" vulkan-memory-allocator)
    set(_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO} CONAN_PKG::vulkan-headers")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" vulkan-memory-allocator)
    set(_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL} CONAN_PKG::vulkan-headers")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL}" "${CONAN_LIB_DIRS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL "${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" vulkan-memory-allocator)

    add_library(CONAN_PKG::vulkan-memory-allocator INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::vulkan-memory-allocator PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR} ${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_RELEASE} ${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL} ${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_VULKAN-MEMORY-ALLOCATOR_DEBUG} ${_CONAN_PKG_LIBS_VULKAN-MEMORY-ALLOCATOR_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-MEMORY-ALLOCATOR_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::vulkan-memory-allocator PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_VULKAN-MEMORY-ALLOCATOR}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_VULKAN-MEMORY-ALLOCATOR_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_VULKAN-MEMORY-ALLOCATOR_DEBUG}>)
    set_property(TARGET CONAN_PKG::vulkan-memory-allocator PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_VULKAN-MEMORY-ALLOCATOR}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_VULKAN-MEMORY-ALLOCATOR_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_VULKAN-MEMORY-ALLOCATOR_DEBUG}>)
    set_property(TARGET CONAN_PKG::vulkan-memory-allocator PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST} ${CONAN_CXX_FLAGS_VULKAN-MEMORY-ALLOCATOR_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELEASE_LIST} ${CONAN_CXX_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_VULKAN-MEMORY-ALLOCATOR_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_VULKAN-MEMORY-ALLOCATOR_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_VULKAN-MEMORY-ALLOCATOR_DEBUG_LIST}  ${CONAN_CXX_FLAGS_VULKAN-MEMORY-ALLOCATOR_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES "${CONAN_SYSTEM_LIBS_VULKAN-LOADER} ${CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER} CONAN_PKG::vulkan-headers CONAN_PKG::xorg CONAN_PKG::wayland")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-LOADER}" "${CONAN_LIB_DIRS_VULKAN-LOADER}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-LOADER "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES}"
                                  "" vulkan-loader)
    set(_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_VULKAN-LOADER_DEBUG} ${CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER_DEBUG} CONAN_PKG::vulkan-headers CONAN_PKG::xorg CONAN_PKG::wayland")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-LOADER_DEBUG}" "${CONAN_LIB_DIRS_VULKAN-LOADER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-LOADER_DEBUG "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_DEBUG}"
                                  "debug" vulkan-loader)
    set(_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_VULKAN-LOADER_RELEASE} ${CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER_RELEASE} CONAN_PKG::vulkan-headers CONAN_PKG::xorg CONAN_PKG::wayland")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-LOADER_RELEASE}" "${CONAN_LIB_DIRS_VULKAN-LOADER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-LOADER_RELEASE "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELEASE}"
                                  "release" vulkan-loader)
    set(_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_VULKAN-LOADER_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER_RELWITHDEBINFO} CONAN_PKG::vulkan-headers CONAN_PKG::xorg CONAN_PKG::wayland")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-LOADER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_VULKAN-LOADER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-LOADER_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" vulkan-loader)
    set(_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_VULKAN-LOADER_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_VULKAN-LOADER_MINSIZEREL} CONAN_PKG::vulkan-headers CONAN_PKG::xorg CONAN_PKG::wayland")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-LOADER_MINSIZEREL}" "${CONAN_LIB_DIRS_VULKAN-LOADER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-LOADER_MINSIZEREL "${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" vulkan-loader)

    add_library(CONAN_PKG::vulkan-loader INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::vulkan-loader PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_VULKAN-LOADER} ${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-LOADER_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_VULKAN-LOADER_RELEASE} ${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-LOADER_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_VULKAN-LOADER_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-LOADER_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_VULKAN-LOADER_MINSIZEREL} ${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-LOADER_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_VULKAN-LOADER_DEBUG} ${_CONAN_PKG_LIBS_VULKAN-LOADER_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-LOADER_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-LOADER_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::vulkan-loader PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_VULKAN-LOADER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_VULKAN-LOADER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_VULKAN-LOADER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_VULKAN-LOADER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_VULKAN-LOADER_DEBUG}>)
    set_property(TARGET CONAN_PKG::vulkan-loader PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_VULKAN-LOADER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_VULKAN-LOADER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_VULKAN-LOADER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_VULKAN-LOADER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_VULKAN-LOADER_DEBUG}>)
    set_property(TARGET CONAN_PKG::vulkan-loader PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_VULKAN-LOADER_LIST} ${CONAN_CXX_FLAGS_VULKAN-LOADER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_VULKAN-LOADER_RELEASE_LIST} ${CONAN_CXX_FLAGS_VULKAN-LOADER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_VULKAN-LOADER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_VULKAN-LOADER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_VULKAN-LOADER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_VULKAN-LOADER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_VULKAN-LOADER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_VULKAN-LOADER_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES "${CONAN_SYSTEM_LIBS_TINYOBJLOADER} ${CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TINYOBJLOADER}" "${CONAN_LIB_DIRS_TINYOBJLOADER}"
                                  CONAN_PACKAGE_TARGETS_TINYOBJLOADER "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES}"
                                  "" tinyobjloader)
    set(_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_TINYOBJLOADER_DEBUG} ${CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TINYOBJLOADER_DEBUG}" "${CONAN_LIB_DIRS_TINYOBJLOADER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_TINYOBJLOADER_DEBUG "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_DEBUG}"
                                  "debug" tinyobjloader)
    set(_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_TINYOBJLOADER_RELEASE} ${CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TINYOBJLOADER_RELEASE}" "${CONAN_LIB_DIRS_TINYOBJLOADER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_TINYOBJLOADER_RELEASE "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELEASE}"
                                  "release" tinyobjloader)
    set(_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_TINYOBJLOADER_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TINYOBJLOADER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_TINYOBJLOADER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_TINYOBJLOADER_RELWITHDEBINFO "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" tinyobjloader)
    set(_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_TINYOBJLOADER_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_TINYOBJLOADER_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TINYOBJLOADER_MINSIZEREL}" "${CONAN_LIB_DIRS_TINYOBJLOADER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_TINYOBJLOADER_MINSIZEREL "${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" tinyobjloader)

    add_library(CONAN_PKG::tinyobjloader INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::tinyobjloader PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_TINYOBJLOADER} ${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TINYOBJLOADER_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_TINYOBJLOADER_RELEASE} ${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TINYOBJLOADER_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_TINYOBJLOADER_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TINYOBJLOADER_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_TINYOBJLOADER_MINSIZEREL} ${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TINYOBJLOADER_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_TINYOBJLOADER_DEBUG} ${_CONAN_PKG_LIBS_TINYOBJLOADER_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TINYOBJLOADER_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TINYOBJLOADER_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::tinyobjloader PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_TINYOBJLOADER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_TINYOBJLOADER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_TINYOBJLOADER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_TINYOBJLOADER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_TINYOBJLOADER_DEBUG}>)
    set_property(TARGET CONAN_PKG::tinyobjloader PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_TINYOBJLOADER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_TINYOBJLOADER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_TINYOBJLOADER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_TINYOBJLOADER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_TINYOBJLOADER_DEBUG}>)
    set_property(TARGET CONAN_PKG::tinyobjloader PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_TINYOBJLOADER_LIST} ${CONAN_CXX_FLAGS_TINYOBJLOADER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_TINYOBJLOADER_RELEASE_LIST} ${CONAN_CXX_FLAGS_TINYOBJLOADER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_TINYOBJLOADER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_TINYOBJLOADER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_TINYOBJLOADER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_TINYOBJLOADER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_TINYOBJLOADER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_TINYOBJLOADER_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_STB} ${CONAN_FRAMEWORKS_FOUND_STB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES "${_CONAN_PKG_LIBS_STB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB}" "${CONAN_LIB_DIRS_STB}"
                                  CONAN_PACKAGE_TARGETS_STB "${_CONAN_PKG_LIBS_STB_DEPENDENCIES}"
                                  "" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_STB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_STB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_DEBUG}" "${CONAN_LIB_DIRS_STB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_STB_DEBUG "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}"
                                  "debug" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_STB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_STB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_RELEASE}" "${CONAN_LIB_DIRS_STB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_STB_RELEASE "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}"
                                  "release" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_STB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_STB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_STB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_STB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_STB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_STB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_MINSIZEREL}" "${CONAN_LIB_DIRS_STB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_STB_MINSIZEREL "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" stb)

    add_library(CONAN_PKG::stb INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_STB} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_STB_RELEASE} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_STB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_STB_MINSIZEREL} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_STB_DEBUG} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_STB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_STB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_STB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_STB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_STB_DEBUG}>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_STB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_STB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_STB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_STB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_STB_DEBUG}>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_STB_LIST} ${CONAN_CXX_FLAGS_STB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_STB_RELEASE_LIST} ${CONAN_CXX_FLAGS_STB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_STB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_STB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_STB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_STB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_STB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_SPIRV-CROSS} ${CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPIRV-CROSS}" "${CONAN_LIB_DIRS_SPIRV-CROSS}"
                                  CONAN_PACKAGE_TARGETS_SPIRV-CROSS "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES}"
                                  "" spirv-cross)
    set(_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_SPIRV-CROSS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPIRV-CROSS_DEBUG}" "${CONAN_LIB_DIRS_SPIRV-CROSS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_SPIRV-CROSS_DEBUG "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_DEBUG}"
                                  "debug" spirv-cross)
    set(_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_SPIRV-CROSS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPIRV-CROSS_RELEASE}" "${CONAN_LIB_DIRS_SPIRV-CROSS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_SPIRV-CROSS_RELEASE "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELEASE}"
                                  "release" spirv-cross)
    set(_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_SPIRV-CROSS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPIRV-CROSS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_SPIRV-CROSS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_SPIRV-CROSS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" spirv-cross)
    set(_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_SPIRV-CROSS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_SPIRV-CROSS_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPIRV-CROSS_MINSIZEREL}" "${CONAN_LIB_DIRS_SPIRV-CROSS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_SPIRV-CROSS_MINSIZEREL "${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" spirv-cross)

    add_library(CONAN_PKG::spirv-cross INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::spirv-cross PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_SPIRV-CROSS} ${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPIRV-CROSS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_SPIRV-CROSS_RELEASE} ${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPIRV-CROSS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_SPIRV-CROSS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPIRV-CROSS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_SPIRV-CROSS_MINSIZEREL} ${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPIRV-CROSS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_SPIRV-CROSS_DEBUG} ${_CONAN_PKG_LIBS_SPIRV-CROSS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPIRV-CROSS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPIRV-CROSS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::spirv-cross PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_SPIRV-CROSS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_SPIRV-CROSS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_SPIRV-CROSS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_SPIRV-CROSS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_SPIRV-CROSS_DEBUG}>)
    set_property(TARGET CONAN_PKG::spirv-cross PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_SPIRV-CROSS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_SPIRV-CROSS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_SPIRV-CROSS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_SPIRV-CROSS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_SPIRV-CROSS_DEBUG}>)
    set_property(TARGET CONAN_PKG::spirv-cross PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_SPIRV-CROSS_LIST} ${CONAN_CXX_FLAGS_SPIRV-CROSS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_SPIRV-CROSS_RELEASE_LIST} ${CONAN_CXX_FLAGS_SPIRV-CROSS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_SPIRV-CROSS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_SPIRV-CROSS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_SPIRV-CROSS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_SPIRV-CROSS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_SPIRV-CROSS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_SPIRV-CROSS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL}" "${CONAN_LIB_DIRS_OPENGL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}"
                                  "" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENGL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENGL_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_DEBUG}" "${CONAN_LIB_DIRS_OPENGL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}"
                                  "debug" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENGL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELEASE}" "${CONAN_LIB_DIRS_OPENGL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}"
                                  "release" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENGL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENGL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENGL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENGL_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENGL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" opengl)

    add_library(CONAN_PKG::opengl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENGL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENGL_RELEASE} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENGL_DEBUG} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENGL_LIST} ${CONAN_CXX_FLAGS_OPENGL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENGL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENGL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENGL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENGL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENGL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_XORG} ${CONAN_FRAMEWORKS_FOUND_XORG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG}" "${CONAN_LIB_DIRS_XORG}"
                                  CONAN_PACKAGE_TARGETS_XORG "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES}"
                                  "" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_XORG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_XORG_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_DEBUG}" "${CONAN_LIB_DIRS_XORG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_XORG_DEBUG "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG}"
                                  "debug" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_XORG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_XORG_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_RELEASE}" "${CONAN_LIB_DIRS_XORG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_XORG_RELEASE "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE}"
                                  "release" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_XORG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_XORG_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_XORG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_XORG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_XORG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_XORG_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_MINSIZEREL}" "${CONAN_LIB_DIRS_XORG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_XORG_MINSIZEREL "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" xorg)

    add_library(CONAN_PKG::xorg INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_XORG} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_XORG_RELEASE} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_XORG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_XORG_MINSIZEREL} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_XORG_DEBUG} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_XORG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_XORG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_XORG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_XORG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_XORG_DEBUG}>)
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_XORG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_XORG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_XORG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_XORG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_XORG_DEBUG}>)
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_XORG_LIST} ${CONAN_CXX_FLAGS_XORG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_XORG_RELEASE_LIST} ${CONAN_CXX_FLAGS_XORG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_XORG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_XORG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_XORG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_XORG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_XORG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_XORG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FMT} ${CONAN_FRAMEWORKS_FOUND_FMT} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT}" "${CONAN_LIB_DIRS_FMT}"
                                  CONAN_PACKAGE_TARGETS_FMT "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}"
                                  "" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FMT_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FMT_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_DEBUG}" "${CONAN_LIB_DIRS_FMT_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FMT_DEBUG "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}"
                                  "debug" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FMT_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FMT_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_RELEASE}" "${CONAN_LIB_DIRS_FMT_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FMT_RELEASE "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}"
                                  "release" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FMT_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FMT_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FMT_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FMT_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FMT_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FMT_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_MINSIZEREL}" "${CONAN_LIB_DIRS_FMT_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FMT_MINSIZEREL "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" fmt)

    add_library(CONAN_PKG::fmt INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FMT} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FMT_RELEASE} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FMT_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FMT_MINSIZEREL} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FMT_DEBUG} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FMT}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FMT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FMT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FMT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FMT_DEBUG}>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FMT}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FMT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FMT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FMT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FMT_DEBUG}>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FMT_LIST} ${CONAN_CXX_FLAGS_FMT_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FMT_RELEASE_LIST} ${CONAN_CXX_FLAGS_FMT_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FMT_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FMT_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FMT_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FMT_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_VULKAN-HEADERS} ${CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-HEADERS}" "${CONAN_LIB_DIRS_VULKAN-HEADERS}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-HEADERS "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES}"
                                  "" vulkan-headers)
    set(_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_VULKAN-HEADERS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-HEADERS_DEBUG}" "${CONAN_LIB_DIRS_VULKAN-HEADERS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_DEBUG "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_DEBUG}"
                                  "debug" vulkan-headers)
    set(_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_VULKAN-HEADERS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-HEADERS_RELEASE}" "${CONAN_LIB_DIRS_VULKAN-HEADERS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_RELEASE "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELEASE}"
                                  "release" vulkan-headers)
    set(_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_VULKAN-HEADERS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-HEADERS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_VULKAN-HEADERS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" vulkan-headers)
    set(_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_VULKAN-HEADERS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_VULKAN-HEADERS_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VULKAN-HEADERS_MINSIZEREL}" "${CONAN_LIB_DIRS_VULKAN-HEADERS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_MINSIZEREL "${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" vulkan-headers)

    add_library(CONAN_PKG::vulkan-headers INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::vulkan-headers PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_VULKAN-HEADERS} ${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-HEADERS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_RELEASE} ${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-HEADERS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-HEADERS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_MINSIZEREL} ${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-HEADERS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_VULKAN-HEADERS_DEBUG} ${_CONAN_PKG_LIBS_VULKAN-HEADERS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VULKAN-HEADERS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VULKAN-HEADERS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::vulkan-headers PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_VULKAN-HEADERS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_VULKAN-HEADERS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_VULKAN-HEADERS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_VULKAN-HEADERS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_VULKAN-HEADERS_DEBUG}>)
    set_property(TARGET CONAN_PKG::vulkan-headers PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_VULKAN-HEADERS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_VULKAN-HEADERS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_VULKAN-HEADERS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_VULKAN-HEADERS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_VULKAN-HEADERS_DEBUG}>)
    set_property(TARGET CONAN_PKG::vulkan-headers PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_VULKAN-HEADERS_LIST} ${CONAN_CXX_FLAGS_VULKAN-HEADERS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_VULKAN-HEADERS_RELEASE_LIST} ${CONAN_CXX_FLAGS_VULKAN-HEADERS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_VULKAN-HEADERS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_VULKAN-HEADERS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_VULKAN-HEADERS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_VULKAN-HEADERS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_VULKAN-HEADERS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_VULKAN-HEADERS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES "${CONAN_SYSTEM_LIBS_WAYLAND} ${CONAN_FRAMEWORKS_FOUND_WAYLAND} CONAN_PKG::libffi CONAN_PKG::libxml2 CONAN_PKG::expat")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_WAYLAND}" "${CONAN_LIB_DIRS_WAYLAND}"
                                  CONAN_PACKAGE_TARGETS_WAYLAND "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES}"
                                  "" wayland)
    set(_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_WAYLAND_DEBUG} ${CONAN_FRAMEWORKS_FOUND_WAYLAND_DEBUG} CONAN_PKG::libffi CONAN_PKG::libxml2 CONAN_PKG::expat")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_WAYLAND_DEBUG}" "${CONAN_LIB_DIRS_WAYLAND_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_WAYLAND_DEBUG "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_DEBUG}"
                                  "debug" wayland)
    set(_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_WAYLAND_RELEASE} ${CONAN_FRAMEWORKS_FOUND_WAYLAND_RELEASE} CONAN_PKG::libffi CONAN_PKG::libxml2 CONAN_PKG::expat")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_WAYLAND_RELEASE}" "${CONAN_LIB_DIRS_WAYLAND_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_WAYLAND_RELEASE "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELEASE}"
                                  "release" wayland)
    set(_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_WAYLAND_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_WAYLAND_RELWITHDEBINFO} CONAN_PKG::libffi CONAN_PKG::libxml2 CONAN_PKG::expat")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_WAYLAND_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_WAYLAND_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_WAYLAND_RELWITHDEBINFO "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" wayland)
    set(_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_WAYLAND_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_WAYLAND_MINSIZEREL} CONAN_PKG::libffi CONAN_PKG::libxml2 CONAN_PKG::expat")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_WAYLAND_MINSIZEREL}" "${CONAN_LIB_DIRS_WAYLAND_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_WAYLAND_MINSIZEREL "${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" wayland)

    add_library(CONAN_PKG::wayland INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::wayland PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_WAYLAND} ${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_WAYLAND_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_WAYLAND_RELEASE} ${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_WAYLAND_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_WAYLAND_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_WAYLAND_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_WAYLAND_MINSIZEREL} ${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_WAYLAND_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_WAYLAND_DEBUG} ${_CONAN_PKG_LIBS_WAYLAND_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_WAYLAND_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_WAYLAND_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::wayland PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_WAYLAND}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_WAYLAND_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_WAYLAND_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_WAYLAND_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_WAYLAND_DEBUG}>)
    set_property(TARGET CONAN_PKG::wayland PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_WAYLAND}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_WAYLAND_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_WAYLAND_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_WAYLAND_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_WAYLAND_DEBUG}>)
    set_property(TARGET CONAN_PKG::wayland PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_WAYLAND_LIST} ${CONAN_CXX_FLAGS_WAYLAND_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_WAYLAND_RELEASE_LIST} ${CONAN_CXX_FLAGS_WAYLAND_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_WAYLAND_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_WAYLAND_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_WAYLAND_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_WAYLAND_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_WAYLAND_DEBUG_LIST}  ${CONAN_CXX_FLAGS_WAYLAND_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBFFI} ${CONAN_FRAMEWORKS_FOUND_LIBFFI} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBFFI}" "${CONAN_LIB_DIRS_LIBFFI}"
                                  CONAN_PACKAGE_TARGETS_LIBFFI "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES}"
                                  "" libffi)
    set(_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBFFI_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBFFI_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBFFI_DEBUG}" "${CONAN_LIB_DIRS_LIBFFI_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBFFI_DEBUG "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_DEBUG}"
                                  "debug" libffi)
    set(_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBFFI_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBFFI_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBFFI_RELEASE}" "${CONAN_LIB_DIRS_LIBFFI_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBFFI_RELEASE "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELEASE}"
                                  "release" libffi)
    set(_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBFFI_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBFFI_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBFFI_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBFFI_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBFFI_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libffi)
    set(_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBFFI_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBFFI_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBFFI_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBFFI_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBFFI_MINSIZEREL "${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libffi)

    add_library(CONAN_PKG::libffi INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libffi PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBFFI} ${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBFFI_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBFFI_RELEASE} ${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBFFI_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBFFI_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBFFI_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBFFI_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBFFI_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBFFI_DEBUG} ${_CONAN_PKG_LIBS_LIBFFI_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBFFI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBFFI_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libffi PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBFFI}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBFFI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBFFI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBFFI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBFFI_DEBUG}>)
    set_property(TARGET CONAN_PKG::libffi PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBFFI}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBFFI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBFFI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBFFI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBFFI_DEBUG}>)
    set_property(TARGET CONAN_PKG::libffi PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBFFI_LIST} ${CONAN_CXX_FLAGS_LIBFFI_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBFFI_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBFFI_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBFFI_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBFFI_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBFFI_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBFFI_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBFFI_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBFFI_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXML2} ${CONAN_FRAMEWORKS_FOUND_LIBXML2} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2}" "${CONAN_LIB_DIRS_LIBXML2}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2 "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES}"
                                  "" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXML2_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_DEBUG} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_DEBUG}" "${CONAN_LIB_DIRS_LIBXML2_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_DEBUG "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG}"
                                  "debug" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXML2_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_RELEASE} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_RELEASE}" "${CONAN_LIB_DIRS_LIBXML2_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_RELEASE "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE}"
                                  "release" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXML2_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_RELWITHDEBINFO} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXML2_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxml2)
    set(_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXML2_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXML2_MINSIZEREL} CONAN_PKG::zlib CONAN_PKG::libiconv")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXML2_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXML2_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXML2_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxml2)

    add_library(CONAN_PKG::libxml2 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXML2} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXML2_RELEASE} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXML2_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXML2_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXML2_DEBUG} ${_CONAN_PKG_LIBS_LIBXML2_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXML2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXML2_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXML2}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXML2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXML2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXML2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXML2_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXML2}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXML2_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxml2 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXML2_LIST} ${CONAN_CXX_FLAGS_LIBXML2_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXML2_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXML2_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXML2_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXML2_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXML2_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXML2_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXML2_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXML2_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES "${CONAN_SYSTEM_LIBS_EXPAT} ${CONAN_FRAMEWORKS_FOUND_EXPAT} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_EXPAT_DEPENDENCIES "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_EXPAT}" "${CONAN_LIB_DIRS_EXPAT}"
                                  CONAN_PACKAGE_TARGETS_EXPAT "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES}"
                                  "" expat)
    set(_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_EXPAT_DEBUG} ${CONAN_FRAMEWORKS_FOUND_EXPAT_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_EXPAT_DEBUG}" "${CONAN_LIB_DIRS_EXPAT_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_EXPAT_DEBUG "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_DEBUG}"
                                  "debug" expat)
    set(_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_EXPAT_RELEASE} ${CONAN_FRAMEWORKS_FOUND_EXPAT_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_EXPAT_RELEASE}" "${CONAN_LIB_DIRS_EXPAT_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_EXPAT_RELEASE "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELEASE}"
                                  "release" expat)
    set(_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_EXPAT_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_EXPAT_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_EXPAT_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_EXPAT_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_EXPAT_RELWITHDEBINFO "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" expat)
    set(_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_EXPAT_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_EXPAT_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_EXPAT_MINSIZEREL}" "${CONAN_LIB_DIRS_EXPAT_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_EXPAT_MINSIZEREL "${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" expat)

    add_library(CONAN_PKG::expat INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::expat PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_EXPAT} ${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_EXPAT_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_EXPAT_RELEASE} ${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_EXPAT_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_EXPAT_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_EXPAT_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_EXPAT_MINSIZEREL} ${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_EXPAT_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_EXPAT_DEBUG} ${_CONAN_PKG_LIBS_EXPAT_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_EXPAT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_EXPAT_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::expat PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_EXPAT}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_EXPAT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_EXPAT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_EXPAT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_EXPAT_DEBUG}>)
    set_property(TARGET CONAN_PKG::expat PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_EXPAT}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_EXPAT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_EXPAT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_EXPAT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_EXPAT_DEBUG}>)
    set_property(TARGET CONAN_PKG::expat PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_EXPAT_LIST} ${CONAN_CXX_FLAGS_EXPAT_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_EXPAT_RELEASE_LIST} ${CONAN_CXX_FLAGS_EXPAT_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_EXPAT_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_EXPAT_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_EXPAT_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_EXPAT_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_EXPAT_DEBUG_LIST}  ${CONAN_CXX_FLAGS_EXPAT_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB}" "${CONAN_LIB_DIRS_ZLIB}"
                                  CONAN_PACKAGE_TARGETS_ZLIB "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}"
                                  "" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ZLIB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ZLIB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_DEBUG}" "${CONAN_LIB_DIRS_ZLIB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}"
                                  "debug" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ZLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELEASE}" "${CONAN_LIB_DIRS_ZLIB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}"
                                  "release" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ZLIB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ZLIB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ZLIB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ZLIB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_MINSIZEREL}" "${CONAN_LIB_DIRS_ZLIB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" zlib)

    add_library(CONAN_PKG::zlib INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ZLIB} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ZLIB_RELEASE} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ZLIB_DEBUG} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ZLIB_LIST} ${CONAN_CXX_FLAGS_ZLIB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ZLIB_RELEASE_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ZLIB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ZLIB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ZLIB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ZLIB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBICONV} ${CONAN_FRAMEWORKS_FOUND_LIBICONV} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV}" "${CONAN_LIB_DIRS_LIBICONV}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES}"
                                  "" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBICONV_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_DEBUG}" "${CONAN_LIB_DIRS_LIBICONV_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_DEBUG "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG}"
                                  "debug" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBICONV_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_RELEASE}" "${CONAN_LIB_DIRS_LIBICONV_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_RELEASE "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE}"
                                  "release" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBICONV_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBICONV_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libiconv)
    set(_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBICONV_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBICONV_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBICONV_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBICONV_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBICONV_MINSIZEREL "${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libiconv)

    add_library(CONAN_PKG::libiconv INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBICONV} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBICONV_RELEASE} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBICONV_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBICONV_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBICONV_DEBUG} ${_CONAN_PKG_LIBS_LIBICONV_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBICONV_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBICONV_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBICONV}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBICONV_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBICONV_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBICONV_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBICONV_DEBUG}>)
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBICONV}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBICONV_DEBUG}>)
    set_property(TARGET CONAN_PKG::libiconv PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBICONV_LIST} ${CONAN_CXX_FLAGS_LIBICONV_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBICONV_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBICONV_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBICONV_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBICONV_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBICONV_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBICONV_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBICONV_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBICONV_DEBUG_LIST}>)

    set(CONAN_TARGETS CONAN_PKG::glfw CONAN_PKG::spdlog CONAN_PKG::imgui CONAN_PKG::glm CONAN_PKG::vulkan-memory-allocator CONAN_PKG::vulkan-loader CONAN_PKG::tinyobjloader CONAN_PKG::stb CONAN_PKG::spirv-cross CONAN_PKG::opengl CONAN_PKG::xorg CONAN_PKG::fmt CONAN_PKG::vulkan-headers CONAN_PKG::wayland CONAN_PKG::libffi CONAN_PKG::libxml2 CONAN_PKG::expat CONAN_PKG::zlib CONAN_PKG::libiconv)

endmacro()


macro(conan_basic_setup)
    set(options TARGETS NO_OUTPUT_DIRS SKIP_RPATH KEEP_RPATHS SKIP_STD SKIP_FPIC)
    cmake_parse_arguments(ARGUMENTS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if(CONAN_EXPORTED)
        conan_message(STATUS "Conan: called by CMake conan helper")
    endif()

    if(CONAN_IN_LOCAL_CACHE)
        conan_message(STATUS "Conan: called inside local cache")
    endif()

    if(NOT ARGUMENTS_NO_OUTPUT_DIRS)
        conan_message(STATUS "Conan: Adjusting output directories")
        conan_output_dirs_setup()
    endif()

    if(NOT ARGUMENTS_TARGETS)
        conan_message(STATUS "Conan: Using cmake global configuration")
        conan_global_flags()
    else()
        conan_message(STATUS "Conan: Using cmake targets configuration")
        conan_define_targets()
    endif()

    if(ARGUMENTS_SKIP_RPATH)
        # Change by "DEPRECATION" or "SEND_ERROR" when we are ready
        conan_message(WARNING "Conan: SKIP_RPATH is deprecated, it has been renamed to KEEP_RPATHS")
    endif()

    if(NOT ARGUMENTS_SKIP_RPATH AND NOT ARGUMENTS_KEEP_RPATHS)
        # Parameter has renamed, but we keep the compatibility with old SKIP_RPATH
        conan_set_rpath()
    endif()

    if(NOT ARGUMENTS_SKIP_STD)
        conan_set_std()
    endif()

    if(NOT ARGUMENTS_SKIP_FPIC)
        conan_set_fpic()
    endif()

    conan_check_compiler()
    conan_set_libcxx()
    conan_set_vs_runtime()
    conan_set_find_paths()
    conan_include_build_modules()
    conan_set_find_library_paths()
endmacro()


macro(conan_set_find_paths)
    # CMAKE_MODULE_PATH does not have Debug/Release config, but there are variables
    # CONAN_CMAKE_MODULE_PATH_DEBUG to be used by the consumer
    # CMake can find findXXX.cmake files in the root of packages
    set(CMAKE_MODULE_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_MODULE_PATH})

    # Make find_package() to work
    set(CMAKE_PREFIX_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_PREFIX_PATH})

    # Set the find root path (cross build)
    set(CMAKE_FIND_ROOT_PATH ${CONAN_CMAKE_FIND_ROOT_PATH} ${CMAKE_FIND_ROOT_PATH})
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
        set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
        set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
        set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE})
    endif()
endmacro()


macro(conan_set_find_library_paths)
    # CMAKE_INCLUDE_PATH, CMAKE_LIBRARY_PATH does not have Debug/Release config, but there are variables
    # CONAN_INCLUDE_DIRS_DEBUG/RELEASE CONAN_LIB_DIRS_DEBUG/RELEASE to be used by the consumer
    # For find_library
    set(CMAKE_INCLUDE_PATH ${CONAN_INCLUDE_DIRS} ${CMAKE_INCLUDE_PATH})
    set(CMAKE_LIBRARY_PATH ${CONAN_LIB_DIRS} ${CMAKE_LIBRARY_PATH})
endmacro()


macro(conan_set_vs_runtime)
    if(CONAN_LINK_RUNTIME)
        conan_get_policy(CMP0091 policy_0091)
        if(policy_0091 STREQUAL "NEW")
            if(CONAN_LINK_RUNTIME MATCHES "MTd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
            elseif(CONAN_LINK_RUNTIME MATCHES "MDd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")
            elseif(CONAN_LINK_RUNTIME MATCHES "MT")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
            elseif(CONAN_LINK_RUNTIME MATCHES "MD")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
            endif()
        else()
            foreach(flag CMAKE_C_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELEASE
                         CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_RELWITHDEBINFO
                         CMAKE_C_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_MINSIZEREL)
                if(DEFINED ${flag})
                    string(REPLACE "/MD" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
            foreach(flag CMAKE_C_FLAGS_DEBUG CMAKE_CXX_FLAGS_DEBUG)
                if(DEFINED ${flag})
                    string(REPLACE "/MDd" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
        endif()
    endif()
endmacro()


macro(conan_flags_setup)
    # Macro maintained for backwards compatibility
    conan_set_find_library_paths()
    conan_global_flags()
    conan_set_rpath()
    conan_set_vs_runtime()
    conan_set_libcxx()
endmacro()


function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()


function(conan_get_policy policy_id policy)
    if(POLICY "${policy_id}")
        cmake_policy(GET "${policy_id}" _policy)
        set(${policy} "${_policy}" PARENT_SCOPE)
    else()
        set(${policy} "" PARENT_SCOPE)
    endif()
endfunction()


function(conan_find_libraries_abs_path libraries package_libdir libraries_abs_path)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${CONAN_FOUND_LIBRARY})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()
    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


function(conan_package_library_targets libraries package_libdir libraries_abs_path deps build_type package_name)
    unset(_CONAN_ACTUAL_TARGETS CACHE)
    unset(_CONAN_FOUND_SYSTEM_LIBS CACHE)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
            add_library(${_LIB_NAME} UNKNOWN IMPORTED)
            set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIB_NAME})
            set(_CONAN_ACTUAL_TARGETS ${_CONAN_ACTUAL_TARGETS} ${_LIB_NAME})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
            set(_CONAN_FOUND_SYSTEM_LIBS "${_CONAN_FOUND_SYSTEM_LIBS};${_LIBRARY_NAME}")
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()

    # Add all dependencies to all targets
    string(REPLACE " " ";" deps_list "${deps}")
    foreach(_CONAN_ACTUAL_TARGET ${_CONAN_ACTUAL_TARGETS})
        set_property(TARGET ${_CONAN_ACTUAL_TARGET} PROPERTY INTERFACE_LINK_LIBRARIES "${_CONAN_FOUND_SYSTEM_LIBS};${deps_list}")
    endforeach()

    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


macro(conan_set_libcxx)
    if(DEFINED CONAN_LIBCXX)
        conan_message(STATUS "Conan: C++ stdlib: ${CONAN_LIBCXX}")
        if(CONAN_COMPILER STREQUAL "clang" OR CONAN_COMPILER STREQUAL "apple-clang")
            if(CONAN_LIBCXX STREQUAL "libstdc++" OR CONAN_LIBCXX STREQUAL "libstdc++11" )
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
            elseif(CONAN_LIBCXX STREQUAL "libc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
            endif()
        endif()
        if(CONAN_COMPILER STREQUAL "sun-cc")
            if(CONAN_LIBCXX STREQUAL "libCstd")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=Cstd")
            elseif(CONAN_LIBCXX STREQUAL "libstdcxx")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcxx4")
            elseif(CONAN_LIBCXX STREQUAL "libstlport")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stlport4")
            elseif(CONAN_LIBCXX STREQUAL "libstdc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcpp")
            endif()
        endif()
        if(CONAN_LIBCXX STREQUAL "libstdc++11")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)
        elseif(CONAN_LIBCXX STREQUAL "libstdc++")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)
        endif()
    endif()
endmacro()


macro(conan_set_std)
    conan_message(STATUS "Conan: Adjusting language standard")
    # Do not warn "Manually-specified variables were not used by the project"
    set(ignorevar "${CONAN_STD_CXX_FLAG}${CONAN_CMAKE_CXX_STANDARD}${CONAN_CMAKE_CXX_EXTENSIONS}")
    if (CMAKE_VERSION VERSION_LESS "3.1" OR
        (CMAKE_VERSION VERSION_LESS "3.12" AND ("${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "20" OR "${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "gnu20")))
        if(CONAN_STD_CXX_FLAG)
            conan_message(STATUS "Conan setting CXX_FLAGS flags: ${CONAN_STD_CXX_FLAG}")
            set(CMAKE_CXX_FLAGS "${CONAN_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}")
        endif()
    else()
        if(CONAN_CMAKE_CXX_STANDARD)
            conan_message(STATUS "Conan setting CPP STANDARD: ${CONAN_CMAKE_CXX_STANDARD} WITH EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS}")
            set(CMAKE_CXX_STANDARD ${CONAN_CMAKE_CXX_STANDARD})
            set(CMAKE_CXX_EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS})
        endif()
    endif()
endmacro()


macro(conan_set_rpath)
    conan_message(STATUS "Conan: Adjusting default RPATHs Conan policies")
    if(APPLE)
        # https://cmake.org/Wiki/CMake_RPATH_handling
        # CONAN GUIDE: All generated libraries should have the id and dependencies to other
        # dylibs without path, just the name, EX:
        # libMyLib1.dylib:
        #     libMyLib1.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     libMyLib0.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 120.0.0)
        #     /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1197.1.1)
        # AVOID RPATH FOR *.dylib, ALL LIBS BETWEEN THEM AND THE EXE
        # SHOULD BE ON THE LINKER RESOLVER PATH (./ IS ONE OF THEM)
        set(CMAKE_SKIP_RPATH 1 CACHE BOOL "rpaths" FORCE)
        # Policy CMP0068
        # We want the old behavior, in CMake >= 3.9 CMAKE_SKIP_RPATH won't affect the install_name in OSX
        set(CMAKE_INSTALL_NAME_DIR "")
    endif()
endmacro()


macro(conan_set_fpic)
    if(DEFINED CONAN_CMAKE_POSITION_INDEPENDENT_CODE)
        conan_message(STATUS "Conan: Adjusting fPIC flag (${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})")
        set(CMAKE_POSITION_INDEPENDENT_CODE ${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})
    endif()
endmacro()


macro(conan_output_dirs_setup)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
endmacro()


macro(conan_split_version VERSION_STRING MAJOR MINOR)
    #make a list from the version string
    string(REPLACE "." ";" VERSION_LIST "${VERSION_STRING}")

    #write output values
    list(LENGTH VERSION_LIST _version_len)
    list(GET VERSION_LIST 0 ${MAJOR})
    if(${_version_len} GREATER 1)
        list(GET VERSION_LIST 1 ${MINOR})
    endif()
endmacro()


macro(conan_error_compiler_version)
    message(FATAL_ERROR "Detected a mismatch for the compiler version between your conan profile settings and CMake: \n"
                        "Compiler version specified in your conan profile: ${CONAN_COMPILER_VERSION}\n"
                        "Compiler version detected in CMake: ${VERSION_MAJOR}.${VERSION_MINOR}\n"
                        "Please check your conan profile settings (conan profile show [default|your_profile_name])\n"
                        "P.S. You may set CONAN_DISABLE_CHECK_COMPILER CMake variable in order to disable this check."
           )
endmacro()

set(_CONAN_CURRENT_DIR ${CMAKE_CURRENT_LIST_DIR})

function(conan_get_compiler CONAN_INFO_COMPILER CONAN_INFO_COMPILER_VERSION)
    conan_message(STATUS "Current conanbuildinfo.cmake directory: " ${_CONAN_CURRENT_DIR})
    if(NOT EXISTS ${_CONAN_CURRENT_DIR}/conaninfo.txt)
        conan_message(STATUS "WARN: conaninfo.txt not found")
        return()
    endif()

    file (READ "${_CONAN_CURRENT_DIR}/conaninfo.txt" CONANINFO)

    # MATCHALL will match all, including the last one, which is the full_settings one
    string(REGEX MATCH "full_settings.*" _FULL_SETTINGS_MATCHED ${CONANINFO})
    string(REGEX MATCH "compiler=([-A-Za-z0-9_ ]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER)
        set(${CONAN_INFO_COMPILER} ${_CONAN_INFO_COMPILER} PARENT_SCOPE)
    endif()

    string(REGEX MATCH "compiler.version=([-A-Za-z0-9_.]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER_VERSION)
        set(${CONAN_INFO_COMPILER_VERSION} ${_CONAN_INFO_COMPILER_VERSION} PARENT_SCOPE)
    endif()
endfunction()


function(check_compiler_version)
    conan_split_version(${CMAKE_CXX_COMPILER_VERSION} VERSION_MAJOR VERSION_MINOR)
    if(DEFINED CONAN_SETTINGS_COMPILER_TOOLSET)
       conan_message(STATUS "Conan: Skipping compiler check: Declared 'compiler.toolset'")
       return()
    endif()
    if(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
        # MSVC_VERSION is defined since 2.8.2 at least
        # https://cmake.org/cmake/help/v2.8.2/cmake.html#variable:MSVC_VERSION
        # https://cmake.org/cmake/help/v3.14/variable/MSVC_VERSION.html
        if(
            # 1920-1929 = VS 16.0 (v142 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "16" AND NOT((MSVC_VERSION GREATER 1919) AND (MSVC_VERSION LESS 1930))) OR
            # 1910-1919 = VS 15.0 (v141 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "15" AND NOT((MSVC_VERSION GREATER 1909) AND (MSVC_VERSION LESS 1920))) OR
            # 1900      = VS 14.0 (v140 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "14" AND NOT(MSVC_VERSION EQUAL 1900)) OR
            # 1800      = VS 12.0 (v120 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "12" AND NOT VERSION_MAJOR STREQUAL "18") OR
            # 1700      = VS 11.0 (v110 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "11" AND NOT VERSION_MAJOR STREQUAL "17") OR
            # 1600      = VS 10.0 (v100 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "10" AND NOT VERSION_MAJOR STREQUAL "16") OR
            # 1500      = VS  9.0 (v90 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "9" AND NOT VERSION_MAJOR STREQUAL "15") OR
            # 1400      = VS  8.0 (v80 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "8" AND NOT VERSION_MAJOR STREQUAL "14") OR
            # 1310      = VS  7.1, 1300      = VS  7.0
            (CONAN_COMPILER_VERSION STREQUAL "7" AND NOT VERSION_MAJOR STREQUAL "13") OR
            # 1200      = VS  6.0
            (CONAN_COMPILER_VERSION STREQUAL "6" AND NOT VERSION_MAJOR STREQUAL "12") )
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "gcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 5.0)
            conan_message(STATUS "Conan: Compiler GCC>=5, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "clang")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 8.0)
            conan_message(STATUS "Conan: Compiler Clang>=8, checking major version ${CONAN_COMPILER_VERSION}")
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "apple-clang" OR CONAN_COMPILER STREQUAL "sun-cc" OR CONAN_COMPILER STREQUAL "mcst-lcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
           conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "intel")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 19.1)
            if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
               conan_error_compiler_version()
            endif()
        else()
            if(NOT ${VERSION_MAJOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR})
               conan_error_compiler_version()
            endif()
        endif()
    else()
        conan_message(STATUS "WARN: Unknown compiler '${CONAN_COMPILER}', skipping the version check...")
    endif()
endfunction()


function(conan_check_compiler)
    if(CONAN_DISABLE_CHECK_COMPILER)
        conan_message(STATUS "WARN: Disabled conan compiler checks")
        return()
    endif()
    if(NOT DEFINED CMAKE_CXX_COMPILER_ID)
        if(DEFINED CMAKE_C_COMPILER_ID)
            conan_message(STATUS "This project seems to be plain C, using '${CMAKE_C_COMPILER_ID}' compiler")
            set(CMAKE_CXX_COMPILER_ID ${CMAKE_C_COMPILER_ID})
            set(CMAKE_CXX_COMPILER_VERSION ${CMAKE_C_COMPILER_VERSION})
        else()
            message(FATAL_ERROR "This project seems to be plain C, but no compiler defined")
        endif()
    endif()
    if(NOT CMAKE_CXX_COMPILER_ID AND NOT CMAKE_C_COMPILER_ID)
        # This use case happens when compiler is not identified by CMake, but the compilers are there and work
        conan_message(STATUS "*** WARN: CMake was not able to identify a C or C++ compiler ***")
        conan_message(STATUS "*** WARN: Disabling compiler checks. Please make sure your settings match your environment ***")
        return()
    endif()
    if(NOT DEFINED CONAN_COMPILER)
        conan_get_compiler(CONAN_COMPILER CONAN_COMPILER_VERSION)
        if(NOT DEFINED CONAN_COMPILER)
            conan_message(STATUS "WARN: CONAN_COMPILER variable not set, please make sure yourself that "
                          "your compiler and version matches your declared settings")
            return()
        endif()
    endif()

    if(NOT CMAKE_HOST_SYSTEM_NAME STREQUAL ${CMAKE_SYSTEM_NAME})
        set(CROSS_BUILDING 1)
    endif()

    # If using VS, verify toolset
    if (CONAN_COMPILER STREQUAL "Visual Studio")
        if (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "LLVM" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "llvm" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "clang" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Clang")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Clang")
        elseif (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Intel")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Intel")
        else()
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "MSVC")
        endif()

        if (NOT CMAKE_CXX_COMPILER_ID MATCHES ${EXPECTED_CMAKE_CXX_COMPILER_ID})
            message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}'. Toolset specifies compiler as '${EXPECTED_CMAKE_CXX_COMPILER_ID}' "
                                "but CMake detected '${CMAKE_CXX_COMPILER_ID}'")
        endif()

    # Avoid checks when cross compiling, apple-clang crashes because its APPLE but not apple-clang
    # Actually CMake is detecting "clang" when you are using apple-clang, only if CMP0025 is set to NEW will detect apple-clang
    elseif((CONAN_COMPILER STREQUAL "gcc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU") OR
        (CONAN_COMPILER STREQUAL "apple-clang" AND NOT CROSS_BUILDING AND (NOT APPLE OR NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")) OR
        (CONAN_COMPILER STREQUAL "clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR
        (CONAN_COMPILER STREQUAL "sun-cc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "SunPro") )
        message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}', is not the one detected by CMake: '${CMAKE_CXX_COMPILER_ID}'")
    endif()


    if(NOT DEFINED CONAN_COMPILER_VERSION)
        conan_message(STATUS "WARN: CONAN_COMPILER_VERSION variable not set, please make sure yourself "
                             "that your compiler version matches your declared settings")
        return()
    endif()
    check_compiler_version()
endfunction()


macro(conan_set_flags build_type)
    set(CMAKE_CXX_FLAGS${build_type} "${CMAKE_CXX_FLAGS${build_type}} ${CONAN_CXX_FLAGS${build_type}}")
    set(CMAKE_C_FLAGS${build_type} "${CMAKE_C_FLAGS${build_type}} ${CONAN_C_FLAGS${build_type}}")
    set(CMAKE_SHARED_LINKER_FLAGS${build_type} "${CMAKE_SHARED_LINKER_FLAGS${build_type}} ${CONAN_SHARED_LINKER_FLAGS${build_type}}")
    set(CMAKE_EXE_LINKER_FLAGS${build_type} "${CMAKE_EXE_LINKER_FLAGS${build_type}} ${CONAN_EXE_LINKER_FLAGS${build_type}}")
endmacro()


macro(conan_global_flags)
    if(CONAN_SYSTEM_INCLUDES)
        include_directories(SYSTEM ${CONAN_INCLUDE_DIRS}
                                   "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                                   "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                                   "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                                   "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    else()
        include_directories(${CONAN_INCLUDE_DIRS}
                            "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                            "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                            "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                            "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    endif()

    link_directories(${CONAN_LIB_DIRS})

    conan_find_libraries_abs_path("${CONAN_LIBS_DEBUG}" "${CONAN_LIB_DIRS_DEBUG}"
                                  CONAN_LIBS_DEBUG)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELEASE}" "${CONAN_LIB_DIRS_RELEASE}"
                                  CONAN_LIBS_RELEASE)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RELWITHDEBINFO}"
                                  CONAN_LIBS_RELWITHDEBINFO)
    conan_find_libraries_abs_path("${CONAN_LIBS_MINSIZEREL}" "${CONAN_LIB_DIRS_MINSIZEREL}"
                                  CONAN_LIBS_MINSIZEREL)

    add_compile_options(${CONAN_DEFINES}
                        "$<$<CONFIG:Debug>:${CONAN_DEFINES_DEBUG}>"
                        "$<$<CONFIG:Release>:${CONAN_DEFINES_RELEASE}>"
                        "$<$<CONFIG:RelWithDebInfo>:${CONAN_DEFINES_RELWITHDEBINFO}>"
                        "$<$<CONFIG:MinSizeRel>:${CONAN_DEFINES_MINSIZEREL}>")

    conan_set_flags("")
    conan_set_flags("_RELEASE")
    conan_set_flags("_DEBUG")

endmacro()


macro(conan_target_link_libraries target)
    if(CONAN_TARGETS)
        target_link_libraries(${target} ${CONAN_TARGETS})
    else()
        target_link_libraries(${target} ${CONAN_LIBS})
        foreach(_LIB ${CONAN_LIBS_RELEASE})
            target_link_libraries(${target} optimized ${_LIB})
        endforeach()
        foreach(_LIB ${CONAN_LIBS_DEBUG})
            target_link_libraries(${target} debug ${_LIB})
        endforeach()
    endif()
endmacro()


macro(conan_include_build_modules)
    if(CMAKE_BUILD_TYPE)
        if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_DEBUG} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELEASE} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELWITHDEBINFO} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_MINSIZEREL} ${CONAN_BUILD_MODULES_PATHS})
        endif()
    endif()

    foreach(_BUILD_MODULE_PATH ${CONAN_BUILD_MODULES_PATHS})
        include(${_BUILD_MODULE_PATH})
    endforeach()
endmacro()


### Definition of user declared vars (user_info) ###

