#pragma once

#include "graphics/swapchain.h"

#include "graphics/objects/image.h"

namespace gm
{
    class RenderPass
    {
    public:
        RenderPass(Device* device, Swapchain* swapchain, Image* depthImage);
        ~RenderPass();

        inline const VkRenderPass& get() const { return m_renderPass; }

    private:
        Device*             m_device            = nullptr;

        VkRenderPass        m_renderPass        = VK_NULL_HANDLE;
    };
}
