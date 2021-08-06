#pragma once

#include "graphics/images/image.h"

namespace gm
{
    class TexturedImage : public Image
    {
    public:
        TexturedImage() = default;
        TexturedImage(GPU* gpu, Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::string& fileName);

        ~TexturedImage();

        void loadData(GPU* gpu, Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::string& fileName);

        const VkSampler& getSampler() const { return m_sampler; }
    
    private:
        void createSampler(GPU* gpu);

    private:
        VkSampler   m_sampler       = VK_NULL_HANDLE;
    };
}