#include "entity.h"

namespace gm
{
    Entity::Entity(const Mesh& mesh) : m_mesh(mesh)
    {}

    void Entity::loadMesh(Device* device, CommandPool* cmdPool, VmaAllocator allocator)
    {
        m_vbo.loadData(device, cmdPool, allocator, m_mesh.vertices);
        m_ibo.loadData(device, cmdPool, allocator, m_mesh.indices);
    }
}
