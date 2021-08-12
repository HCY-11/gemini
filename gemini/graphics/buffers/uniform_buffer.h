#pragma once

#include "graphics/buffers/buffer.h"

#include "graphics/entities/light.h"

namespace gm
{
    struct UBOData
    {
        alignas(16) glm::vec3 cameraPosition;
        Light light;
    };

    class UniformBuffer : public Buffer
    {
    public:
        UniformBuffer() = default;
        UniformBuffer(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const UBOData& uboData);

        void loadData(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const UBOData& uboData);

        void update(const Camera& camera, const Light& light);
    };
}
