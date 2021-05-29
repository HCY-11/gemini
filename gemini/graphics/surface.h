#pragma once

#include "instance.h"
#include "core/window.h"

class Surface
{
public:
    Surface();
    ~Surface();

    void create(const Window& window, const Instance& instance);

    void destroy(const Instance& instance);
    
    VkSurfaceKHR get() const { return m_surface; }

private:
    VkSurfaceKHR        m_surface           = VK_NULL_HANDLE;
};