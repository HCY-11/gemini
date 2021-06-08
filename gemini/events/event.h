#pragma once

#include "core/core.h"

namespace gm
{
    enum class EventType
    {
        kNone = 0,
        kWindowResize, kWindowClose, kWindowFocus, kWindowLoseFocus, kWindowMove,
        kAppTick, kAppUpdate, kAppRender,
        kKeyPress, kKeyRelease,
        kMouseButtonPress, kMouseButtonRelease, kMouseMove, kMouseScroll
    };

    enum EventCategory
    {
        kEventCategoryNone           = 0,
        kEventCategoryApp            = BIT(0),
        kEventCategoryKeyboard       = BIT(1),
        kEventCategoryInput          = BIT(2),
        kEventCategoryMouse          = BIT(3),
        kEventCategoryMouseButton    = BIT(4)
    };

#define EVENT_CLASS_TYPE(type) static inline EventType getTypeStatic() { return EventType::type; }\
                               virtual inline EventType getType() const override { return getTypeStatic(); }\
                               virtual inline const char* getName() const override { return #type; }

#define EVENT_CLASS_CATEGORY(category) virtual inline int getCategoryFlags() const override { return category; }

    class Event
    {
    public:
        virtual ~Event() = default;

        virtual inline EventType getType() const = 0;
        
        virtual inline const char* getName() const = 0;

        virtual inline int getCategoryFlags() const = 0;

        virtual inline std::string toString() const { return getName(); }

        inline bool isInCategory(EventCategory category)
        {
            return getCategoryFlags() & category;
        }

        bool isHandled = false;
    };

    class EventDispatcher
    {
    public:
        EventDispatcher(Event& event) : m_event(event)
        {}

        template<typename T, typename F>
        bool dispatch(F& func)
        {
            if (m_event.getType() == T::getTypeStatic())
            {
                m_event.isHandled |= func(static_cast<T&>(m_event));
                return true;
            }

            return false;
        }

    private:
        Event& m_event;
    };

    inline std::ostream& operator<<(std::ostream& os, const Event& e)
    {
        return os << e.toString();
    }
}