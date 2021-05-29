#include "window.h"
#include "util/util.h"
#include "util/callbacks.h"

Window::Window()
{
}

Window::~Window()
{
}

void Window::create(const char* title, int width, int height)
{
    glfwInit();

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);

    m_window = glfwCreateWindow(width, height, title, nullptr, nullptr);

    if (m_window == nullptr)
    {
        LOG("Failed to create GLFW window!");
    }

    glfwSetWindowUserPointer(m_window, this);
    glfwSetFramebufferSizeCallback(m_window, framebufferResizedCallback);
}

void Window::destroy()
{
    glfwDestroyWindow(m_window);
    glfwTerminate();
}