#pragma once

#include "graphics/buffers/buffer.h"
#include "graphics/meshes/vertex.h"

namespace gm
{
    class VertexBuffer : public Buffer
    {
    public:
        VertexBuffer() = default;
        VertexBuffer(VmaAllocator allocator, const std::vector<Vertex>& vertices);
    };
}