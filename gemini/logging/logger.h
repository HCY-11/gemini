#pragma once

#include "core/core.h"

namespace gm
{
    class GM_API Logger
    {
    public:
        static inline Logger& getInstance()
        {
            static Logger l;

            return l;
        }

        inline void init()
        {
            spdlog::set_pattern("%^[%l]\t%n: %=80v%$ [%8X]");

            m_coreLogger->set_level(spdlog::level::trace);
            m_clientLogger->set_level(spdlog::level::trace);
        }
        
        inline Reference<spdlog::logger> getCoreLogger() const { return m_coreLogger; }

        inline Reference<spdlog::logger> getClientLogger() const { return m_clientLogger; }

        Logger(const Logger&) = delete;
        void operator=(const Logger&) = delete;
        
    private:
        Logger() {}

    private:
        Reference<spdlog::logger> m_coreLogger      = spdlog::stdout_color_mt("gemini");
        Reference<spdlog::logger> m_clientLogger    = spdlog::stdout_color_mt("client");
    };
}

#define GM_CORE_FATAL(...)      ::gm::Logger::getInstance().getCoreLogger()->fatal(__VA_ARGS__)
#define GM_CORE_ERROR(...)      ::gm::Logger::getInstance().getCoreLogger()->error(__VA_ARGS__)
#define GM_CORE_WARN(...)       ::gm::Logger::getInstance().getCoreLogger()->warn(__VA_ARGS__)
#define GM_CORE_INFO(...)       ::gm::Logger::getInstance().getCoreLogger()->info(__VA_ARGS__)
#define GM_CORE_TRACE(...)      ::gm::Logger::getInstance().getCoreLogger()->trace(__VA_ARGS__)

#define GM_FATAL(...)    ::gm::Logger::getInstance().getClientLogger()->fatal(__VA_ARGS__)
#define GM_ERROR(...)    ::gm::Logger::getInstance().getClientLogger()->error(__VA_ARGS__)
#define GM_WARN(...)     ::gm::Logger::getInstance().getClientLogger()->warn(__VA_ARGS__)
#define GM_INFO(...)     ::gm::Logger::getInstance().getClientLogger()->info(__VA_ARGS__)
#define GM_TRACE(...)    ::gm::Logger::getInstance().getClientLogger()->trace(__VA_ARGS__)