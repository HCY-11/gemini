#pragma once

#include "core/core.h"

#include "graphics/command_pool.h"

#include "graphics/images/image.h"

namespace gm
{
    class Buffer
    {
    public:
        Buffer() = default;
        Buffer(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage);
        Buffer(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage, const void* srcData);
        virtual ~Buffer();

        virtual void loadGenericData(const void* srcData);

        void copyToBuffer(CommandPool* cmdPool, VkBuffer dst, VkDeviceSize size);

        void copyToImage(CommandPool* cmdPool, VkImage dst, VkImageLayout dstLayout, const VkExtent3D& extent);

        const VkBuffer& get() const { return m_buffer; }

        const VkDeviceSize& getSize() const { return m_size; }
    
    protected:
        void init(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage);

    protected:
        VmaAllocator    m_allocator     = nullptr;
        VkDeviceSize    m_size          = 0;

        VmaAllocation   m_allocation    = VK_NULL_HANDLE;
        VkBuffer        m_buffer          = VK_NULL_HANDLE;
    };
}