#pragma once

#include "graphics/render_pass.h"
#include "graphics/pipelines.h"
#include "graphics/deletion_queue.h"

namespace gm
{
    class Renderer
    {
    public:
        Renderer(
            Window* window, 
            RenderPass* renderPass,
            Swapchain* swapchain,
            Pipeline* pipeline,
            Device* device,
            GPU* gpu,
            Surface* surface,
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
        Window*                             m_window                            = nullptr;
        RenderPass*                         m_renderPass                        = nullptr;
        Swapchain*                          m_swapchain                         = nullptr;
        Pipeline*                           m_pipeline                          = nullptr;
        GPU*                                m_gpu                               = nullptr;
        Surface*                            m_surface                           = nullptr;
        Device*                             m_device                            = nullptr;

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
}
