#pragma once

#include "core/core.h"

#include <iostream>

namespace gm
{
    enum class LogLevel
    {
        FATAL       = 0,
        ERROR       = 1,
        WARN        = 2,
        INFO        = 3,
        DEBUG       = 4,
        TRACE       = 5
    };

    class GM_API Logger
    {
    public:
        static Logger& getInstance();

        void clientLog(LogLevel logLevel, const char* str);

        void coreLog(LogLevel logLevel, const char* str);

        Logger(const Logger&) = delete;
        void operator=(const Logger&) = delete;
        
    private:
        Logger() {}

        void log(LogLevel logLevel, const char* name, const char* str);

    private:
        const char* m_levelStr[6] = { "FATAL", "ERROR", "WARN", "INFO", "DEBUG", "TRACE" };
    };
}

#define GM_CORE_FATAL(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::FATAL, str)
#define GM_CORE_ERROR(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::ERROR, str)
#define GM_CORE_WARN(str)       ::gm::Logger::getInstance().coreLog(gm::LogLevel::WARN, str)
#define GM_CORE_INFO(str)       ::gm::Logger::getInstance().coreLog(gm::LogLevel::INFO, str)
#define GM_CORE_DEBUG(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::DEBUG, str)
#define GM_CORE_TRACE(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::TRACE, str)

#define GM_CLIENT_FATAL(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::FATAL, str)
#define GM_CLIENT_ERROR(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::ERROR, str)
#define GM_CLIENT_WARN(str)     ::gm::Logger::getInstance().clientLog(gm::LogLevel::WARN, str)
#define GM_CLIENT_INFO(str)     ::gm::Logger::getInstance().clientLog(gm::LogLevel::INFO, str)
#define GM_CLIENT_DEBUG(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::DEBUG, str)
#define GM_CLIENT_TRACE(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::TRACE, str)