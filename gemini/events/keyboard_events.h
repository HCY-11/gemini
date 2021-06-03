#pragma once

#include "gemini/events/event.h"
#include "gemini/core/keycodes.h"

namespace gm
{
    class GM_API KeyEvent : public Event
    {
    public:
        inline KeyCode getKeyCode() const { return m_keyCode; }

        EVENT_CLASS_CATEGORY(kEventCategoryKeyboard | kEventCategoryInput)
    
    protected:
        KeyEvent(KeyCode keyCode) : m_keyCode(keyCode)
        {}

    protected:
        KeyCode m_keyCode;
    };

    class GM_API KeyPressEvent : public KeyEvent
    {
    public:
        KeyPressEvent(KeyCode keyCode, uint32_t repeatCount) : KeyEvent(keyCode), m_repeatCount(repeatCount)
        {}

        inline int getRepeatCount() const { return m_repeatCount; }

        inline std::string toString() const override
        {
            std::stringstream ss;
            ss << "KeyPressEvent: " << m_keyCode << " (" << m_repeatCount << " repeats)";
            return ss.str();
        }

        EVENT_CLASS_TYPE(kKeyPress)

    private:
        uint32_t m_repeatCount = 0;
    };


    class GM_API KeyReleaseEvent : public KeyEvent
    {
    public:
        KeyReleaseEvent(KeyCode keyCode) : KeyEvent(keyCode)
        {}

        inline std::string toString() const override
        {
            std::stringstream ss;
            ss << "KeyReleaseEvent: " << m_keyCode;
            return ss.str();
        }

        EVENT_CLASS_TYPE(kKeyRelease)
    };
}