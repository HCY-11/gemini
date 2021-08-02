#include "buffer.h"

namespace gm
{
    Buffer::Buffer(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage)
    {
        init(allocator, memUsage, size, usage);
    }

    Buffer::Buffer(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage, const void* srcData) : 
        Buffer(allocator, memUsage, size, usage)
    {
        loadData(srcData);
    }

    Buffer::~Buffer()
    {
        vmaDestroyBuffer(m_allocator, m_buffer, m_allocation);
    }

    void Buffer::loadData(const void* srcData)
    {
        void* data;
        vmaMapMemory(m_allocator, m_allocation, &data);

        std::memcpy(data, srcData, m_size);

        vmaUnmapMemory(m_allocator, m_allocation);
    }

    void Buffer::copyToBuffer(CommandPool* cmdPool, VkBuffer src, VkBuffer dst, VkDeviceSize size)
    {
        VkCommandBuffer cmdBuf              = cmdPool->beginImmediateSubmit();

        VkBufferCopy region                 = {};
        region.size                         = size;

        vkCmdCopyBuffer(cmdBuf, src, dst, 1, &region);

        cmdPool->endImmediateSubmit(cmdBuf);
    }


    void Buffer::copyToImage(CommandPool* cmdPool, VkBuffer src, VkImage dst, VkImageLayout dstLayout, const VkExtent3D& extent)
    { 
        VkCommandBuffer cmdBuf                          = cmdPool->beginImmediateSubmit();

        VkBufferImageCopy region                        = {};
        region.bufferImageHeight                        = 0;
        region.bufferOffset                             = 0;
        region.bufferRowLength                          = 0;

        region.imageExtent                              = extent;
        region.imageOffset                              = { 0, 0, 0 };
        region.imageSubresource.aspectMask              = VK_IMAGE_ASPECT_COLOR_BIT;
        region.imageSubresource.layerCount              = 1;
        region.imageSubresource.baseArrayLayer          = 0;
        region.imageSubresource.mipLevel                = 0;

        vkCmdCopyBufferToImage(cmdBuf, src, dst, dstLayout, 1, &region);

        cmdPool->endImmediateSubmit(cmdBuf);
    }

    void Buffer::init(VmaAllocator allocator, VmaMemoryUsage memUsage, VkDeviceSize size, VkBufferUsageFlags usage)
    {
        m_allocator = allocator;
        m_size = size;

        VkBufferCreateInfo createInfo               = {};
        createInfo.sType                            = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
        createInfo.size                             = m_size;
        createInfo.usage                            = usage;

        VmaAllocationCreateInfo allocInfo           = {};
        allocInfo.usage                             = memUsage;

        GM_CORE_ASSERT(vmaCreateBuffer(m_allocator, &createInfo, &allocInfo, &m_buffer, &m_allocation, nullptr) == VK_SUCCESS,
                       "Failed to create buffer!");
    }
}