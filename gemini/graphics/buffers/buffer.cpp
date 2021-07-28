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

    void Buffer::copyToBuffer(Device* device, CommandPool* cmdPool, VkBuffer src, VkBuffer dst, VkDeviceSize size)
    {
        VkCommandBuffer cmdBuf;
        cmdPool->allocateCommandBuffers(VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1, &cmdBuf);

        VkCommandBufferBeginInfo beginInfo  = {};
        beginInfo.sType                     = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
        beginInfo.flags                     = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;

        GM_CORE_ASSERT(vkBeginCommandBuffer(cmdBuf, &beginInfo) == VK_SUCCESS, "Failed to begin command buffer!");

        VkBufferCopy region                 = {};
        region.size                         = size;

        vkCmdCopyBuffer(cmdBuf, src, dst, 1, &region);

        GM_CORE_ASSERT(vkEndCommandBuffer(cmdBuf) == VK_SUCCESS, "Failed to end command buffer!");

        VkSubmitInfo submitInfo             = {};
        submitInfo.sType                    = VK_STRUCTURE_TYPE_SUBMIT_INFO;
        submitInfo.commandBufferCount       = 1;
        submitInfo.pCommandBuffers          = &cmdBuf;

        GM_CORE_ASSERT(vkQueueSubmit(device->getGraphicsQueue(), 1, &submitInfo, VK_NULL_HANDLE) == VK_SUCCESS,
                       "Failed to submit queue!");

        // TODO: For the future, maybe use fences instead of waiting for queue idle
        // This would allow for several transfer operations to happen at once
        vkQueueWaitIdle(device->getGraphicsQueue());

        cmdPool->freeCommandBuffers(1, &cmdBuf);
    }
}