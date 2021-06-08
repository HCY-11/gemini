#pragma once

#include "logging/logger.h"
#include "core/core.h"

namespace gm
{
    struct WindowData
    {
        const char* title;
        uint32_t width;
        uint32_t height;

        WindowData(const char* inTitle, uint32_t inWidth, uint32_t inHeight) :
                    title(inTitle), width(inWidth), height(inHeight)
        {}

        WindowData() {}
    };

    class Window
    {
    public:
        Window(const char* title = "Gemini Application", 
               uint32_t width = 1000, 
               uint32_t height = 800);
        ~Window();

        inline bool isOpen() const { return !glfwWindowShouldClose(m_window); }

        inline void pollEvents() { glfwPollEvents(); }

    private:
        GLFWwindow*         m_window    = nullptr;

        WindowData          m_data      = {};
    };
}