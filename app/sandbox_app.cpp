#include <gemini/gemini.h>

namespace gm
{
    class SandBoxApp : public Application
    {
    public:
        SandBoxApp() {
            pushLayer(new GraphicsLayer(m_window.get()));

            Mesh* triangle = new Mesh();

            triangle->vertices.resize(3);

            triangle->vertices[0].position = { 0.0f, -0.5f, 0.0f };
            triangle->vertices[1].position = { -0.5f, 0.5f, 0.0f };
            triangle->vertices[2].position = { 0.5f, 0.5f, 0.0f };

            triangle->vertices[0].color = { 1.0f, 1.0f, 0.0f };
            triangle->vertices[1].color = { 0.0f, 1.0f, 1.0f };
            triangle->vertices[2].color = { 1.0f, 0.f, 1.0f };

            addMesh(triangle);
        }
    };

    Application* createApplication()
    {
        return new SandBoxApp();
    }
}