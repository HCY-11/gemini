#pragma once

#include <GLFW/glfw3.h>

class Window
{
public:
    Window();
    ~Window();

    void create(const char* title, int width, int height);

    void destroy();

    inline bool isOpen() const { return !glfwWindowShouldClose(m_window); }

    inline void pollEvents() const { glfwPollEvents(); }

    inline void setIsResized(bool isResized) { m_isResized = isResized; }

    inline bool isResized() const { return m_isResized; }

    GLFWwindow* get() const { return m_window; }

private:
    GLFWwindow*     m_window        = nullptr;

    bool            m_isResized       = false;
};