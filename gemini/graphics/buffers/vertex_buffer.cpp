#include "vertex_buffer.h"

namespace gm
{
    VertexBuffer::VertexBuffer(VmaAllocator allocator, const std::vector<Vertex>& vertices) :
        Buffer(allocator, vertices.size() * sizeof(Vertex), VK_BUFFER_USAGE_VERTEX_BUFFER_BIT, VMA_MEMORY_USAGE_CPU_TO_GPU)
    {
        loadData(vertices.data());

        m_numVertices = vertices.size();
    }
}