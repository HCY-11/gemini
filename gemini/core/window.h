#pragma once

#include "logging/logger.h"
#include "core/core.h"

#include "events/event.h"
#include "graphics/entities/camera.h"

namespace gm
{
    struct WindowData
    {
        using EventCallbackFunc = std::function<void(Event&)>;

        const char* title;
        uint32_t width;
        uint32_t height;
        bool isResized;
        EventCallbackFunc eventCallback;

        WindowData(const char* inTitle, uint32_t inWidth, uint32_t inHeight) :
                    title(inTitle), width(inWidth), height(inHeight)
        {}

        WindowData() {}
    };

    class Window
    {
    public:
        using EventCallbackFunc = std::function<void(Event&)>;

        Window(const char* title = "Gemini Application", 
               uint32_t width = 1000, 
               uint32_t height = 800);
        ~Window();

        inline bool isOpen() const { return !glfwWindowShouldClose(m_window); }

        inline void pollEvents() { glfwPollEvents(); }

        inline void setEventCallback(const EventCallbackFunc& func) { m_data.eventCallback = func; }

        inline bool isResized() const { return m_data.isResized; }

        inline void setIsResized(bool isResized) { m_data.isResized = isResized; }

        inline GLFWwindow* get() const { return m_window; }

    private:
        GLFWwindow*     m_window                = nullptr;

        WindowData      m_data                  = {};
    };
}
