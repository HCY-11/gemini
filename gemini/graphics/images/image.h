#pragma once

#include "core/core.h"

namespace gm
{
    class Image
    {
    public:
        Image() = default;
        Image(
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
            VkImageAspectFlags aspectFlags
        );

        void init(
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
        );

        void transitionLayout(CommandPool* cmdPool, VkImageLayout newLayout);

        virtual ~Image();

        inline const VkImageView& getView() const { return m_view; }

        inline const VkFormat& getFormat() const { return m_format; }

        inline const VkImageLayout& getLayout() const { return m_layout; }
    
    protected:
        Device*             m_device        = nullptr;
        VmaAllocator        m_allocator     = VK_NULL_HANDLE;

        VmaAllocation       m_allocation    = VK_NULL_HANDLE;
        VkImage             m_image         = VK_NULL_HANDLE;
        VkImageView         m_view          = VK_NULL_HANDLE;
        VkFormat            m_format;
        VkImageLayout       m_layout        = VK_IMAGE_LAYOUT_UNDEFINED;
        VkImageAspectFlags  m_aspectMask;
    };
}