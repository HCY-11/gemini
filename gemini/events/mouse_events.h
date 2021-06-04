#pragma once

#include "events/event.h"
#include "core/mousecodes.h"

namespace gm
{
    class GM_API MouseButtonEvent : public Event
    {
    public:
        inline MouseCode getMouseCode() const { return m_mouseCode; }

        EVENT_CLASS_CATEGORY(kEventCategoryMouse | kEventCategoryMouseButton | kEventCategoryInput)

    protected:
        MouseButtonEvent(MouseCode mouseCode) : m_mouseCode(mouseCode)
        {}

    protected:
        int m_mouseCode;
    };

    class GM_API MouseButtonPressEvent : public MouseButtonEvent
    {
    public:
        MouseButtonPressEvent(MouseCode mouseCode, uint16_t repeatCount) : MouseButtonEvent(mouseCode), m_repeatCount(repeatCount)
        {}

        inline uint16_t getRepeatCount() const { return m_repeatCount; }

        inline std::string toString() const override
        {
            std::stringstream ss;
            ss << "MouseButtonPressEvent: " << m_mouseCode << " [" << m_repeatCount << " repeats]";
            return ss.str();
        }

        EVENT_CLASS_TYPE(kMouseButtonPress)
    
    private:
        int m_repeatCount;
    };

    class GM_API MouseButtonReleaseEvent : public MouseButtonEvent
    {
    public:
        MouseButtonReleaseEvent(MouseCode mouseCode) : MouseButtonEvent(mouseCode)
        {}

        inline std::string toString() const override
        {
            std::stringstream ss;
            ss << "MouseButtonPressEvent: " << m_mouseCode;
            return ss.str();
        }

        EVENT_CLASS_TYPE(kMouseButtonRelease)
    };

    class GM_API MouseMoveEvent : public Event
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

    class GM_API MouseScrollEvent : public Event
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