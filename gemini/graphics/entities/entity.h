#pragma once

#include "graphics/entities/mesh.h"
#include "graphics/entities/transform.h"
#include "graphics/entities/camera.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"

namespace gm
{
    class Entity
    {
    public:
        Entity() = default;
        Entity(const Mesh& mesh);

        ~Entity() = default;

        void onUpdate();

        inline void setMesh(const Mesh& mesh) { m_mesh = mesh; }

        // Load internal mesh data into buffers. Not meant to be used at application level
        void loadMesh(Device* device, CommandPool* cmdPool, VmaAllocator allocator);

        // Not meant to be used at application level
        const glm::mat4& getModelMatrix() const { return m_modelMatrix; }

        // Not meant to be used at application level
        const VertexBuffer& getVBO() const { return m_vbo; }

        // Not meant to be used at application level
        const IndexBuffer& getIBO() const { return m_ibo; }

    private:
        void createModelMatrix();

    private:
        // TODO:: Make component based entity system
        VertexBuffer m_vbo;
        IndexBuffer m_ibo;

        Transform m_transform;
        Mesh m_mesh;

        glm::mat4 m_modelMatrix = glm::mat4(1.0f);
    };
    
}