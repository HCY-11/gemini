#include "command_pool.h"

namespace gm
{
    CommandPool::CommandPool(GPU* gpu, Device* device) : m_device(device)
    {
        VkCommandPoolCreateInfo poolInfo        = {};
        poolInfo.sType                          = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
        poolInfo.queueFamilyIndex               = gpu->getQueueFamilyIndices().graphics.value();
        poolInfo.flags                          = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT |
                                                  VK_COMMAND_POOL_CREATE_TRANSIENT_BIT;

        GM_CORE_ASSERT(vkCreateCommandPool(m_device->get(), &poolInfo, nullptr, &m_pool) == VK_SUCCESS,
                        "Failed to create command pool!");
    }

    CommandPool::~CommandPool()
    {
        vkDestroyCommandPool(m_device->get(), m_pool, nullptr);
    }

    void CommandPool::allocateCommandBuffers(VkCommandBufferLevel level, uint32_t count, VkCommandBuffer* dst)
    {
        VkCommandBufferAllocateInfo allocInfo           = {};
        allocInfo.sType                                 = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
        allocInfo.commandPool                           = m_pool;
        allocInfo.commandBufferCount                    = count;
        allocInfo.level                                 = VK_COMMAND_BUFFER_LEVEL_PRIMARY;

        GM_CORE_ASSERT(vkAllocateCommandBuffers(m_device->get(), &allocInfo, dst) == VK_SUCCESS,
                        "Failed to allocate command buffers!");
    }

    void CommandPool::freeCommandBuffers(uint32_t count, const VkCommandBuffer* buffers)
    {
        vkFreeCommandBuffers(m_device->get(), m_pool, count, buffers);
    }

    VkCommandBuffer CommandPool::beginImmediateSubmit()
    {
        VkCommandBuffer cmdBuf;
        allocateCommandBuffers(VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1, &cmdBuf);

        VkCommandBufferBeginInfo beginInfo  = {};
        beginInfo.sType                     = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
        beginInfo.flags                     = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;

        GM_CORE_ASSERT(vkBeginCommandBuffer(cmdBuf, &beginInfo) == VK_SUCCESS, "Failed to begin command buffer!");

        return cmdBuf;
    }

    void CommandPool::endImmediateSubmit(VkCommandBuffer cmdBuf)
    {
        GM_CORE_ASSERT(vkEndCommandBuffer(cmdBuf) == VK_SUCCESS, "Failed to end command buffer!");

        VkSubmitInfo submitInfo             = {};
        submitInfo.sType                    = VK_STRUCTURE_TYPE_SUBMIT_INFO;
        submitInfo.commandBufferCount       = 1;
        submitInfo.pCommandBuffers          = &cmdBuf;

        GM_CORE_ASSERT(vkQueueSubmit(m_device->getGraphicsQueue(), 1, &submitInfo, VK_NULL_HANDLE) == VK_SUCCESS,
                       "Failed to submit queue!");

        // TODO: For the future, maybe use fences instead of waiting for queue idle
        // This would allow for several transfer operations to happen at once
        vkQueueWaitIdle(m_device->getGraphicsQueue());

        freeCommandBuffers(1, &cmdBuf);
    }
}