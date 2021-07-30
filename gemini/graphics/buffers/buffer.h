#pragma once

#include "core/core.h"

#include "graphics/pools/command_pool.h"

namespace gm
{
    class Buffer
    {
    public:
        Buffer() = default;
        Buffer(VmaAllocator allocator, VkDeviceSize size, VkBufferUsageFlags usage, VmaMemoryUsage memUsage);
        Buffer(VmaAllocator allocator, VkDeviceSize size, VkBufferUsageFlags usage, VmaMemoryUsage memUsage, const void* srcData);
        virtual ~Buffer();

        virtual void loadData(const void* srcData);

        void copyToBuffer(Device* device, CommandPool* cmdPool, VkBuffer src, VkBuffer dst, VkDeviceSize size);

        const VkBuffer& get() const { return m_data; }
    
    protected:
        void init(VmaAllocator allocator, VkDeviceSize size, VkBufferUsageFlags usage, VmaMemoryUsage memUsage);

    protected:
        VmaAllocator    m_allocator     = VK_NULL_HANDLE;
        VkDeviceSize    m_size          = 0;

        VmaAllocation   m_allocation    = VK_NULL_HANDLE;
        VkBuffer        m_data          = VK_NULL_HANDLE;
    };
}