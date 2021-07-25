#include "graphics_layer.h"

namespace gm
{
    GraphicsLayer::GraphicsLayer(Window* window, const std::string& name) :
        Layer(name),
        m_instance(makeScope<Instance>()), 
        m_surface(makeScope<Surface>(window, m_instance.get())), 
        m_gpu(makeScope<GPU>(m_instance.get(), m_surface.get())),
        m_device(makeScope<Device>(m_instance.get(), m_gpu.get())),
        m_swapchain(makeScope<Swapchain>(window, m_surface.get(), m_gpu.get(), m_device.get())),
        m_renderPass(makeScope<RenderPass>(m_device.get(), m_swapchain.get())),
        m_renderer(makeScope<Renderer>(window, 
                                       m_renderPass.get(), 
                                       m_swapchain.get(), 
                                       &m_rasterizerPipeline, 
                                       m_device.get(), 
                                       m_gpu.get(),
                                       m_surface.get()))
    {
        PipelineBuilder::addShaderStage(&m_rasterizerPipeline.info, VK_SHADER_STAGE_VERTEX_BIT, "/home/henry/workspace/gemini/gemini/graphics/shaders/vert.spv");
        PipelineBuilder::addShaderStage(&m_rasterizerPipeline.info, VK_SHADER_STAGE_FRAGMENT_BIT, "/home/henry/workspace/gemini/gemini/graphics/shaders/frag.spv");

        PipelineBuilder::populateStateInfosDefault(&m_rasterizerPipeline.info, m_swapchain.get());

        PipelineBuilder::build(m_device.get(), m_renderPass.get(), &m_rasterizerPipeline);
    }

    void GraphicsLayer::onUpdate()
    {
        m_renderer->draw();
    }

    void GraphicsLayer::onDetach()
    {
        vkDeviceWaitIdle(m_device->get());
    }
}