#include <gemini/gemini.h>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        camera.position = glm::vec3(0.0f, 0.0f, 10.0f);
        light.position = glm::vec3(3.0f, 7.0f, 10.0f);

        light.intensity = 5.0f;
        light.radius = 30.0f;

        snowden->rotateX(90.0f);

        addEntity(snowden);
    }

    void onUpdate()
    {
        snowden->rotateZ(30.0f, deltaTime);
    }

private:
    gm::Entity* snowden = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}