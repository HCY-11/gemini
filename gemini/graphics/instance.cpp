#include "instance.h"
#include "logging/logger.h"
#include "graphics/callbacks.h"

namespace gm
{
    Instance::Instance()
    {
#ifndef NDEBUG
        checkValidationLayerSupport();
#endif

        VkApplicationInfo appInfo               = {};
        appInfo.sType                           = VK_STRUCTURE_TYPE_APPLICATION_INFO;
        appInfo.apiVersion                      = VK_API_VERSION_1_2;

        VkInstanceCreateInfo instanceInfo       = {};
        instanceInfo.sType                      = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
        instanceInfo.pApplicationInfo           = &appInfo;

        uint32_t count = 0;
        const char** glfwExtensions = glfwGetRequiredInstanceExtensions(&count);
        std::vector<const char*> extensions(glfwExtensions, glfwExtensions + count);

#ifndef NDEBUG
        extensions.push_back(VK_EXT_DEBUG_UTILS_EXTENSION_NAME);

        instanceInfo.enabledLayerCount          = m_validationLayers.size();
        instanceInfo.ppEnabledLayerNames        = m_validationLayers.data();

        VkDebugUtilsMessengerCreateInfoEXT messengerInfo        = {};
        populateMessengerInfo(messengerInfo);

        instanceInfo.pNext                      = reinterpret_cast<VkDebugUtilsMessengerCreateInfoEXT*>(&messengerInfo);
#else
        instanceInfo.enabledLayerCount          = 0;
#endif

        instanceInfo.enabledExtensionCount      = extensions.size();
        instanceInfo.ppEnabledExtensionNames    = extensions.data();

        GM_CORE_ASSERT(vkCreateInstance(&instanceInfo, nullptr, &m_instance) == VK_SUCCESS, "Failed to create instance!");

        createDebugMessenger();
    }

    Instance::~Instance()
    {
#ifndef NDEBUG
        destroyDebugUtilsMessengerEXT(m_instance, m_debugMessenger, nullptr);
#endif
        vkDestroyInstance(m_instance, nullptr);
    }

    void Instance::checkValidationLayerSupport()
    {
        uint32_t count = 0;
        vkEnumerateInstanceLayerProperties(&count, nullptr);
        std::vector<VkLayerProperties> layerProps(count);
        vkEnumerateInstanceLayerProperties(&count, layerProps.data());

        for (const char* layerName : m_validationLayers)
        {
            bool isFound = false;

            for (const auto& prop : layerProps)
            {
                if (std::strcmp(layerName, prop.layerName) == 0)
                {
                    isFound = true;
                }
            }

            if (!isFound)
            {
                GM_CORE_ERROR("Failed to find validation layers");
            }
        }
    }

    void Instance::createDebugMessenger()
    {
        VkDebugUtilsMessengerCreateInfoEXT messengerInfo        = {};
        populateMessengerInfo(messengerInfo);

        GM_CORE_ASSERT(createDebugUtilsMessengerEXT(m_instance, &messengerInfo, nullptr, &m_debugMessenger) == VK_SUCCESS, 
                        "Failed to create debug messenger!");
    }

    void Instance::populateMessengerInfo(VkDebugUtilsMessengerCreateInfoEXT& messengerInfo)
    {
        messengerInfo.sType                                     = VK_STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT;
        messengerInfo.messageSeverity                           = VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT |
                                                                  VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT |
                                                                  VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT;

        messengerInfo.messageType                               = VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT |
                                                                  VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT |
                                                                  VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT;

        messengerInfo.pfnUserCallback                           = debugCallback;
    }
}
