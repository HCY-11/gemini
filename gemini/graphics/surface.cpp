#include "surface.h"

#include "util/util.h"

Surface::Surface()
{

}

Surface::~Surface()
{

}

void Surface::create(const Window& window, const Instance& instance)
{
    CHECK_VK_RESULT(glfwCreateWindowSurface(instance.get(), window.get(), nullptr, &m_surface),
                    "Failed to create surface!");
}

void Surface::destroy(const Instance& instance)
{
    vkDestroySurfaceKHR(instance.get(), m_surface, nullptr);
}