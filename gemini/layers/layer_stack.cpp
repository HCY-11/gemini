#include "layer_stack.h"

namespace gm
{
    LayerStack::LayerStack()
    {

    }

    LayerStack::~LayerStack()
    {
        for (auto it = m_layers.begin(); it != m_layers.end(); it++)
        {
            delete *it;
        }
    }

    void LayerStack::pushLayer(Layer* layer)
    {
        m_layerInsert = m_layers.emplace(m_layerInsert, layer);
        layer->onAttach();
    }

    void LayerStack::pushOverlay(Layer* overlay)
    {
        m_layers.emplace_back(overlay);
        overlay->onAttach();
    }

    void LayerStack::popLayer(Layer* layer)
    {
        auto it = std::find(m_layers.begin(), m_layers.end(), layer);

        if (it != m_layers.end())
        {
            m_layers.erase(it);
            m_layerInsert--;
        }

        layer->onDetach();
    }

    void LayerStack::popOverlay(Layer* overlay)
    {
        auto it = std::find(m_layers.begin(), m_layers.end(), overlay);

        if (it != m_layers.end())
        {
            m_layers.erase(it);
        }

        overlay->onDetach();
    }

}