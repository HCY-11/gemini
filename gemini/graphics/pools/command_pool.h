#pragma once

#include "graphics/device.h"

namespace gm
{
    class CommandPool
    {
    public:
        CommandPool(GPU* gpu, Device* device);
        ~CommandPool();

        void allocateCommandBuffers(VkCommandBufferLevel level, uint32_t count, VkCommandBuffer* dst);

        void freeCommandBuffers(uint32_t count, const VkCommandBuffer* buffers);

        VkCommandBuffer beginImmediateSubmit();

        void endImmediateSubmit(VkCommandBuffer cmdBuf);

    private:
        Device*         m_device        = nullptr;

        VkCommandPool   m_pool          = VK_NULL_HANDLE;
    };
}