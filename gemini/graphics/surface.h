#pragma once

#include "instance.h"
#include "core/window.h"

namespace gm
{
    class Surface
    {
    public:
        Surface(Window* window, Instance* instance);
        ~Surface();

        inline VkSurfaceKHR get() const { return m_surface; }

    private:
        Instance*           m_instance          = nullptr;

        VkSurfaceKHR        m_surface           = VK_NULL_HANDLE;
    };
}
