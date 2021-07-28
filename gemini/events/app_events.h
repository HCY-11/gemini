#pragma once

#include "events/event.h"

#include "graphics/meshes/mesh.h"

namespace gm
{
    class GM_API WindowResizeEvent : public Event
    {
    public:
        WindowResizeEvent(uint32_t width, uint32_t height) : m_width(width), m_height(height)
        {}

        inline std::string toString() const override
        {
            std::stringstream ss;
            ss << "WindowResizeEvent: [Width: " << m_width << ", Height: " << m_height << "]";
            return ss.str();
        }

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kWindowResize)

    private:
        uint32_t m_width, m_height;
    };

    class GM_API WindowCloseEvent : public Event
    {
    public:
        WindowCloseEvent()
        {}

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kWindowClose)
    };

    class GM_API WindowFocusEvent : public Event
    {
    public:
        WindowFocusEvent()
        {}

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kWindowFocus)
    };

    class GM_API WindowLoseFocusEvent : public Event
    {
    public:
        WindowLoseFocusEvent()
        {}

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kWindowLoseFocus)
    };

    class GM_API WindowMoveEvent : public Event
    {
    public:
        WindowMoveEvent(uint32_t x, uint32_t y) : m_x(x), m_y(y)
        {}

        inline uint32_t getX() const { return m_x; }
        inline uint32_t getY() const { return m_y; }

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kWindowMove)
    
    private:
        uint32_t m_x, m_y;
    };


    class GM_API MeshAddEvent : public Event
    {
    public:
        MeshAddEvent(const RawMeshData& rawData) : m_meshData(rawData)
        {}

        inline RawMeshData getMeshData() const { return m_meshData; }

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kAddMesh)
    
    private:
        RawMeshData m_meshData = {};
    };

    // Optional App Events

    class GM_API AppTickEvent : public Event
    {
    public:
        AppTickEvent()
        {}

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kAppTick)
    };

    class GM_API AppUpdateEvent : public Event
    {
    public:
        AppUpdateEvent()
        {}

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kAppUpdate)
    };

    class GM_API AppRenderEvent : public Event
    {
    public:
        AppRenderEvent()
        {}

        EVENT_CLASS_CATEGORY(kEventCategoryApp)
        EVENT_CLASS_TYPE(kAppRender)
    };
}
