#include "entity.h"

namespace gm
{
    Entity::Entity(const Mesh& mesh) : m_mesh(mesh)
    {}

    void Entity::onUpdate()
    {

    }

    void Entity::loadMesh(Device* device, CommandPool* cmdPool, VmaAllocator allocator)
    {
        m_vbo.loadData(device, cmdPool, allocator, m_mesh.vertices);
        m_ibo.loadData(device, cmdPool, allocator, m_mesh.indices);
        
        createModelMatrix();
    }

    void Entity::createModelMatrix()
    {
        m_modelMatrix = glm::translate(m_modelMatrix, m_transform.position);

        m_modelMatrix = glm::rotate(m_modelMatrix, m_transform.rotation.x, glm::vec3(1, 0, 0));
        m_modelMatrix = glm::rotate(m_modelMatrix, m_transform.rotation.y, glm::vec3(0, 1, 0));
        m_modelMatrix = glm::rotate(m_modelMatrix, m_transform.rotation.z, glm::vec3(0, 0, 1));

        m_modelMatrix = glm::scale(m_modelMatrix, m_transform.scale);
    }
}
