#include "application.h"

#include "logging/logger.h"
#include "events/event.h"
#include "events/app_events.h"

namespace gm
{
    Application::Application()
    {

    }

    Application::~Application()
    {

    }

    void Application::run()
    {
        WindowResizeEvent e(800, 600);

        GM_CORE_TRACE(e);

        while (true);
    }
}