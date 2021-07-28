#include "index_buffer.h"

namespace gm
{
    IndexBuffer::IndexBuffer(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::vector<uint16_t>& indices) :
        Buffer(allocator, 
               indices.size() * sizeof(uint16_t), 
               VK_BUFFER_USAGE_INDEX_BUFFER_BIT | VK_BUFFER_USAGE_TRANSFER_DST_BIT, 
               VMA_MEMORY_USAGE_GPU_ONLY)
    {
        VkDeviceSize size = indices.size() * sizeof(uint16_t);
        Buffer stagingBuffer(allocator, size, VK_BUFFER_USAGE_TRANSFER_SRC_BIT, VMA_MEMORY_USAGE_CPU_ONLY);

        stagingBuffer.loadData(indices.data());

        stagingBuffer.copyToBuffer(device, cmdPool, stagingBuffer.get(), m_data, size);

        m_numIndices = indices.size();
        m_firstIndex = static_cast<uint32_t>(indices[0]);
    }
}