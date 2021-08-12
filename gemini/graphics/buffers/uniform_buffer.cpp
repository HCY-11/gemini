#include "uniform_buffer.h"

namespace gm
{
    UniformBuffer::UniformBuffer(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const UBOData& uboData)
    {
        loadData(device, cmdPool, allocator, uboData);
    }

    void UniformBuffer::loadData(Device* device, CommandPool* cmdPool, VmaAllocator allocator, const UBOData& uboData)
    {
        init(allocator, 
             VMA_MEMORY_USAGE_CPU_TO_GPU, 
             sizeof(UBOData), 
             VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT);

        loadGenericData(&uboData);
    }

    void UniformBuffer::update(const Camera& camera, const Light& light)
    {
        UBOData uboData = { camera.position, light };
        loadGenericData(&uboData);
    }
}