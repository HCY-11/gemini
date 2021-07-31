#pragma once

#include "core/core.h"

#include "graphics/pools/command_pool.h"

#include "graphics/allocator.h"

namespace gm
{
    class Buffer
    {
    public:
        Buffer() = default;
        Buffer(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage);
        Buffer(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage, const void* srcData);
        virtual ~Buffer();

        virtual void loadData(const void* srcData);

        void copyToBuffer(Device* device, CommandPool* cmdPool, VkBuffer src, VkBuffer dst, VkDeviceSize size);

        const VkBuffer& get() const { return m_data; }
    
    protected:
        void init(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage);

    protected:
        VmaAllocator    m_allocator     = nullptr;
        VkDeviceSize    m_size          = 0;

        VmaAllocation   m_allocation    = VK_NULL_HANDLE;
        VkBuffer        m_data          = VK_NULL_HANDLE;
    };
}