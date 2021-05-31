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

    initEntities();

    m_renderer = std::unique_ptr<Renderer>(new Renderer(m_window, m_renderPass, m_swapchain, m_defaultPipeline, m_device, m_gpu, m_surface));
}

void IApp::loop()
{
    while (m_window.isOpen())
    {
        m_window.pollEvents();

        m_renderer->draw(m_entities);
    }
}

void IApp::cleanUp()
{
    m_renderer->destroy();

    for (const auto& entity : m_entities)
    {
        entity->mesh.vertexBuffer.destroy(m_device);
    }

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
    PipelineBuilder::addShaderStage(m_defaultPipeline.info, VK_SHADER_STAGE_VERTEX_BIT, "./gemini/shaders/shader.vert.spv");
    PipelineBuilder::addShaderStage(m_defaultPipeline.info, VK_SHADER_STAGE_FRAGMENT_BIT, "./gemini/shaders/shader.frag.spv");

    PipelineBuilder::populateStateInfosDefault(m_defaultPipeline.info, m_swapchain);

    PipelineBuilder::build(m_device, m_renderPass, m_defaultPipeline);
}

void IApp::initEntities()
{
    std::vector<Vertex> triangleVertices(3);
    triangleVertices.resize(3);

    triangleVertices[0].position = { 0.0f,-0.5f, 0.0f };
    triangleVertices[1].position = {-0.5f, 0.5f, 0.0f };
    triangleVertices[2].position = { 0.5f, 0.5f, 0.0f };

    triangleVertices[0].color = { 1.0f, 1.0f, 0.0f };
    triangleVertices[1].color = { 0.f, 1.0f, 1.0f };
    triangleVertices[2].color = { 1.f, 0.f, 1.0f };

    m_entities.push_back(std::unique_ptr<Entity>(new Entity(Mesh(m_device, triangleVertices))));
}