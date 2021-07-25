#pragma once

#include "core/core.h"
#include "graphics/deletion_queue.h"

namespace gm
{
    class Instance
    {
    public:
        Instance();
        ~Instance();

        VkInstance get() const { return m_instance; }

        const std::vector<const char*>& getValidationLayers() const { return m_validationLayers; }

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
