#pragma once

#include "vertex.h"

#include "graphics/buffers.h"

#include <vector>

struct Mesh
{
    VertexBuffer vertexBuffer;

    Mesh() {}

    Mesh(const Device& device, const std::vector<Vertex>& vertices)
    {
        vertexBuffer.load(device, vertices);
    }
};