#include "device.h"
#include "util/log.h"

#include <set>

Device::Device()
{

}

Device::~Device()
{

}

void Device::create(const Instance& instance, const GPU& gpu)
{
    float queuePriority = 1.0f;

    std::set<uint32_t> queueFamilyIndices = 
    { 
        gpu.getQueueFamilyIndices().graphics.value(),
        gpu.getQueueFamilyIndices().present.value()
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

    VkDeviceCreateInfo deviceInfo                   = {};
    deviceInfo.sType                                = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
    deviceInfo.pEnabledFeatures                     = &features;
    deviceInfo.queueCreateInfoCount                 = queueCreateInfos.size();
    deviceInfo.pQueueCreateInfos                    = queueCreateInfos.data();
    deviceInfo.enabledExtensionCount                = gpu.getDeviceExtensions().size();
    deviceInfo.ppEnabledExtensionNames              = gpu.getDeviceExtensions().data();

#ifndef NDEBUG
    deviceInfo.enabledLayerCount                    = instance.getValidationLayers().size();
    deviceInfo.ppEnabledLayerNames                  = instance.getValidationLayers().data();
#else
    deviceInfo.enabledLayerCount                    = 0;
#endif

    CHECK_VK_RESULT(vkCreateDevice(gpu.get(), &deviceInfo, nullptr, &m_device), "Failed to create device!");

    vkGetDeviceQueue(m_device, gpu.getQueueFamilyIndices().graphics.value(), 0, &m_graphicsQueue);
    vkGetDeviceQueue(m_device, gpu.getQueueFamilyIndices().present.value(), 0, &m_presentQueue);

    createAllocator(instance, gpu);
}

void Device::destroy()
{
    vkDestroyDevice(m_device, nullptr);
}

void Device::createAllocator(const Instance& instance, const GPU& gpu)
{
    VmaAllocatorCreateInfo allocatorInfo        = {};
    allocatorInfo.instance                      = instance.get();
    allocatorInfo.physicalDevice                = gpu.get();
    allocatorInfo.device                        = m_device;

    CHECK_VK_RESULT(vmaCreateAllocator(&allocatorInfo, &m_allocator),
                    "Failed to create allocator!");
}