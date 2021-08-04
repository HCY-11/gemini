#include <gemini/gemini.h>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        addEntity(monkey);

        m_camera.position = glm::vec3(0.0f, 0.0f, 20.0f);
    }

    void onUpdate()
    {
        monkey->rotate({ 0, 30, 0 }, m_deltaTime);
    }

private:
    gm::Entity* monkey = new gm::Entity("assets/models/monkey.obj", "assets/materials/marble/texture.jpg");
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}