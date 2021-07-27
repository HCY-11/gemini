#pragma once

#include "core/core.h"
#include "core/window.h"

namespace gm
{
    extern VKAPI_ATTR VkBool32 VKAPI_CALL debugCallback(
        VkDebugUtilsMessageSeverityFlagBitsEXT           messageSeverity,
        VkDebugUtilsMessageTypeFlagsEXT                  messageTypes,
        const VkDebugUtilsMessengerCallbackDataEXT*      pCallbackData,
        void*                                            pUserData);

    extern VkResult createDebugUtilsMessengerEXT(
        VkInstance                                      instance,
        const VkDebugUtilsMessengerCreateInfoEXT*       pCreateInfo,
        const VkAllocationCallbacks*                    pAllocator,
        VkDebugUtilsMessengerEXT*                       pMessenger);

    extern void destroyDebugUtilsMessengerEXT(
        VkInstance                                      instance,
        VkDebugUtilsMessengerEXT                        messenger,
        const VkAllocationCallbacks*                    pAllocator
    );

    extern void framebufferResizedCallback(GLFWwindow* window, int width, int height);
}