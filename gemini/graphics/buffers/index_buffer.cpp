#include "index_buffer.h"

namespace gm
{
    IndexBuffer::IndexBuffer(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::vector<uint16_t>& indices)
    {
        loadData(device, cmdPool, allocator, indices);
    }

    void IndexBuffer::loadData(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::vector<uint16_t>& indices)
    {
        init(allocator, 
             VMA_MEMORY_USAGE_GPU_ONLY,
             indices.size() * sizeof(uint16_t), 
             VK_BUFFER_USAGE_INDEX_BUFFER_BIT | VK_BUFFER_USAGE_TRANSFER_DST_BIT);

        VkDeviceSize size = indices.size() * sizeof(uint16_t);
        Buffer stagingBuffer(allocator, VMA_MEMORY_USAGE_CPU_ONLY, size, VK_BUFFER_USAGE_TRANSFER_SRC_BIT, indices.data());

        stagingBuffer.copyToBuffer(cmdPool, m_buffer, size);

        m_numIndices = indices.size();
        m_firstIndex = static_cast<uint32_t>(indices[0]);
    }
}