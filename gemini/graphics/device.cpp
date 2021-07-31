#include "device.h"
#include "logging/logger.h"

namespace gm
{
    Device::Device(Instance* instance, GPU* gpu)
    {
        float queuePriority = 1.0f;

        std::set<uint32_t> queueFamilyIndices = 
        { 
            gpu->getQueueFamilyIndices().graphics.value(),
            gpu->getQueueFamilyIndices().present.value()
        };

        std::vector<VkDeviceQueueCreateInfo> queueCreateInfos;

        for (uint32_t i : queueFamilyIndices)
        {
            VkDeviceQueueCreateInfo queueCreateInfo         = {};
            queueCreateInfo.sType                           = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
            queueCreateInfo.pQueuePriorities                = &queuePriority;
            queueCreateInfo.queueCount                      = 1;
            queueCreateInfo.queueFamilyIndex                = i;

            queueCreateInfos.push_back(queueCreateInfo);
        }

        VkPhysicalDeviceFeatures features               = {};
        features.samplerAnisotropy                      = VK_TRUE;

        VkDeviceCreateInfo deviceInfo                   = {};
        deviceInfo.sType                                = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
        deviceInfo.pEnabledFeatures                     = &features;
        deviceInfo.queueCreateInfoCount                 = queueCreateInfos.size();
        deviceInfo.pQueueCreateInfos                    = queueCreateInfos.data();
        deviceInfo.enabledExtensionCount                = gpu->getDeviceExtensions().size();
        deviceInfo.ppEnabledExtensionNames              = gpu->getDeviceExtensions().data();

#ifndef NDEBUG
        deviceInfo.enabledLayerCount                    = instance->getValidationLayers().size();
        deviceInfo.ppEnabledLayerNames                  = instance->getValidationLayers().data();
#else
        deviceInfo.enabledLayerCount                    = 0;
#endif

        GM_CORE_ASSERT(vkCreateDevice(gpu->get(), &deviceInfo, nullptr, &m_device) == VK_SUCCESS, "Failed to create device!");

        vkGetDeviceQueue(m_device, gpu->getQueueFamilyIndices().graphics.value(), 0, &m_graphicsQueue);
        vkGetDeviceQueue(m_device, gpu->getQueueFamilyIndices().present.value(), 0, &m_presentQueue);
    }

    Device::~Device()
    {
        vkDestroyDevice(m_device, nullptr); 
    }
}
