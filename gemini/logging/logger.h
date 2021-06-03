#pragma once

#include "core/core.h"

#include <iostream>

namespace gm
{
    enum class GM_API LogLevel
    {
        kFatal,
        kError,
        kWarn,
        kInfo,
        kDebug,
        kTrace
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

#define GM_CORE_FATAL(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::kFatal, str)
#define GM_CORE_ERROR(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::kError, str)
#define GM_CORE_WARN(str)       ::gm::Logger::getInstance().coreLog(gm::LogLevel::kWarn, str)
#define GM_CORE_INFO(str)       ::gm::Logger::getInstance().coreLog(gm::LogLevel::kInfo, str)
#define GM_CORE_DEBUG(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::kDebug, str)
#define GM_CORE_TRACE(str)      ::gm::Logger::getInstance().coreLog(gm::LogLevel::kTrace, str)

#define GM_CLIENT_FATAL(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::kFatal, str)
#define GM_CLIENT_ERROR(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::kError, str)
#define GM_CLIENT_WARN(str)     ::gm::Logger::getInstance().clientLog(gm::LogLevel::kWarn, str)
#define GM_CLIENT_INFO(str)     ::gm::Logger::getInstance().clientLog(gm::LogLevel::kInfo, str)
#define GM_CLIENT_DEBUG(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::kDebug, str)
#define GM_CLIENT_TRACE(str)    ::gm::Logger::getInstance().clientLog(gm::LogLevel::kTrace, str)