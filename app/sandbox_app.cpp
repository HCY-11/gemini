#include <gemini/gemini.h>

namespace gm
{
    class SandBoxApp : public Application
    {
    public:
        SandBoxApp() {
            pushLayer(new GraphicsLayer(m_window.get()));
        }
    };

    Application* createApplication()
    {
        return new SandBoxApp();
    }
}