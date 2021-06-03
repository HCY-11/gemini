#pragma once

#include "gemini/events/event.h"

namespace gm
{
    class MouseButtonPressEvent : public Event
    {
    };

    class MouseButtonReleaseEvent : public Event
    {

    };

    class MouseMoveEvent : public Event
    {
    public:
        MouseMoveEvent(float mouseX, float mouseY) : m_mouseX(mouseX), m_mouseY(mouseY)
        {}

        inline float getMouseX() const { return m_mouseX; }
        inline float getMouseY() const { return m_mouseY; }

        inline std::string toString() const override
        {
            std::stringstream ss;
            ss << "MouseMoveEvent: [X: " << m_mouseX << ", Y: " << m_mouseY << "]";
            return ss.str();
        }

        EVENT_CLASS_CATEGORY(kEventCategoryMouse | kEventCategoryInput)
        EVENT_CLASS_TYPE(kMouseMove)

    private:
        float m_mouseX, m_mouseY;
    };

    class MouseScrollEvent : public Event
    {
    public:
        MouseScrollEvent(float scrollX, float scrollY) : m_scrollX(scrollX), m_scrollY(scrollY)
        {}

        inline float getScrollX() const { return m_scrollX; }
        inline float getScrollY() const { return m_scrollY; }

        inline std::string toString() const override
        {
            std::stringstream ss;
            ss << "MouseScrolEvent: [X: " << m_scrollX << ", Y: " << m_scrollY << "]";
            return ss.str();
        }

        EVENT_CLASS_CATEGORY(kEventCategoryMouse | kEventCategoryInput)
        EVENT_CLASS_TYPE(kMouseScroll)

    private:
        float m_scrollX, m_scrollY;
    };
}