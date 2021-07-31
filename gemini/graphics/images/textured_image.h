#pragma once

#include "graphics/images/image.h"

namespace gm
{
    class TexturedImage : public Image
    {
    public:
        TexturedImage(GPU* gpu, Device* device, CommandPool* cmdPool, VmaAllocator allocator, const char* fileName);

        const VkSampler& getSampler() const { return m_sampler; }
    
    private:
        void createSampler();

    private:
        GPU*        m_gpu               = nullptr;

        VkSampler   m_sampler;
    };
}