#include <gemini/gemini.h>

class SandBoxApp : public gm::Application
{
public:
    SandBoxApp() {
        pushLayer(new gm::GraphicsLayer(m_window.get()));

        gm::Mesh triangleMesh = {};

        triangleMesh.vertices.resize(4);

        triangleMesh.vertices[0].position = { 0.5f, -0.5f, 0.0f };
        triangleMesh.vertices[1].position = { -0.5f, -0.5f, 0.0f };
        triangleMesh.vertices[2].position = { -0.5f, 0.5f, 0.0f };
        triangleMesh.vertices[3].position = { 0.5f, 0.5f, 0.0f };

        triangleMesh.vertices[0].color = { 1.0f, 1.0f, 0.0f };
        triangleMesh.vertices[1].color = { 0.0f, 1.0f, 1.0f };
        triangleMesh.vertices[2].color = { 1.0f, 0.0f, 1.0f };
        triangleMesh.vertices[3].color = { 1.0f, 0.0f, 0.0f };

        triangleMesh.indices = { 0, 1, 2, 2, 3, 0 };

        triangle->setMesh(triangleMesh);

        addEntity(triangle);
    }

    void onUpdate()
    {
        triangle->rotate({ 0, 30, 0 }, m_deltaTime);
    }

private:
    gm::Entity* triangle = new gm::Entity();
};

gm::Application* gm::createApplication()
{
    return new SandBoxApp();
}