#pragma once

#include "logging/logger.h"

extern gm::Application* gm::createApplication();

int main()
{
    gm::Logger::getInstance().init();

    auto app = gm::createApplication();

    GM_CORE_INFO("Application initialized");

    app->run();
    delete app;
}