#include <gemini/gemini.h>

namespace gm
{
    class SandBoxApp : public Application
    {
    public:
        SandBoxApp() {
            pushLayer(new GraphicsLayer(m_window.get()));

            RawMeshData triangleData = {};

            triangleData.vertices.resize(4);
            
            triangleData.vertices[0].position = { 0.5f, -0.5f, 0.0f };
            triangleData.vertices[1].position = { -0.5f, -0.5f, 0.0f };
            triangleData.vertices[2].position = { -0.5f, 0.5f, 0.0f };
            triangleData.vertices[3].position = { 0.5f, 0.5f, 0.0f };

            triangleData.vertices[0].color = { 1.0f, 1.0f, 0.0f };
            triangleData.vertices[1].color = { 0.0f, 1.0f, 1.0f };
            triangleData.vertices[2].color = { 1.0f, 0.0f, 1.0f };
            triangleData.vertices[3].color = { 1.0f, 0.0f, 0.0f };

            triangleData.indices = { 0, 1, 2, 2, 3, 0 };

            addMesh(triangleData);
        }
    };

    Application* createApplication()
    {
        return new SandBoxApp();
    }
}