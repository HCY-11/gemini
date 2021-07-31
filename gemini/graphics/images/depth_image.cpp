#include "depth_image.h"

namespace gm
{
    DepthImage::DepthImage(Window* window, GPU* gpu, Device* device, VmaAllocator allocator) :
        Image(
            window,
            gpu,
            device,
            allocator,
            VMA_MEMORY_USAGE_GPU_ONLY,
            VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT,
            { VK_FORMAT_D32_SFLOAT, VK_FORMAT_D32_SFLOAT_S8_UINT, VK_FORMAT_D24_UNORM_S8_UINT },
            VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT,
            VK_IMAGE_TYPE_2D,
            VK_SAMPLE_COUNT_1_BIT,
            VK_IMAGE_TILING_OPTIMAL,
            VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT,
            VK_IMAGE_ASPECT_DEPTH_BIT)
    {}
}