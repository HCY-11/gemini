#include "surface.h"

#include "logging/logger.h"

namespace gm
{
    Surface::Surface(Window* window, Instance* instance) : m_instance(instance)
    {
        GM_CORE_ASSERT(glfwCreateWindowSurface(instance->get(), window->get(), nullptr, &m_surface) == VK_SUCCESS,
                        "Failed to create surface!");
    }

    Surface::~Surface()
    {
        vkDestroySurfaceKHR(m_instance->get(), m_surface, nullptr); 
    }
}
