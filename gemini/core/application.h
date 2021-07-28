#pragma once

#include "core/core.h"
#include "core/window.h"

#include "events/event.h"

#include "layers/layer_stack.h"

#include "graphics/meshes/mesh.h"

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

        void addMesh(const RawMeshData& rawData);
    
    private:
        void updateLayers();

    protected:
        Scope<Window>   m_window                    = nullptr;

        LayerStack      m_layerStack;

        bool            m_isRunning                 = true;
    };

    Application* createApplication();
}
