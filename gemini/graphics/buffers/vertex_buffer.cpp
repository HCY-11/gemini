#include "vertex_buffer.h"

namespace gm
{
    VertexBuffer::VertexBuffer(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::vector<Vertex>& vertices)
    {
        loadData(device, cmdPool, allocator, vertices);
    }

    void VertexBuffer::loadData(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::vector<Vertex>& vertices)
    {
        init(allocator, 
             vertices.size() * sizeof(Vertex), 
             VK_BUFFER_USAGE_VERTEX_BUFFER_BIT | VK_BUFFER_USAGE_TRANSFER_DST_BIT, 
             VMA_MEMORY_USAGE_CPU_ONLY);

        VkDeviceSize size = vertices.size() * sizeof(Vertex);
        Buffer stagingBuffer(allocator, size, VK_BUFFER_USAGE_TRANSFER_SRC_BIT, VMA_MEMORY_USAGE_GPU_ONLY, vertices.data());

        stagingBuffer.copyToBuffer(device, cmdPool, stagingBuffer.get(), m_data, size);

        m_numVertices = vertices.size();
    }
}