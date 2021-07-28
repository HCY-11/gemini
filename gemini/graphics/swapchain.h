#pragma once

#include "core/window.h"
#include "graphics/instance.h"
#include "graphics/device.h"
#include "graphics/gpu.h"

namespace gm
{
    class Swapchain
    {
    public:
        Swapchain(Window* window, Surface* surface, GPU* gpu, Device* device);
        ~Swapchain();

        inline const VkSwapchainKHR& get() const { return m_swapchain; }

        inline VkExtent2D getExtent() const { return m_extent; }

        inline VkSurfaceFormatKHR getSurfaceFormat() const { return m_surfaceFormat; }

        inline const std::vector<VkImageView>& getImageViews() const { return m_imageViews; }

    private:
        void createImageViews();

        void createFramebuffers();

        VkExtent2D chooseExtent();

        VkPresentModeKHR choosePresentMode();

        VkSurfaceFormatKHR chooseSurfaceFormat();

    private:
        Window*                         m_window            = nullptr;
        Device*                         m_device            = nullptr;

        VkExtent2D                      m_extent            = {};
        VkPresentModeKHR                m_presentMode;
        VkSurfaceFormatKHR              m_surfaceFormat;

        VkSwapchainKHR                  m_swapchain         = VK_NULL_HANDLE;

        SwapchainSupportInfo            m_info              = {};

        std::vector<VkImageView>        m_imageViews        = {};
        std::vector<VkFramebuffer>      m_framebuffers      = {};
    };
}
