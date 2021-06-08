#include "window.h"

namespace gm
{
    Window::Window(const char* title, uint32_t width, uint32_t height)
    {
        glfwInit();

        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

        m_window = glfwCreateWindow(width, height, title, nullptr, nullptr);

        GM_CORE_ASSERT(m_window != nullptr, "Failed to create GLFWwindow!");

        GM_CORE_INFO("Created window with T: \"{0}\", W: {1}, H: {2}", title, width, height);

        m_data = { title, width, height };

        glfwSetWindowUserPointer(m_window, &m_data);
    }

    Window::~Window()
    {
        glfwDestroyWindow(m_window);
        glfwTerminate();
    }
}