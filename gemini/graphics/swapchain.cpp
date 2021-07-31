#include "swapchain.h"
#include "logging/logger.h"

namespace gm
{
    Swapchain::Swapchain(Window* window, Surface* surface, GPU* gpu, Device* device) : m_window(window), m_device(device)
    {
        m_info.querySwapchainSupport(gpu->get(), surface->get());

        m_extent = chooseExtent();
        m_presentMode = choosePresentMode();
        m_surfaceFormat = chooseSurfaceFormat();

        uint32_t numImages = m_info.capabilities.minImageCount + 1; // Recommended to request 1 more than minimum

        if (m_info.capabilities.maxImageCount > 0 && numImages > m_info.capabilities.maxImageCount)
        {
            numImages = m_info.capabilities.maxImageCount;
        }

        VkSwapchainCreateInfoKHR swapchainInfo  = {};
        swapchainInfo.sType                     = VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR;
        swapchainInfo.surface                   = surface->get();
        swapchainInfo.imageColorSpace           = m_surfaceFormat.colorSpace;
        swapchainInfo.imageFormat               = m_surfaceFormat.format;
        swapchainInfo.imageExtent               = m_extent;
        swapchainInfo.presentMode               = m_presentMode;
        swapchainInfo.imageArrayLayers          = 1;
        swapchainInfo.imageUsage                = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;
        swapchainInfo.preTransform              = m_info.capabilities.currentTransform;
        swapchainInfo.compositeAlpha            = VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR;
        swapchainInfo.clipped                   = VK_TRUE;
        swapchainInfo.minImageCount             = numImages;
        swapchainInfo.oldSwapchain              = VK_NULL_HANDLE;

        QueueFamilyIndices indices = gpu->getQueueFamilyIndices();

        uint32_t queueFamilyIndices[] = { indices.graphics.value(), indices.present.value() };

        if (indices.graphics != indices.present)
        {
            swapchainInfo.imageSharingMode          = VK_SHARING_MODE_CONCURRENT;
            swapchainInfo.queueFamilyIndexCount     = sizeof(queueFamilyIndices) / sizeof(uint32_t);
            swapchainInfo.pQueueFamilyIndices       = queueFamilyIndices;
        }
        else
        {
            swapchainInfo.imageSharingMode          = VK_SHARING_MODE_EXCLUSIVE;
            swapchainInfo.queueFamilyIndexCount     = 0;
        }

        GM_CORE_ASSERT(vkCreateSwapchainKHR(m_device->get(), &swapchainInfo, nullptr, &m_swapchain) == VK_SUCCESS, "Failed to create swapchain!");

        createImageViews();
    }

    Swapchain::~Swapchain()
    {
        for (const auto& view : m_imageViews)
        {
            vkDestroyImageView(m_device->get(), view, nullptr);
        }

        vkDestroySwapchainKHR(m_device->get(), m_swapchain, nullptr);
    }

    VkExtent2D Swapchain::chooseExtent()
    {
        if (m_info.capabilities.currentExtent.width != UINT32_MAX)
        {
            return m_info.capabilities.currentExtent;
        }
        else
        {
            int width, height;
            glfwGetFramebufferSize(m_window->get(), &width, &height);

            VkExtent2D extent
            {
                static_cast<uint32_t>(width),
                static_cast<uint32_t>(height)
            };

            extent.width = std::max(m_info.capabilities.minImageExtent.width, std::min(extent.width, m_info.capabilities.maxImageExtent.width));
            extent.height = std::max(m_info.capabilities.minImageExtent.height, std::min(extent.height, m_info.capabilities.maxImageExtent.height));

            return extent;
        }
    }

    void Swapchain::createImageViews()
    {
        uint32_t count = 0;

        std::vector<VkImage> buffers;
        vkGetSwapchainImagesKHR(m_device->get(), m_swapchain, &count, nullptr);
        buffers.resize(count);
        vkGetSwapchainImagesKHR(m_device->get(), m_swapchain, &count, buffers.data());

        m_imageViews.resize(count);

        for (uint32_t i = 0; i < m_imageViews.size(); i++)
        {
            VkImageViewCreateInfo viewInfo                  = {};
            viewInfo.sType                                  = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
            viewInfo.image                                  = buffers[i];
            viewInfo.format                                 = m_surfaceFormat.format;
            viewInfo.viewType                               = VK_IMAGE_VIEW_TYPE_2D;

            viewInfo.components.r                           = VK_COMPONENT_SWIZZLE_IDENTITY;
            viewInfo.components.g                           = VK_COMPONENT_SWIZZLE_IDENTITY;
            viewInfo.components.b                           = VK_COMPONENT_SWIZZLE_IDENTITY;
            viewInfo.components.a                           = VK_COMPONENT_SWIZZLE_IDENTITY;

            viewInfo.subresourceRange.aspectMask            = VK_IMAGE_ASPECT_COLOR_BIT;
            viewInfo.subresourceRange.layerCount            = 1;
            viewInfo.subresourceRange.baseArrayLayer        = 0;
            viewInfo.subresourceRange.levelCount            = 1;
            viewInfo.subresourceRange.baseMipLevel          = 0;

            GM_CORE_ASSERT(vkCreateImageView(m_device->get(), &viewInfo, nullptr, &m_imageViews[i]) == VK_SUCCESS,
                            "Failed to create image view!");
        }
    }

    VkPresentModeKHR Swapchain::choosePresentMode()
    {
        for (const auto& mode : m_info.presentModes)
        {
            if (mode == VK_PRESENT_MODE_MAILBOX_KHR)
            {
                return mode;
            }
        }

        return VK_PRESENT_MODE_FIFO_KHR;
    }

    VkSurfaceFormatKHR Swapchain::chooseSurfaceFormat()
    {
        for (const auto& format : m_info.surfaceFormats)
        {
            if (format.colorSpace == VK_COLOR_SPACE_SRGB_NONLINEAR_KHR && format.format == VK_FORMAT_B8G8R8A8_SRGB)
            {
                return format;
            }
        }

        return m_info.surfaceFormats[0];
    }
}
