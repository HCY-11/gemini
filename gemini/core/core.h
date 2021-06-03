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

#include <iostream>
#include <memory>
#include <vector>
#include <cstring>
#include <string>
#include <sstream>

namespace gm
{
    template<typename T>
    using Reference = std::shared_ptr<T>;
}