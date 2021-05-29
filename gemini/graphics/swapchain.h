#pragma once

#include "instance.h"
#include "core/window.h"
#include "device.h"
#include "gpu.h"

class Swapchain
{
public:
    Swapchain();
    ~Swapchain();

    void create(const Window& window, const Surface& surface, const GPU& gpu, const Device& device);

    void destroy(const Device& device);

    const VkSwapchainKHR& get() const { return m_swapchain; }

    VkExtent2D getExtent() const { return m_extent; }

    VkSurfaceFormatKHR getSurfaceFormat() const { return m_surfaceFormat; }

    const std::vector<VkImageView>& getImageViews() { return m_imageViews; }

private:
    void createImageViews(const Device& device);

    VkExtent2D chooseExtent(const Window& window);

    VkPresentModeKHR choosePresentMode();

    VkSurfaceFormatKHR chooseSurfaceFormat();

private:
    VkExtent2D                      m_extent            = {};
    VkPresentModeKHR                m_presentMode;
    VkSurfaceFormatKHR              m_surfaceFormat;

    VkSwapchainKHR                  m_swapchain         = VK_NULL_HANDLE;

    SwapchainSupportInfo            m_info              = {};

    std::vector<VkImageView>        m_imageViews        = {};
};