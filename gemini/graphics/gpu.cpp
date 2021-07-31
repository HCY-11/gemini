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


    VkFormat GPU::findSupportedFormat(const std::vector<VkFormat>& candidates, VkImageTiling tiling, VkFormatFeatureFlags features)
    {
        for (VkFormat format : candidates)
        {
            VkFormatProperties properties;
            vkGetPhysicalDeviceFormatProperties(m_gpu, format, &properties);

            if (tiling == VK_IMAGE_TILING_LINEAR && (properties.linearTilingFeatures & features) == features)
            {
                return format;
            }
            else if (tiling == VK_IMAGE_TILING_OPTIMAL && (properties.optimalTilingFeatures & features) == features)
            {
                return format;
            }
        }

        GM_CORE_ERROR("Failed to find supported image format in candidates!");
        return VK_FORMAT_UNDEFINED;
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

        VkPhysicalDeviceFeatures supportedFeatures = {};
        vkGetPhysicalDeviceFeatures(gpu, &supportedFeatures);

        return m_indices.isPopulated() && swapchainSupported && supportedFeatures.samplerAnisotropy;
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
