#pragma once

#ifdef GM_PLATFORM_WINDOWS
    #ifdef GM_BUILD_DLL
        #define GM_API __declspec(dllexport)
    #else
        #define GM_API __declspec(dllimport)
    #endif
#else
    #define GM_API
#endif

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <vk_mem_alloc.h>

#include <iostream>
#include <memory>
#include <vector>
#include <cstring>
#include <string>
#include <sstream>
#include <iomanip>

namespace gm
{
    template<typename T>
    using Reference = std::shared_ptr<T>;
}