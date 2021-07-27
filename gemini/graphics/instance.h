#pragma once

#include "core/core.h"

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

    class Instance
    {
    public:
        Instance();
        ~Instance();

        inline VkInstance get() const { return m_instance; }

        inline const std::vector<const char*>& getValidationLayers() const { return m_validationLayers; }

    private:
        void checkValidationLayerSupport();
        
        void createDebugMessenger();

        void populateMessengerInfo(VkDebugUtilsMessengerCreateInfoEXT& messengerInfo);

    private:
        std::vector<const char*>        m_validationLayers          = { "VK_LAYER_KHRONOS_validation" };

        VkInstance                      m_instance                  = VK_NULL_HANDLE;
        VkDebugUtilsMessengerEXT        m_debugMessenger            = VK_NULL_HANDLE;
    };
}
