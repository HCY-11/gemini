#pragma once

#include "graphics/device.h"
#include "graphics/swapchain.h"

namespace gm
{
    class RenderPass
    {
    public:
        RenderPass(Device* device, Swapchain* swapchain);
        ~RenderPass();

        inline const VkRenderPass& get() const { return m_renderPass; }

    private:
        Device*             m_device            = nullptr;

        VkRenderPass        m_renderPass        = VK_NULL_HANDLE;
    };
}
