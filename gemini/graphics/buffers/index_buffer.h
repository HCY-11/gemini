#pragma once

#include "graphics/buffers/buffer.h"

namespace gm
{
    class IndexBuffer : public Buffer
    {
    public:
        IndexBuffer() = default;
        IndexBuffer(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::vector<uint16_t>& indices);

        inline uint32_t getNumIndices() const { return m_numIndices; }

        inline uint32_t getFirstIndex() const { return m_firstIndex; }
    
    private:
        uint32_t m_numIndices = 0;
        uint32_t m_firstIndex = 0;
    };
}