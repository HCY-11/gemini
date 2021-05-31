#include "logger.h"

namespace gm
{
    Logger& Logger::getInstance()
    {
        static Logger l;

        return l;
    }

    void Logger::clientLog(LogLevel logLevel, const char* str)
    {
        log(logLevel, "Application", str);
    }

    void Logger::coreLog(LogLevel logLevel, const char* str)
    {
        log(logLevel, "Gemini", str);
    }

    void Logger::log(LogLevel logLevel, const char* name, const char* str)
    {
        time_t now = time(0);
        std::string date = std::string(ctime(&now));

        date.erase(date.find('\n'));

        std::cout << "[" << m_levelStr[static_cast<int>(logLevel)] << "]" 
                  << name << ":\t" << str 
                  << "\t [" << date << "]" << std::endl;
    }

}