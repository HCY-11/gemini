#include "application.h"

#include "logging/logger.h"
#include "events/event.h"
#include "events/app_events.h"

namespace gm
{
#define BIND_EVENT_FUNC(func) std::bind(&Application::func, this, std::placeholders::_1)
 
    Application::Application()
    {
        m_window = makeScope<Window>();

        m_window->setEventCallback(BIND_EVENT_FUNC(onEvent));

        pushLayer(new GraphicsLayer(m_window.get(), m_camera));
    }

    Application::~Application()
    {

    }

    void Application::run()
    {
        while (m_isRunning)
        {
            double start = glfwGetTime();

            m_window->pollEvents();
            
            onUpdate();

            updateLayers();

            double stop = glfwGetTime();

            m_deltaTime = static_cast<float>(stop - start);
        }
    }

    void Application::onEvent(Event& e)
    {
        EventDispatcher dispatcher(e);
        dispatcher.dispatch<WindowCloseEvent, std::function<bool(Event& e)>>(BIND_EVENT_FUNC(onWindowClose));

        GM_CORE_TRACE(e);

        for (auto it = m_layerStack.end(); it != m_layerStack.begin();)
        {
            (*--it)->onEvent(e);
            if (e.isHandled)
            {
                break;
            }
        }
    }

    bool Application::onWindowClose(Event& e)
    {
        m_isRunning = false;
        return true;
    }

    void Application::pushLayer(Layer* layer)
    {
        m_layerStack.pushLayer(layer);
    }

    void Application::pushOverlay(Layer* overlay)
    {
        m_layerStack.pushOverlay(overlay);
    }

    void Application::addEntity(Entity* entity)
    {
        EntityAddEvent e(entity);

        onEvent(e);
    }

    void Application::updateLayers()
    {
        for (Layer* layer : m_layerStack)
        {
            layer->onUpdate();
        }
    }
}
