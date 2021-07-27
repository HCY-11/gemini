#pragma once

#include "core/core.h"
#include "layers/layer.h"

namespace gm
{
    class GM_API LayerStack
    {
    public:
        LayerStack();
        ~LayerStack();

        void pushLayer(Layer* layer);
        void pushOverlay(Layer* overlay);

        void popLayer(Layer* layer);
        void popOverlay(Layer* overlay);

        inline std::vector<Layer*>::iterator begin() { return m_layers.begin(); }
        inline std::vector<Layer*>::iterator end() { return m_layers.end(); }

    private:
        std::vector<Layer*>                 m_layers;
        std::vector<Layer*>::iterator       m_layerInsert;
    };
}