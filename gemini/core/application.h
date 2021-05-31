#pragma once

#include "core.h"

namespace gm
{
    class GM_API Application
    {
    public:
        Application();
        virtual ~Application();

        void run();
    
    };

    Application* createApplication();
}