#include <gemini/gemini.h>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        addEntity(snowden);

        m_camera.position = glm::vec3(0.0f, 0.0f, 10.0f);

        snowden->rotateX(90);
    }

    void onUpdate()
    {
        snowden->rotateZ(30, m_deltaTime);
    }

private:
    gm::Entity* snowden = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}