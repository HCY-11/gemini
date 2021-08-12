#pragma once

#include "layers/layer.h"

#include "graphics/pipeline.h"
#include "graphics/images/depth_image.h"
#include "graphics/buffers/framebuffers.h"
#include "graphics/command_pool.h"
#include "graphics/entities/render_object.h"
#include "graphics/entities/push_constant.h"
#include "graphics/entities/light.h"

namespace gm
{
    class GraphicsLayer : public Layer
    {
    public:
        GraphicsLayer(Window* window, Camera& camera, Light& light, uint32_t framesInFlight = 3, const std::string& name = "Graphics Layer");
        ~GraphicsLayer();

        void onUpdate() override;

        void onEvent(Event& e) override;

    private:
        void buildGraphicsPipeline();

        void createAllocator();

        void createSyncObjects();

        void recreateSwapchain();

    private:
        Window*                             m_window                            = nullptr;

        Scope<Instance>                     m_instance                          = nullptr;
        Scope<Surface>                      m_surface                           = nullptr;
        Scope<GPU>                          m_gpu                               = nullptr;
        Scope<Device>                       m_device                            = nullptr;
        Scope<Swapchain>                    m_swapchain                         = nullptr;
        Scope<RenderPass>                   m_renderPass                        = nullptr;
        Scope<Pipeline>                     m_graphicsPipeline                  = nullptr;
        Scope<Framebuffers>                 m_framebuffers                      = nullptr;
        Scope<CommandPool>                  m_commandPool                       = nullptr;

        DepthImage*                         m_depthImage                        = nullptr;

        VmaAllocator                        m_allocator                         = VK_NULL_HANDLE;

        std::vector<VkCommandBuffer>        m_commandBuffers                    = {};

        std::vector<VkSemaphore>            m_imageAvailableSemaphores          = {};
        std::vector<VkSemaphore>            m_renderFinishedSemaphores          = {};
        std::vector<VkFence>                m_inFlightFences                    = {};
        std::vector<VkFence>                m_imagesInFlightFences              = {};

        std::vector<RenderObject*>          m_renderObjects                     = {};

        uint32_t                            m_framesInFlight                    = 0;
        uint32_t                            m_currentFrame                      = 0;

        Camera&                             m_camera;
        Light&                              m_light;

        glm::mat4                           m_projectionViewMatrix              = glm::mat4(1.0f);
    };
}