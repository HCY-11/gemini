#pragma once

#include "graphics/device.h"

namespace gm
{
    class CommandPool
    {
    public:
        CommandPool(GPU* gpu, Device* device);
        ~CommandPool();

        void allocateCommandBuffers(VkCommandBufferLevel level, std::vector<VkCommandBuffer>& dst);

        void freeCommandBuffers(const std::vector<VkCommandBuffer>& buffers);

    private:
        Device*         m_device        = nullptr;

        VkCommandPool   m_pool          = VK_NULL_HANDLE;
    };
}