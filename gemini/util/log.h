#pragma once

#include <iostream>
#include <vulkan/vulkan.h>

#define LOG(msg) std::cout << msg << std::endl
#define CHECK_VK_RESULT(result, errMsg) if (result != VK_SUCCESS) LOG(errMsg)