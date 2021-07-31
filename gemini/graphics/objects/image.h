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
            Device* device,
            Allocator* allocator,
            VmaMemoryUsage memUsage,
            VkMemoryPropertyFlags memFlags,
            VkImageType type, 
            VkFormat format, 
            VkSampleCountFlagBits samples, 
            VkImageTiling tiling, 
            VkImageUsageFlags usage,
            VkImageAspectFlags aspectFlags
        );

        ~Image();

        inline const VkImageView& getView() const { return m_view; }

        inline const VkFormat& getFormat() const { return m_format; }
    
    private:
        Device*             m_device        = nullptr;
        Allocator*          m_allocator     = nullptr;

        VmaAllocation       m_allocation    = VK_NULL_HANDLE;
        VkImage             m_data          = VK_NULL_HANDLE;
        VkImageView         m_view          = VK_NULL_HANDLE;
        VkFormat            m_format;
    };
}