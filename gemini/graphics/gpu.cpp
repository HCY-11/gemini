#include "gpu.h"
#include "logging/logger.h"

namespace gm
{
    GPU::GPU(Instance* instance, Surface* surface)
    {
        uint32_t count = 0;
        vkEnumeratePhysicalDevices(instance->get(), &count, nullptr);
        std::vector<VkPhysicalDevice> gpus(count);
        vkEnumeratePhysicalDevices(instance->get(), &count, gpus.data());

        for (const auto& gpu : gpus)
        {
            if (isDeviceSuitable(gpu, surface->get()))
            {
                m_gpu = gpu;
                break;
            }
        }

        if (m_gpu == VK_NULL_HANDLE)
        {
            GM_CORE_ERROR("Failed to find suitable GPU!");
        }
    }

    bool GPU::isDeviceSuitable(VkPhysicalDevice gpu, VkSurfaceKHR surface)
    {
        m_indices.find(gpu, surface);

        bool swapchainSupported = false;
        if (areExtensionsSupported(gpu))
        {
            m_swapchainInfo.querySwapchainSupport(gpu, surface);

            swapchainSupported = !m_swapchainInfo.presentModes.empty() && !m_swapchainInfo.surfaceFormats.empty();
        }

        return m_indices.isPopulated() && swapchainSupported;
    }

    bool GPU::areExtensionsSupported(VkPhysicalDevice gpu)
    {
        uint32_t count = 0;
        vkEnumerateDeviceExtensionProperties(gpu, nullptr, &count, nullptr);
        std::vector<VkExtensionProperties> properties(count);
        vkEnumerateDeviceExtensionProperties(gpu, nullptr, &count, properties.data());

        std::set<std::string> requiredExtensions = { m_deviceExtensions.begin(), m_deviceExtensions.end() };

        for (const auto& prop : properties)
        {
            requiredExtensions.erase(prop.extensionName);
        }

        return requiredExtensions.empty();
    }
}
