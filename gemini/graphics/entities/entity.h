#pragma once

#include "graphics/entities/mesh.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"

namespace gm
{
    struct Entity
    {
        VertexBuffer vbo;
        IndexBuffer ibo;

        Entity() = default;

        Entity(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const Mesh& mesh) : 
            vbo(device, cmdPool, allocator, mesh.vertices), ibo(device, cmdPool, allocator, mesh.indices)
        {

        }

        ~Entity() = default;
    };
    
}