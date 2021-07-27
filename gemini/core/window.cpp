#include "window.h"

namespace gm
{
    Window::Window(const char* title, uint32_t width, uint32_t height)
    {
        glfwInit();

        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
        glfwWindowHint(GLFW_RESIZABLE, GLFW_TRUE);

        m_window = glfwCreateWindow(width, height, title, nullptr, nullptr);

        GM_CORE_ASSERT(m_window != nullptr, "Failed to create GLFWwindow!");

        GM_CORE_INFO("Created window with T: \"{0}\", W: {1}, H: {2}", title, width, height);

        m_data = { title, width, height };

        glfwSetWindowUserPointer(m_window, &m_data);

        glfwSetFramebufferSizeCallback(m_window, [] (GLFWwindow* win, int w, int h) 
        {
            WindowData* data = reinterpret_cast<WindowData*>(glfwGetWindowUserPointer(win));

            data->width = w;
            data->height = h;
            data->isResized = true;

            WindowResizeEvent e(w, h);

            data->eventCallback(e);
        });

        glfwSetWindowFocusCallback(m_window, [] (GLFWwindow* win, int focused)
        {
            WindowData* data = reinterpret_cast<WindowData*>(glfwGetWindowUserPointer(win));

            if (focused)
            {
                WindowFocusEvent e;
                data->eventCallback(e);
            }
            else
            {
                WindowLoseFocusEvent e;
                data->eventCallback(e);
            }
        });

        glfwSetWindowCloseCallback(m_window, [] (GLFWwindow* win)
        {
            WindowData* data = reinterpret_cast<WindowData*>(glfwGetWindowUserPointer(win));

            WindowCloseEvent e;

            data->eventCallback(e);
        });

        glfwSetKeyCallback(m_window, [] (GLFWwindow* win, int key, int scancode, int action, int mods)
        {
            WindowData* data = reinterpret_cast<WindowData*>(glfwGetWindowUserPointer(win));

            switch (action)
            {
                case GLFW_PRESS:
                {
                    KeyPressEvent e(key, 0);
                    data->eventCallback(e);
                    break;
                }

                case GLFW_RELEASE:
                {
                    KeyReleaseEvent e(key);
                    data->eventCallback(e);
                    break;
                }

                case GLFW_REPEAT:
                {
                    KeyPressEvent e(key, 1);
                    data->eventCallback(e);
                    break;
                }
            }
        });

        glfwSetMouseButtonCallback(m_window, [] (GLFWwindow* win, int button, int action, int mods)
        {
            WindowData* data = reinterpret_cast<WindowData*>(glfwGetWindowUserPointer(win));

            switch (action)
            {
                case GLFW_PRESS:
                {
                    MouseButtonPressEvent e(button, 0);
                    data->eventCallback(e);
                    break;
                }

                case GLFW_RELEASE:
                {
                    MouseButtonReleaseEvent e(button);
                    data->eventCallback(e);
                    break;
                }

                case GLFW_REPEAT:
                {
                    MouseButtonPressEvent e(button, 1);
                    data->eventCallback(e);
                    break;
                }
            }
        });

        glfwSetCursorPosCallback(m_window, [] (GLFWwindow* win, double x, double y)
        {
            WindowData* data = reinterpret_cast<WindowData*>(glfwGetWindowUserPointer(win));

            MouseMoveEvent e(static_cast<float>(x), static_cast<float>(y));

            data->eventCallback(e);
        });

        glfwSetScrollCallback(m_window, [] (GLFWwindow* win, double xOffset, double yOffset)
        {
            WindowData* data = reinterpret_cast<WindowData*>(glfwGetWindowUserPointer(win));

            MouseScrollEvent e(static_cast<float>(xOffset), static_cast<float>(yOffset));

            data->eventCallback(e);
        });
    }

    Window::~Window()
    {
        glfwDestroyWindow(m_window);
        glfwTerminate();
    }
}