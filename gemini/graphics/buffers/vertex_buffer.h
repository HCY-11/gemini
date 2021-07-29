#pragma once

#include "graphics/buffers/buffer.h"
#include "graphics/entities/vertex.h"

namespace gm
{
    class VertexBuffer : public Buffer
    {
    public:
        VertexBuffer() = default;
        VertexBuffer(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::vector<Vertex>& vertices);

        inline uint32_t getNumVertices() const { return m_numVertices; }

    private:
        uint32_t m_numVertices = 0;
    };
}