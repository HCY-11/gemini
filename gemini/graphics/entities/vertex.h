#pragma once

#include "core/core.h"

namespace gm
{
    struct Vertex             
    {
        glm::vec3 position;
        glm::vec3 normal;
        glm::vec2 texCoord;

        static std::array<VkVertexInputAttributeDescription, 3> getAttributeDescriptions()
        {
            std::array<VkVertexInputAttributeDescription, 3> descriptions   = {};
            // Position
            descriptions[0].binding                                         = 0;
            descriptions[0].format                                          = VK_FORMAT_R32G32B32_SFLOAT;
            descriptions[0].location                                        = 0;
            descriptions[0].offset                                          = offsetof(Vertex, position);

            // Normal
            descriptions[1].binding                                         = 0;
            descriptions[1].format                                          = VK_FORMAT_R32G32B32_SFLOAT;
            descriptions[1].location                                        = 1;
            descriptions[1].offset                                          = offsetof(Vertex, normal);

            // UV
            descriptions[2].binding                                         = 0;
            descriptions[2].format                                          = VK_FORMAT_R32G32_SFLOAT;
            descriptions[2].location                                        = 2;
            descriptions[2].offset                                          = offsetof(Vertex, texCoord);

            return descriptions;
        }

        static VkVertexInputBindingDescription getBindingDescription()
        {
            VkVertexInputBindingDescription binding         = {};
            binding.binding                                 = 0;
            binding.inputRate                               = VK_VERTEX_INPUT_RATE_VERTEX;
            binding.stride                                  = sizeof(Vertex);

            return binding;
        }
    };
}