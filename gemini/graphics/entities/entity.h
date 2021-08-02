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
        glm::mat4 mvp;
    };

    class Entity
    {
    public:
        Entity() = default;
        Entity(const Mesh& mesh);
        Entity(const char* filePath);

        ~Entity() = default;

        // TODO: Add individual rotate* translate* for each axis
        inline void translate(const glm::vec3& dTranslation, float deltaTime = 1.0f) { m_transform.position += dTranslation * deltaTime; }

        inline void rotate(const glm::vec3& dRotation, float deltaTime = 1.0f) { m_transform.rotation += dRotation * deltaTime; }

        void loadFromFile(const char* fileName);

        inline void setMesh(const Mesh& mesh) { m_mesh = mesh; }

        inline const Transform& getTransform() const { return m_transform; }

        inline void setTransform(const Transform& transform) { m_transform = transform; }

        // Load internal mesh data into buffers. Not meant to be used at application level
        void loadMesh(Device* device, CommandPool* cmdPool, VmaAllocator allocator);

        // Not meant to be used at application level
        const VertexBuffer& getVBO() const { return m_vbo; }

        // Not meant to be used at application level
        const IndexBuffer& getIBO() const { return m_ibo; }

    private:
        // TODO:: Make component based entity system
        VertexBuffer m_vbo;
        IndexBuffer m_ibo;

        Transform m_transform;
        Mesh m_mesh;
    };
    
}