#include "buffer.h"

namespace gm
{
    Buffer::Buffer(VmaAllocator allocator, VkDeviceSize size, VkBufferUsageFlags usage, VmaMemoryUsage memUsage) : 
        m_allocator(allocator), m_size(size)
    {
        VkBufferCreateInfo createInfo               = {};
        createInfo.sType                            = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
        createInfo.size                             = m_size;
        createInfo.usage                            = usage;

        VmaAllocationCreateInfo allocInfo           = {};
        allocInfo.usage                             = memUsage;

        GM_CORE_ASSERT(vmaCreateBuffer(m_allocator, &createInfo, &allocInfo, &m_data, &m_allocation, nullptr) == VK_SUCCESS,
                       "Failed to create buffer!");
    }

    Buffer::Buffer(VmaAllocator allocator, VkDeviceSize size, VkBufferUsageFlags usage, VmaMemoryUsage memUsage, const void* srcData) : 
        Buffer(allocator, size, usage, memUsage)
    {
        loadData(srcData);
    }

    Buffer::~Buffer()
    {
        vmaDestroyBuffer(m_allocator, m_data, m_allocation);
    }

    void Buffer::loadData(const void* srcData)
    {
        void* data;
        vmaMapMemory(m_allocator, m_allocation, &data);

        std::memcpy(data, srcData, m_size);

        vmaUnmapMemory(m_allocator, m_allocation);
    }
}