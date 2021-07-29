#pragma once

#include "core/core.h"

#include "graphics/entities/vertex.h"

namespace gm
{
    struct Mesh
    {
        std::vector<Vertex> vertices;
        std::vector<uint16_t> indices;

        Mesh() = default;
    };
}