#include <gemini/gemini.h>
#include <random>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        camera.position = glm::vec3(0.0f, 0.0f, 25.0f);
        light.position = glm::vec3(0.0f, 0.0f, 0.0f);

        light.intensity = 5.0f;
        light.radius = 30.0f;

        float separation = 10.0f;

        snowden1->rotateX(90.0f);
        snowden1->translateZ(-separation);

        snowden2->rotateX(90.0f);
        snowden2->translateZ(-separation);
        snowden2->translateX(-separation);

        snowden3->rotateX(90.0f);
        snowden3->translateZ(-separation);
        snowden3->translateX(separation);

        snowden4->rotateX(90.0f);
        snowden4->translateZ(-separation);
        snowden4->translateY(-separation);

        snowden5->rotateX(90.0f);
        snowden5->translateZ(-separation);
        snowden5->translateY(separation);

        addEntity(snowden1);
        addEntity(snowden2);
        addEntity(snowden3);
        addEntity(snowden4);
        addEntity(snowden5);
    }

    void onUpdate()
    {
        snowden1->rotateZ(30.0f, deltaTime);
        snowden2->rotateZ(30.0f, deltaTime);
        snowden3->rotateZ(30.0f, deltaTime);
        snowden4->rotateZ(30.0f, deltaTime);
        snowden5->rotateZ(30.0f, deltaTime);
    }

private:
    gm::Entity* snowden1 = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
    gm::Entity* snowden2 = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
    gm::Entity* snowden3 = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
    gm::Entity* snowden4 = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
    gm::Entity* snowden5 = new gm::Entity("assets/models/snowden.obj", "assets/materials/rusted_iron/");
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}