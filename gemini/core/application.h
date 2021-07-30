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

        void onEvent(Event& e);

        bool onWindowClose(Event& e);

        void pushLayer(Layer* layer);

        void pushOverlay(Layer* overlay);

        void addEntity(Entity* entity);
    
    private:
        void updateLayers();

    protected:
        Scope<Window>   m_window                    = nullptr;

        LayerStack      m_layerStack;

        bool            m_isRunning                 = true;
    };

    Application* createApplication();
}
