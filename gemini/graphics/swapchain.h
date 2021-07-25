#pragma once

#include "graphics/instance.h"
#include "core/window.h"
#include "graphics/device.h"
#include "graphics/gpu.h"
#include "graphics/deletion_queue.h"

namespace gm
{
    class Swapchain
    {
    public:
        Swapchain(Window* window, Surface* surface, GPU* gpu, Device* device);
        ~Swapchain();

        const VkSwapchainKHR& get() const { return m_swapchain; }

        VkExtent2D getExtent() const { return m_extent; }

        VkSurfaceFormatKHR getSurfaceFormat() const { return m_surfaceFormat; }

        const std::vector<VkImageView>& getImageViews() { return m_imageViews; }

    private:
        void createImageViews(Device* device);

        VkExtent2D chooseExtent(Window* window);

        VkPresentModeKHR choosePresentMode();

        VkSurfaceFormatKHR chooseSurfaceFormat();

    private:
        Device*                         m_device            = nullptr;

        VkExtent2D                      m_extent            = {};
        VkPresentModeKHR                m_presentMode;
        VkSurfaceFormatKHR              m_surfaceFormat;

        VkSwapchainKHR                  m_swapchain         = VK_NULL_HANDLE;

        SwapchainSupportInfo            m_info              = {};

        std::vector<VkImageView>        m_imageViews        = {};
    };
}
