#pragma once

#include "core/core.h"
#include "core/window.h"

namespace gm
{
    class GM_API Application
    {
    public:
        Application();
        virtual ~Application();

        void run();

    protected:
        Scope<Window>   m_window                    = nullptr;
    };

    Application* createApplication();
}