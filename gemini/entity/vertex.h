#pragma once

#include <vulkan/vulkan.h>
#include <glm/glm.hpp>
#include <array>

struct Vertex
{
    glm::vec3 position;
    glm::vec3 color;

    static std::array<VkVertexInputAttributeDescription, 2> getAttributeDescriptions()
    {
        std::array<VkVertexInputAttributeDescription, 2> attribs    = {};
        attribs[0].binding                                          = 0;
        attribs[0].format                                           = VK_FORMAT_R32G32B32_SFLOAT;
        attribs[0].location                                         = 0;
        attribs[0].offset                                           = offsetof(Vertex, position);

        attribs[1].binding                                          = 0;
        attribs[1].format                                           = VK_FORMAT_R32G32B32_SFLOAT;
        attribs[1].location                                         = 1;
        attribs[1].offset                                           = offsetof(Vertex, color);

        return attribs;
    }

    static VkVertexInputBindingDescription getBindingDescription()
    {
        VkVertexInputBindingDescription binding                     = {};
        binding.binding                                             = 0;
        binding.inputRate                                           = VK_VERTEX_INPUT_RATE_VERTEX;
        binding.stride                                              = sizeof(Vertex);

        return binding;
    }
};