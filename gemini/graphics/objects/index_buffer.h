#pragma once

#include "graphics/objects/buffer.h"

namespace gm
{
    class IndexBuffer : public Buffer
    {
    public:
        IndexBuffer() = default;
        IndexBuffer(Device* device, CommandPool* cmdPool, Allocator* allocator, const std::vector<uint16_t>& indices);

        // Should only be called once
        void loadData(Device* device, CommandPool* cmdPool, Allocator* allocator, const std::vector<uint16_t>& indices);

        inline uint32_t getNumIndices() const { return m_numIndices; }

        inline uint32_t getFirstIndex() const { return m_firstIndex; }
    
    private:
        uint32_t m_numIndices = 0;
        uint32_t m_firstIndex = 0;
    };
}