#pragma once

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <vk_mem_alloc.h>
#include <imgui.h>
#include <tiny_obj_loader.h>
#include <stb_image.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtx/transform.hpp>
#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/fmt/ostr.h>

#include <iostream>
#include <memory>
#include <unordered_map>
#include <vector>
#include <cstring>
#include <string>
#include <sstream>
#include <iomanip>
#include <optional>
#include <fstream>
#include <deque>
#include <set>

#ifdef GM_PLATFORM_WINDOWS
    #ifdef GM_BUILD_DLL
        #define GM_API __declspec(dllexport)
    #else
        #define GM_API __declspec(dllimport)
    #endif

    #define GM_API
    #ifdef GM_ENABLE_ASSERT
        #define GM_CORE_ASSERT(c, ...) if (!c) { GM_CORE_ERROR("Assertion Failed {0}: ", __VA_ARGS__); __debugbreak(); }
        #define GM_ASSERT(c, ...) if (!c) { GM_ERROR("Assertion Failed {0}: ", __VA_ARGS__); __debugbreak(); }
    #else
        #define GM_CORE_ASSERT(c, ...)
        #define GM_ASSERT(c, ...)
    #endif
#else
    #define GM_API
    #ifdef GM_ENABLE_ASSERT
        #include <signal.h>
        #define GM_CORE_ASSERT(c, ...) if (!(c)) { GM_CORE_ERROR("{0}: ", __VA_ARGS__); raise(SIGTRAP); }
        #define GM_ASSERT(c, ...) if (!(c)) { GM_ERROR("{0}: ", __VA_ARGS__); raise(SIGTRAP); }
    #else
        #define GM_CORE_ASSERT(c, ...)
        #define GM_ASSERT(c, ...)
    #endif
#endif

#define BIT(n) (1 << n)

namespace gm
{
    template<typename T>
    using Reference = std::shared_ptr<T>;
    
    template<typename T, typename ... Args>
    constexpr Reference<T> makeReference(Args&& ... args)
    {
        return std::make_shared<T>(std::forward<Args>(args)...);
    }

    template<typename T>
    using Scope = std::unique_ptr<T>;

    template<typename T, typename ... Args>
    constexpr Scope<T> makeScope(Args&& ... args)
    {
        return std::make_unique<T>(std::forward<Args>(args)...);
    }
}