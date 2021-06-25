#pragma once

#include "core/core.h"
#include "events/event.h"

namespace gm
{
    class GM_API Layer
    {
    public:
        Layer(const std::string& name = "Layer");
        virtual ~Layer();

        virtual void onAttach() {}

        virtual void onDetach() {}
        
        virtual void onUpdate() {}

        virtual void onEvent(Event& e) {}

    private:
        std::string m_name;
    };
}