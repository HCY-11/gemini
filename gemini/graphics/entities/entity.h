#pragma once

#include "graphics/entities/mesh.h"
#include "graphics/entities/transform.h"
#include "graphics/entities/camera.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"

namespace gm
{
    class GM_API Entity
    {
    public:
        Entity() = default;
        Entity(const Mesh& mesh) : m_mesh(mesh)
        {}

        Entity(const std::string& filePath, const std::string& materialPath)
        {
            m_mesh.loadFromFile(filePath, materialPath);
        }

        Entity(const std::string& filePath, const std::string& materialPath, 
               const glm::vec3& position, const glm::vec3& rotation)
        {
            m_mesh.loadFromFile(filePath, materialPath);

            translate(position);
            rotate(rotation);
        }

        ~Entity() = default;

        inline void translate(const glm::vec3& dTranslation, float deltaTime = 1.0f) { m_transform.position += dTranslation * deltaTime; }

        inline void translateX(float dTranslateX, float deltaTime = 1.0f) { translate({ dTranslateX, 0.0f, 0.0f }, deltaTime); }
        inline void translateY(float dTranslateY, float deltaTime = 1.0f) { translate({ 0.0f, dTranslateY, 0.0f }, deltaTime); }
        inline void translateZ(float dTranslateZ, float deltaTime = 1.0f) { translate({ 0.0f, 0.0f, dTranslateZ }, deltaTime); }

        inline void rotate(const glm::vec3& dRotation, float deltaTime = 1.0f) { m_transform.rotation += dRotation * deltaTime; }

        inline void rotateX(float dRotateX, float deltaTime = 1.0f) { rotate({ dRotateX, 0.0f, 0.0f }, deltaTime); }
        inline void rotateY(float dRotateY, float deltaTime = 1.0f) { rotate({ 0.0f, dRotateY, 0.0f }, deltaTime); }
        inline void rotateZ(float dRotateZ, float deltaTime = 1.0f) { rotate({ 0.0f, 0.0f, dRotateZ }, deltaTime); }

        inline void setMesh(const Mesh& mesh) { m_mesh = mesh; }

        inline const Transform& getTransform() const { return m_transform; }

        inline void setTransform(const Transform& transform) { m_transform = transform; }

        inline const Mesh& getMesh() const { return m_mesh; }

    private:
        // TODO:: Make component based entity system
        Transform m_transform;
        Mesh m_mesh;
    };
    
}