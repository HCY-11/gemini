#include "allocator.h"

namespace gm
{
    Allocator::Allocator(Instance* instance, GPU* gpu, Device* device)
    {
        VmaAllocatorCreateInfo createInfo       = {};
        createInfo.instance                     = instance->get();
        createInfo.device                       = device->get();
        createInfo.physicalDevice               = gpu->get();

        GM_CORE_ASSERT(vmaCreateAllocator(&createInfo, &m_allocator) == VK_SUCCESS, 
                       "Failed to create allocator!");
    }

    Allocator::~Allocator()
    {
        vmaDestroyAllocator(m_allocator);
    }

}