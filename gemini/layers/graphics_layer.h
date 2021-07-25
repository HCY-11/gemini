#pragma once

#include "layers/layer.h"
#include "graphics/renderer.h"
#include "graphics/deletion_queue.h"

namespace gm
{

    // TODO: Move Renderer class into GraphicsLayer class
    class GraphicsLayer : public Layer
    {
    public:
        GraphicsLayer(Window* window, const std::string& name = "Graphics Layer");
        ~GraphicsLayer() = default;

        void onUpdate() override;

        void onDetach() override;

    private:
        Scope<Instance> m_instance = nullptr;
        Scope<Surface> m_surface = nullptr;
        Scope<GPU> m_gpu = nullptr;
        Scope<Device> m_device = nullptr;
        Scope<Swapchain> m_swapchain = nullptr;
        Scope<RenderPass> m_renderPass = nullptr;
        Scope<Renderer> m_renderer = nullptr;

        Pipeline m_rasterizerPipeline;

        DeletionQueue m_deletionQueue;
    };
}