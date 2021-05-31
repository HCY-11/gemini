#pragma once

#include "core/core.h"
#include "graphics/graphics.h"
#include "util/util.h"
#include "entity/entity.h"

#include <memory>

class IApp
{
public:
    IApp();
    ~IApp();

    virtual void init(const char* appName, int width, int height);

    virtual void loop();

    virtual void cleanUp();

protected:
    virtual void buildPipelines();

    virtual void initEntities();

protected:
    Window                                  m_window;
    Instance                                m_instance;
    Surface                                 m_surface;
    GPU                                     m_gpu;
    Device                                  m_device;
    Swapchain                               m_swapchain;
    RenderPass                              m_renderPass;
    Pipeline                                m_defaultPipeline;

    std::unique_ptr<Renderer>               m_renderer;
    std::vector<std::unique_ptr<Entity>>    m_entities;
};