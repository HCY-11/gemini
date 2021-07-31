#pragma once

#include "core/core.h"

#include "graphics/entities/vertex.h"
#include "graphics/entities/transform.h"

namespace gm
{
    struct Mesh
    {
        std::vector<Vertex> vertices;
        std::vector<uint16_t> indices;
        Mesh() = default;
    };
}