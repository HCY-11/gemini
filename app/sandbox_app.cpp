#include <gemini/gemini.h>

class ExampleLayer : public gm::Layer
{
public:
    ExampleLayer() : gm::Layer("Example")
    {}

    ~ExampleLayer()
    {}

    void onUpdate() override
    {
        //GM_INFO("ExampleLayer::onUpdate()");
    }

    void onEvent(gm::Event& e) override
    {
        GM_TRACE("Example Layer: {0}", e);
    }
};

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        pushLayer(new ExampleLayer());
        pushLayer(new gm::GraphicsLayer(m_window.get()));
    }

    ~SandBoxApp() {}
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}