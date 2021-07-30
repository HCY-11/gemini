#pragma once

#include "core/core.h"
#include "core/window.h"

#include "events/event.h"

#include "layers/layer_stack.h"

#include "graphics/entities/entity.h"

namespace gm
{
    class GM_API Application
    {
    public:
        Application();
        virtual ~Application();

        void run();

        bool onWindowClose(Event& e);

        virtual void onUpdate() = 0;
    
    private:
        void onEvent(Event& e);

        void updateLayers();

    protected:
        void pushLayer(Layer* layer);

        void pushOverlay(Layer* overlay);

        void addEntity(Entity* entity);

    protected:
        Scope<Window>   m_window                    = nullptr;

        LayerStack      m_layerStack;

        bool            m_isRunning                 = true;

        float           m_deltaTime;
    };

    Application* createApplication();
}
