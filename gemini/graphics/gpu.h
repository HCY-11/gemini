#pragma once

#include <optional>

#include "instance.h"
#include "surface.h"

struct QueueFamilyIndices
{
    std::optional<uint32_t> graphics;
    std::optional<uint32_t> present;

    void find(VkPhysicalDevice gpu, VkSurfaceKHR surface)
    {
        uint32_t count = 0;
        vkGetPhysicalDeviceQueueFamilyProperties(gpu, &count, nullptr);
        std::vector<VkQueueFamilyProperties> properties(count);
        vkGetPhysicalDeviceQueueFamilyProperties(gpu, &count, properties.data());

        uint32_t i = 0;
        for (const auto& prop : properties)
        {
            if (prop.queueFlags & VK_QUEUE_GRAPHICS_BIT)
            {
                graphics = i;
            }

            VkBool32 presentSupported = VK_FALSE;
            vkGetPhysicalDeviceSurfaceSupportKHR(gpu, i, surface, &presentSupported);

            if (presentSupported)
            {
                present = i;
            }

            if (isPopulated())
            {
                break;
            }

            i++;
        }
    }

    bool isPopulated()
    {
        return graphics.has_value() && present.has_value();
    }
};



struct SwapchainSupportInfo
{
    VkSurfaceCapabilitiesKHR capabilities;
    std::vector<VkSurfaceFormatKHR> surfaceFormats;
    std::vector<VkPresentModeKHR> presentModes;

    void querySwapchainSupport(VkPhysicalDevice gpu, VkSurfaceKHR surface)
    {
        vkGetPhysicalDeviceSurfaceCapabilitiesKHR(gpu, surface, &capabilities);

        uint32_t formatCount = 0;
        vkGetPhysicalDeviceSurfaceFormatsKHR(gpu, surface, &formatCount, nullptr);

        if (formatCount != 0)
        {
            surfaceFormats.resize(formatCount);
            vkGetPhysicalDeviceSurfaceFormatsKHR(gpu, surface, &formatCount, surfaceFormats.data());
        }

        uint32_t presentModeCount = 0;
        vkGetPhysicalDeviceSurfacePresentModesKHR(gpu, surface, &presentModeCount, nullptr);

        if (presentModeCount != 0)
        {
            presentModes.resize(presentModeCount);
            vkGetPhysicalDeviceSurfacePresentModesKHR(gpu, surface, &presentModeCount, presentModes.data());
        }
    }
};



class GPU
{
public:
    GPU();
    ~GPU();

    void find(const Instance& instance, const Surface& surface);

    VkPhysicalDevice get() const { return m_gpu; }

    QueueFamilyIndices getQueueFamilyIndices() const { return m_indices; }

    const std::vector<const char*>& getDeviceExtensions() const { return m_deviceExtensions; }

private:
    bool isDeviceSuitable(VkPhysicalDevice gpu, VkSurfaceKHR surface);

    bool areExtensionsSupported(VkPhysicalDevice gpu);

private:
    VkPhysicalDevice                m_gpu                   = VK_NULL_HANDLE;

    QueueFamilyIndices              m_indices               = {}; 
    SwapchainSupportInfo            m_swapchainInfo         = {};

    std::vector<const char*>        m_deviceExtensions      = { VK_KHR_SWAPCHAIN_EXTENSION_NAME };
};