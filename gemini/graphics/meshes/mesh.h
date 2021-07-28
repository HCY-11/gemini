#pragma once

#include "core/core.h"

#include "graphics/buffers/vertex_buffer.h"

namespace gm
{
    struct RawMeshData
    {
        std::vector<Vertex> vertices;
    };

    struct Mesh
    {
        VertexBuffer vbo;

        Mesh() = default;

        Mesh(VmaAllocator allocator, const RawMeshData& rawData) : vbo(allocator, rawData.vertices)
        {}

        ~Mesh() = default;
    };
}