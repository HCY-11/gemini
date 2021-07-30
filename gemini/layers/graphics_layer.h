#pragma once

#include "layers/layer.h"

#include "graphics/pipelines.h"
#include "graphics/buffers/framebuffers.h"
#include "graphics/pools/command_pool.h"
#include "graphics/entities/entity.h"

namespace gm
{
    class GraphicsLayer : public Layer
    {
    public:
        GraphicsLayer(Window* window, uint32_t framesInFlight = 3, const std::string& name = "Graphics Layer");
        ~GraphicsLayer();

        void onUpdate() override;

        void onEvent(Event& e) override;

    private:
        void createAllocator();

        void createSyncObjects();

        void recreateSwapchain();

        void createProjectionViewMatrix();

    private:
        Window*                             m_window                            = nullptr;

        Scope<Instance>                     m_instance                          = nullptr;
        Scope<Surface>                      m_surface                           = nullptr;
        Scope<GPU>                          m_gpu                               = nullptr;
        Scope<Device>                       m_device                            = nullptr;
        Scope<Swapchain>                    m_swapchain                         = nullptr;
        Scope<RenderPass>                   m_renderPass                        = nullptr;
        Scope<Framebuffers>                 m_framebuffers                      = nullptr;
        Scope<CommandPool>                  m_commandPool                       = nullptr;

        Pipeline                            m_rasterizerPipeline                = {};
        PipelineInfo                        m_pipelineInfo                      = {};

        VmaAllocator                        m_allocator                         = VK_NULL_HANDLE;

        std::vector<VkCommandBuffer>        m_commandBuffers                    = {};

        std::vector<VkSemaphore>            m_imageAvailableSemaphores          = {};
        std::vector<VkSemaphore>            m_renderFinishedSemaphores          = {};
        std::vector<VkFence>                m_inFlightFences                    = {};
        std::vector<VkFence>                m_imagesInFlightFences              = {};

        std::vector<Entity*>                m_entities                          = {};

        uint32_t                            m_framesInFlight                    = 0;
        uint32_t                            m_currentFrame                      = 0;

        Camera                              m_camera                            = {};

        glm::mat4                           m_projectionViewMatrix              = glm::mat4(1.0f);
    };
}