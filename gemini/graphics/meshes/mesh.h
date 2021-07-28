#pragma once

#include "core/core.h"

#include "graphics/buffers/vertex_buffer.h"

namespace gm
{
    struct Mesh
    {
        std::vector<Vertex> vertices;

        Scope<VertexBuffer> vbo;

        Mesh() = default;

        Mesh(const std::vector<Vertex>& inVertices)
        {
            vertices = inVertices;
        }

        ~Mesh() = default;

        void initVBO(VmaAllocator allocator)
        {
            vbo = makeScope<VertexBuffer>(allocator, vertices);
        }
    };
}