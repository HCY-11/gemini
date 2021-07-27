#pragma once

#include "layers/layer.h"
#include "graphics/pipelines.h"

namespace gm
{
    class GraphicsLayer : public Layer
    {
    public:
        GraphicsLayer(Window* window, uint32_t framesInFlight = 3, const std::string& name = "Graphics Layer");
        ~GraphicsLayer();

        void onUpdate() override;

    private:
        void createFramebuffers();

        void createCommandPool();

        void allocateCommandBuffers();

        void createSyncObjects();

        void recreateSwapchain();

    private:
        Window* m_window                                                        = nullptr;

        Scope<Instance> m_instance                                              = nullptr;
        Scope<Surface> m_surface                                                = nullptr;
        Scope<GPU> m_gpu                                                        = nullptr;
        Scope<Device> m_device                                                  = nullptr;
        Scope<Swapchain> m_swapchain                                            = nullptr;
        Scope<RenderPass> m_renderPass                                          = nullptr;
        Scope<Pipeline> m_rasterizerPipeline                                    = nullptr;

        // TODO: Refactor and separate out pool objects and buffer objects
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