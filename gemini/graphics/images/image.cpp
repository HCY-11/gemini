#include "image.h"

namespace gm
{
    Image::Image(
        Window* window,
        GPU* gpu,
        Device* device,
        VmaAllocator allocator, 
        VmaMemoryUsage memUsage,
        VkMemoryPropertyFlags memFlags,
        const std::vector<VkFormat>& formats, 
        VkFormatFeatureFlags features,
        VkImageType type, 
        VkSampleCountFlagBits samples, 
        VkImageTiling tiling, 
        VkImageUsageFlags usage,
        VkImageAspectFlags aspectFlags) : m_device(device), m_allocator(allocator)
    {
        m_allocator = allocator;

        m_format = gpu->findSupportedFormat(formats, tiling, features);

        VkImageCreateInfo createInfo                    = {};
        createInfo.sType                                = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
        createInfo.imageType                            = type;
        createInfo.format                               = m_format;

        int width, height;
        glfwGetWindowSize(window->get(), &width, &height);

        createInfo.extent                               = { 
                                                                static_cast<uint32_t>(width),
                                                                static_cast<uint32_t>(height),
                                                                1
                                                          };

        createInfo.mipLevels                            = 1;
        createInfo.arrayLayers                          = 1;
        createInfo.samples                              = samples;
        createInfo.tiling                               = tiling;
        createInfo.usage                                = usage;

        VmaAllocationCreateInfo allocationInfo          = {};
        allocationInfo.usage                            = memUsage;
        allocationInfo.requiredFlags                    = memFlags;

        GM_CORE_ASSERT(vmaCreateImage(m_allocator, &createInfo, &allocationInfo, &m_data, &m_allocation, nullptr) == VK_SUCCESS,
                       "Failed to create image!");

        VkImageViewCreateInfo viewInfo                  = {};
        viewInfo.sType                                  = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
        viewInfo.format                                 = m_format;
        viewInfo.image                                  = m_data;
        viewInfo.viewType                               = VK_IMAGE_VIEW_TYPE_2D;
        viewInfo.subresourceRange.aspectMask            = aspectFlags;
        viewInfo.subresourceRange.layerCount            = 1;
        viewInfo.subresourceRange.baseArrayLayer        = 0;
        viewInfo.subresourceRange.levelCount            = 1;
        viewInfo.subresourceRange.baseMipLevel          = 0;

        GM_CORE_ASSERT(vkCreateImageView(m_device->get(), &viewInfo, nullptr, &m_view) == VK_SUCCESS,
                       "Failed to create image view!");
    }

    Image::~Image()
    {
        vkDestroyImageView(m_device->get(), m_view, nullptr);
        vmaDestroyImage(m_allocator, m_data, m_allocation);
    }
}
