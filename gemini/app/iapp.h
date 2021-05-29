#pragma once

#include "core/core.h"
#include "graphics/graphics.h"
#include "util/util.h"

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

protected:
    Window                      m_window;
    Instance                    m_instance;
    Surface                     m_surface;
    GPU                         m_gpu;
    Device                      m_device;
    Swapchain                   m_swapchain;
    RenderPass                  m_renderPass;
    Pipeline                    m_defaultPipeline;

    Renderer*                   m_renderer          = nullptr;
};