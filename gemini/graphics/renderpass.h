#pragma once

#include "device.h"
#include "swapchain.h"

class RenderPass
{
public:
    RenderPass();
    ~RenderPass();

    void create(const Device& device, const Swapchain& swapchain);

    void destroy(const Device& device);

    VkRenderPass get() const { return m_renderPass; }

private:
    VkRenderPass        m_renderPass        = VK_NULL_HANDLE;
};
