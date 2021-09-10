#pragma once

#include "logging/logger.h"

extern gm::Application* gm::createApplication();

int main()
{
    gm::Logger::getInstance().init();

    GM_CORE_TRACE("Gemini initialized");

    auto app = gm::createApplication();

    GM_CORE_INFO("Application initialized");

    app->run();
    delete app;

    return EXIT_SUCCESS;
}