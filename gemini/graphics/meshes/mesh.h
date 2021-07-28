#pragma once

#include "core/core.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"

namespace gm
{
    struct RawMeshData
    {
        std::vector<Vertex> vertices;
        std::vector<uint16_t> indices;
    };

    struct Mesh
    {
        VertexBuffer vbo;
        IndexBuffer ibo;

        Mesh() = default;

        Mesh(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const RawMeshData& rawData) : 
            vbo(device, cmdPool, allocator, rawData.vertices), ibo(device, cmdPool, allocator, rawData.indices)
        {}

        ~Mesh() = default;
    };
}