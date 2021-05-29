#include "iapp.h"

IApp::IApp()
{

}

IApp::~IApp()
{

}

void IApp::init(const char* appName, int width, int height)
{
    m_window.create(appName, width, height);

    m_instance.create();

    m_surface.create(m_window, m_instance);

    m_gpu.find(m_instance, m_surface);

    m_device.create(m_instance, m_gpu);

    m_swapchain.create(m_window, m_surface, m_gpu, m_device);

    m_renderPass.create(m_device, m_swapchain);

    buildPipelines();

    m_renderer = new Renderer(m_window, m_renderPass, m_swapchain, m_defaultPipeline, m_device, m_gpu, m_surface);
}

void IApp::loop()
{
    while (m_window.isOpen())
    {
        m_window.pollEvents();

        m_renderer->draw();
    }
}

void IApp::cleanUp()
{
    delete m_renderer;

    m_renderPass.destroy(m_device);

    m_defaultPipeline.destroy(m_device);

    m_swapchain.destroy(m_device);

    m_device.destroy();

    m_surface.destroy(m_instance);

    m_instance.destroy();

    m_window.destroy();
}

void IApp::buildPipelines()
{
    PipelineBuilder::addShaderStage(m_defaultPipeline.info, VK_SHADER_STAGE_VERTEX_BIT, "./gemini/shaders/vert.spv");
    PipelineBuilder::addShaderStage(m_defaultPipeline.info, VK_SHADER_STAGE_FRAGMENT_BIT, "./gemini/shaders/frag.spv");

    PipelineBuilder::populateStateInfosDefault(m_defaultPipeline.info, m_swapchain);

    PipelineBuilder::build(m_device, m_renderPass, m_defaultPipeline);
}