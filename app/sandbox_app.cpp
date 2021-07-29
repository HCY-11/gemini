#include <gemini/gemini.h>

namespace gm
{
    class SandBoxApp : public Application
    {
    public:
        SandBoxApp() {
            pushLayer(new GraphicsLayer(m_window.get()));

            Mesh triangleMesh = {};

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

            addMesh(triangleMesh);
        }
    };

    Application* createApplication()
    {
        return new SandBoxApp();
    }
}