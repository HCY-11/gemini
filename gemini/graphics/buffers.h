#pragma once

#include <vector>
#include <cstring>

#include "entity/vertex.h"
#include "util/util.h"

#include "device.h"
#include "vma.h"

struct VertexBuffer
{
    void load(const Device& device, const std::vector<Vertex>& vertices)
    {
        VkBufferCreateInfo bufferInfo           = {};
        bufferInfo.sType                        = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
        bufferInfo.usage                        = VK_BUFFER_USAGE_VERTEX_BUFFER_BIT;
        bufferInfo.sharingMode                  = VK_SHARING_MODE_EXCLUSIVE;
        bufferInfo.size                         = sizeof(Vertex) * vertices.size();

        VmaAllocationCreateInfo allocationInfo  = {};
        allocationInfo.usage                    = VMA_MEMORY_USAGE_CPU_TO_GPU;

        CHECK_VK_RESULT(vmaCreateBuffer(device.getAllocator(), &bufferInfo, &allocationInfo, &buffer, &allocation, nullptr),
                        "Failed to create buffer!");

        void* data;
        vmaMapMemory(device.getAllocator(), allocation, &data);

        memcpy(data, vertices.data(), sizeof(Vertex) * vertices.size());

        vmaUnmapMemory(device.getAllocator(), allocation);
    }

    void destroy(const Device& device)
    {
        vmaDestroyBuffer(device.getAllocator(), buffer, allocation);
    }

    VkBuffer        buffer          = VK_NULL_HANDLE;
    VmaAllocation   allocation      = VK_NULL_HANDLE;
};