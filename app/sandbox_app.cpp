#include <gemini/gemini.h>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {}
    ~SandBoxApp() {}
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}