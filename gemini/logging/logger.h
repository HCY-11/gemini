#pragma once

#include "core/core.h"

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
        static inline Logger& getInstance()
        {
            static Logger l;

            return l;
        }

        template<typename T>
        inline void clientLog(LogLevel logLevel, T& args)
        {
            log(logLevel, "Application", args);
        }

        template<typename T>
        inline void coreLog(LogLevel logLevel, T& args)
        {
            log(logLevel, "Gemini", args);
        }

        Logger(const Logger&) = delete;
        void operator=(const Logger&) = delete;
        
    private:
        Logger() {}

        template<typename T>
        inline void log(LogLevel logLevel, const std::string& name, T& args)
        {
            time_t now = time(0);
            std::string date = std::string(ctime(&now));

            date.erase(date.find('\n'));

            std::cout << "[" << m_levelStr[static_cast<int>(logLevel)] << "]\t" 
                    << name << ":\t" << std::setw(50) << args
                    << "\t\t[" << date << "]" << std::endl;
        }

    private:
        std::string m_levelStr[6] = { "FATAL", "ERROR", "WARN", "INFO", "DEBUG", "TRACE" };
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