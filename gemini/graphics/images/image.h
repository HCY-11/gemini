#pragma once

#include "core/core.h"

#include "graphics/allocator.h"

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

        virtual ~Image();

        inline const VkImageView& getView() const { return m_view; }

        inline const VkFormat& getFormat() const { return m_format; }
    
    private:
        Device*             m_device        = nullptr;
        VmaAllocator        m_allocator     = VK_NULL_HANDLE;

        VmaAllocation       m_allocation    = VK_NULL_HANDLE;
        VkImage             m_data          = VK_NULL_HANDLE;
        VkImageView         m_view          = VK_NULL_HANDLE;
        VkFormat            m_format;
    };
}