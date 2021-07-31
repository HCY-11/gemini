#include "entity.h"

namespace gm
{
    Entity::Entity(const Mesh& mesh) : m_mesh(mesh)
    {}
    
    Entity::Entity(const char* filePath)
    {
        loadFromFile(filePath);
    }

    void Entity::loadMesh(Device* device, CommandPool* cmdPool, VmaAllocator allocator)
    {
        m_vbo.loadData(device, cmdPool, allocator, m_mesh.vertices);
        m_ibo.loadData(device, cmdPool, allocator, m_mesh.indices);
    }

    void Entity::loadFromFile(const char* fileName)
    {
        tinyobj::attrib_t attrib;

        std::vector<tinyobj::shape_t> shapes;
        std::vector<tinyobj::material_t> materials;

        std::string err;

        std::string fullPath = static_cast<std::string>(GM_ROOTDIR) + static_cast<std::string>(fileName);

        tinyobj::LoadObj(&attrib, &shapes, &materials, &err, fullPath.c_str());

        if (err != "")
        {
            GM_CORE_WARN("tinobjloader: {0} has errors/warnings: {1}", fullPath, err);
        }

        // Loop through faces
        for (size_t i = 0; i < shapes.size(); i++)
        {
            size_t indexOffset = 0;
            // Loop through polygons
            for (size_t j = 0; j < shapes[i].mesh.num_face_vertices.size(); j++)
            {
                size_t numVertices = 3;
                // For now, assume triangulation
                // TODO: allow for faces with different number of vertices
                for (size_t k = 0; k < numVertices; k++)
                {
                    uint16_t newIndex = indexOffset + k;
                    m_mesh.indices.push_back(newIndex);

                    tinyobj::index_t idx = shapes[i].mesh.indices[newIndex];

                    Vertex newVertex = {};

                    newVertex.position.x = attrib.vertices[3 * idx.vertex_index + 0];
                    newVertex.position.y = attrib.vertices[3 * idx.vertex_index + 1];
                    newVertex.position.z = attrib.vertices[3 * idx.vertex_index + 2];

                    newVertex.normal.x = attrib.normals[3 * idx.normal_index + 0];
                    newVertex.normal.y = attrib.normals[3 * idx.normal_index + 1];
                    newVertex.normal.z = attrib.normals[3 * idx.normal_index + 2];

                    newVertex.color = newVertex.normal;

                    m_mesh.vertices.push_back(newVertex);
                }

                indexOffset += numVertices;
            }
        }
    }
}