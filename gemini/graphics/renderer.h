#pragma once

#include <vector>

#include "renderpass.h"
#include "pipelines.h"

class Renderer
{
public:
    Renderer(
        Window& window, 
        RenderPass& renderPass, 
        Swapchain& swapchain, 
        Pipeline& pipeline, 
        const Device& device, 
        const GPU& gpu, 
        const Surface& surface, 
        uint32_t framesInFlight = 2);

    ~Renderer();

    void draw();

private:
    void createFramebuffers();

    void createCommandPool();

    void allocateCommandBuffers();

    void createSyncObjects();

    void recreateSwapchain();

private:
    Window&                             m_window;
    RenderPass&                         m_renderPass;
    Swapchain&                          m_swapchain;
    Pipeline&                           m_pipeline;
    const GPU&                          m_gpu;
    const Surface&                      m_surface;
    const Device&                       m_device;

    std::vector<VkFramebuffer>          m_framebuffers                      = {};
    std::vector<VkCommandBuffer>        m_commandBuffers                    = {};

    VkCommandPool                       m_commandPool                       = VK_NULL_HANDLE;

    std::vector<VkSemaphore>            m_imageAvailableSemaphores          = {};
    std::vector<VkSemaphore>            m_renderFinishedSemaphores          = {};
    std::vector<VkFence>                m_inFlightFences                    = {};
    std::vector<VkFence>                m_imagesInFlightFences              = {};

    uint32_t                            m_framesInFlight                    = 0;
    uint32_t                            m_currentFrame                      = 0;
};