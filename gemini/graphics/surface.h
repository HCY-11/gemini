#pragma once

#include "core/window.h"
#include "graphics/instance.h"

namespace gm
{
    class Surface
    {
    public:
        Surface(Window* window, Instance* instance);
        ~Surface();

        inline const VkSurfaceKHR& get() const { return m_surface; }

    private:
        Instance*           m_instance          = nullptr;

        VkSurfaceKHR        m_surface           = VK_NULL_HANDLE;
    };
}
