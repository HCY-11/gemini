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
        VkImageAspectFlags aspectFlags)
    {
        int width, height;
        glfwGetWindowSize(window->get(), &width, &height);

        VkExtent3D extent = 
        {
            static_cast<uint32_t>(width),
            static_cast<uint32_t>(height),
            1
        };
        
        init(
            device,
            extent,
            allocator,
            memUsage,
            memFlags,
            gpu->findSupportedFormat(formats, tiling, features),
            type,
            samples,
            tiling,
            usage,
            aspectFlags
        );
    }

    void Image::init(
        Device* device,
        const VkExtent3D& extent,
        VmaAllocator allocator,
        VmaMemoryUsage memUsage,
        VkMemoryPropertyFlags memFlags,
        VkFormat format,
        VkImageType type, 
        VkSampleCountFlagBits samples, 
        VkImageTiling tiling, 
        VkImageUsageFlags usage,
        VkImageAspectFlags aspectFlags
    ) 
    {
        m_device = device;
        m_allocator = allocator;
        m_format = format;

        VkImageCreateInfo createInfo                    = {};
        createInfo.sType                                = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
        createInfo.imageType                            = type;
        createInfo.format                               = m_format;

        createInfo.extent                               = extent;
        createInfo.mipLevels                            = 1;
        createInfo.arrayLayers                          = 1;
        createInfo.samples                              = samples;
        createInfo.tiling                               = tiling;
        createInfo.usage                                = usage;

        VmaAllocationCreateInfo allocationInfo          = {};
        allocationInfo.usage                            = memUsage;
        allocationInfo.requiredFlags                    = memFlags;

        GM_CORE_ASSERT(vmaCreateImage(m_allocator, &createInfo, &allocationInfo, &m_image, &m_allocation, nullptr) == VK_SUCCESS,
                       "Failed to create image!");

        VkImageViewCreateInfo viewInfo                  = {};
        viewInfo.sType                                  = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
        viewInfo.format                                 = m_format;
        viewInfo.image                                  = m_image;
        viewInfo.viewType                               = VK_IMAGE_VIEW_TYPE_2D;
        viewInfo.subresourceRange.aspectMask            = aspectFlags;
        viewInfo.subresourceRange.layerCount            = 1;
        viewInfo.subresourceRange.baseArrayLayer        = 0;
        viewInfo.subresourceRange.levelCount            = 1;
        viewInfo.subresourceRange.baseMipLevel          = 0;

        GM_CORE_ASSERT(vkCreateImageView(m_device->get(), &viewInfo, nullptr, &m_view) == VK_SUCCESS,
                       "Failed to create image view!");
    }


    void Image::transitionLayout(CommandPool* cmdPool, VkImageLayout oldLayout, VkImageLayout newLayout)
    {
        VkCommandBuffer cmdBuf              = cmdPool->beginImmediateSubmit();

        VkImageMemoryBarrier memoryBarrier  = {};
        memoryBarrier.sType                 = VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER;
        memoryBarrier.image                 = m_image;
        memoryBarrier.newLayout             = newLayout;
        memoryBarrier.oldLayout             = oldLayout;
        memoryBarrier.srcQueueFamilyIndex   = VK_QUEUE_FAMILY_IGNORED;
        memoryBarrier.dstQueueFamilyIndex   = VK_QUEUE_FAMILY_IGNORED;

        VkPipelineStageFlags srcStage;
        VkPipelineStageFlags dstStage;
        if (oldLayout == VK_IMAGE_LAYOUT_UNDEFINED && newLayout == VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL)
        {
            memoryBarrier.srcAccessMask             = 0;
            memoryBarrier.dstAccessMask             = VK_ACCESS_TRANSFER_WRITE_BIT;

            srcStage                                = VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT;
            dstStage                                = VK_PIPELINE_STAGE_TRANSFER_BIT;
        } 
        else if (oldLayout == VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL && newLayout == VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL)
        {
            memoryBarrier.srcAccessMask             = VK_ACCESS_TRANSFER_WRITE_BIT;
            memoryBarrier.dstAccessMask             = VK_ACCESS_SHADER_READ_BIT;

            srcStage                                = VK_PIPELINE_STAGE_TRANSFER_BIT;
            dstStage                                = VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT;
        } 
        else
        {
            GM_CORE_ERROR("Invalid layout transition");
        }

        vkCmdPipelineBarrier(cmdBuf, srcStage, dstStage, 0, 0, nullptr, 0, nullptr, 1, &memoryBarrier);

        cmdPool->endImmediateSubmit(cmdBuf);
    }

    Image::~Image()
    {
        vkDestroyImageView(m_device->get(), m_view, nullptr);
        vmaDestroyImage(m_allocator, m_image, m_allocation);
    }
}
