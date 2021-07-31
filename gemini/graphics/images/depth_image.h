#pragma once

#include "graphics/images/image.h"

namespace gm
{
    class DepthImage : public Image
    {
    public:
        DepthImage(Window* window, GPU* gpu, Device* device, VmaAllocator allocator);
    };
}
