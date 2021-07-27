#include "callbacks.h"

namespace gm
{
    VKAPI_ATTR VkBool32 VKAPI_CALL debugCallback(
        VkDebugUtilsMessageSeverityFlagBitsEXT           messageSeverity,
        VkDebugUtilsMessageTypeFlagsEXT                  messageTypes,
        const VkDebugUtilsMessengerCallbackDataEXT*      pCallbackData,
        void*                                            pUserData)
    {
        GM_CORE_INFO("Vulkan: {0}", pCallbackData->pMessage);

        return VK_FALSE;
    }

    VkResult createDebugUtilsMessengerEXT(
        VkInstance                                      instance, 
        const VkDebugUtilsMessengerCreateInfoEXT*       pCreateInfo, 
        const VkAllocationCallbacks*                    pAllocator, 
        VkDebugUtilsMessengerEXT*                       pMessenger)
    {
        auto func = reinterpret_cast<PFN_vkCreateDebugUtilsMessengerEXT>(vkGetInstanceProcAddr(instance, "vkCreateDebugUtilsMessengerEXT"));

        if (func != nullptr)
        {
            return func(instance, pCreateInfo, pAllocator, pMessenger);
        }

        return VK_ERROR_EXTENSION_NOT_PRESENT;
    }

    void destroyDebugUtilsMessengerEXT(
        VkInstance                                      instance,
        VkDebugUtilsMessengerEXT                        messenger,
        const VkAllocationCallbacks*                    pAllocator
    )
    {
        auto func = reinterpret_cast<PFN_vkDestroyDebugUtilsMessengerEXT>(vkGetInstanceProcAddr(instance, "vkDestroyDebugUtilsMessengerEXT"));

        if (func != nullptr)
        {
            func(instance, messenger, pAllocator);
        }
    }

    void framebufferResizedCallback(GLFWwindow* window, int width, int height)
    {
        auto app = reinterpret_cast<Window*>(glfwGetWindowUserPointer(window));

        app->setIsResized(true);
    }
}