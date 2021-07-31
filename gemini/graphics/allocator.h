#pragma once

#include "core/core.h"

#include "graphics/device.h"

namespace gm
{
    class Allocator
    {
    public:
        Allocator(Instance* instance, GPU* gpu, Device* device);
        ~Allocator();

        inline const VmaAllocator& get() const { return m_allocator; }

    private:
        VmaAllocator m_allocator = VK_NULL_HANDLE;
    };
}
