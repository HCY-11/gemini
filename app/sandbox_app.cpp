#include <gemini/gemini.h>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        addEntity(triangle);

        m_camera.position = glm::vec3(0.0f, 0.0f, 20.0f);
    }

    void onUpdate()
    {
        triangle->rotate({ 0, 30, 0 }, m_deltaTime);
    }

private:
    gm::Entity* triangle = new gm::Entity("assets/models/monkey.obj");
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}