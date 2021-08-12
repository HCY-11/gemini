#include <gemini/gemini.h>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        camera.position = glm::vec3(0.0f, 0.0f, 15.0f);
        light.position = glm::vec3(3.0f, 7.0f, 10.0f);

        light.intensity = 5.0f;

        monkey->translateX(-2.0f);
        monkey2->translateZ(4.0f);

        snowden->translateX(2.0f);
        snowden->rotateX(90.0f);

        addEntity(snowden);
        addEntity(monkey2);
        addEntity(monkey);
    }

    void onUpdate()
    {
        snowden->rotateZ(30.0f, deltaTime);
        monkey->rotateY(30.0f, deltaTime);
        monkey2->rotateY(120.0f, deltaTime);
    }

private:
    gm::Entity* snowden = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
    gm::Entity* monkey = new gm::Entity("assets/models/monkey.obj", "assets/materials/granite/");
    gm::Entity* monkey2 = new gm::Entity("assets/models/monkey.obj", "assets/materials/granite/");
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}