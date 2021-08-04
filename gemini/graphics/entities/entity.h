#pragma once

#include "graphics/entities/mesh.h"
#include "graphics/entities/transform.h"
#include "graphics/entities/camera.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"

namespace gm
{
    struct EntityPushConstant
    {
        glm::mat4 model;
        glm::mat4 projectionView;
    };

    class Entity
    {
    public:
        Entity() = default;
        Entity(const Mesh& mesh) : m_mesh(mesh)
        {}

        Entity(const char* filePath, const char* texturePath)
        {
            m_mesh.loadFromFile(filePath);

            m_mesh.textureFile = texturePath;
        }

        ~Entity() = default;

        // TODO: Add individual rotate* translate* for each axis
        inline void translate(const glm::vec3& dTranslation, float deltaTime = 1.0f) { m_transform.position += dTranslation * deltaTime; }

        inline void rotate(const glm::vec3& dRotation, float deltaTime = 1.0f) { m_transform.rotation += dRotation * deltaTime; }

        void loadFromFile(const char* fileName);

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