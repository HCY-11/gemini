#pragma once

#include "graphics/render_pass.h"

namespace gm
{
    class Framebuffers
    {
    public:
        Framebuffers(Device* device, RenderPass* renderPass, Swapchain* swapchain, Image* depthImage, size_t size);
        ~Framebuffers();

        inline const std::vector<VkFramebuffer>& get() const { return m_data; }

    private:
        Device*                         m_device        = nullptr;

        std::vector<VkFramebuffer>      m_data          = {};
    };
}