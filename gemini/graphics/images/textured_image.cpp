#include "textured_image.h"

#include "graphics/buffers/buffer.h"

namespace gm
{
    TexturedImage::TexturedImage(GPU* gpu, Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::filesystem::path& filePath)
    {
        loadData(gpu, device, cmdPool, allocator, filePath);
    }

    TexturedImage::~TexturedImage()
    {
        vkDestroySampler(m_device->get(), m_sampler, nullptr);
    }

    void TexturedImage::loadData(GPU* gpu, Device* device, CommandPool* cmdPool, VmaAllocator allocator, const std::filesystem::path& filePath)
    {
        int width, height;
        int channels;

        stbi_uc* data = stbi_load(JOIN_WITH_ROOTDIR(filePath).c_str(), &width, &height, &channels, STBI_rgb_alpha);

        if (data == nullptr)
        {
            GM_CORE_ASSERT("Failed to open texture file {0}", filePath);
        }

        VkDeviceSize size = 4 * width * height;

        VkExtent3D extent = 
        {
            static_cast<uint32_t>(width),
            static_cast<uint32_t>(height),
            1
        };

        init(
            device, 
            extent, 
            allocator, 
            VMA_MEMORY_USAGE_GPU_ONLY, 
            VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT, 
            VK_FORMAT_R8G8B8A8_SRGB,
            VK_IMAGE_TYPE_2D,
            VK_SAMPLE_COUNT_1_BIT,
            VK_IMAGE_TILING_OPTIMAL,
            VK_IMAGE_USAGE_TRANSFER_DST_BIT | VK_IMAGE_USAGE_SAMPLED_BIT,
            VK_IMAGE_ASPECT_COLOR_BIT
        );

        Buffer stagingBuffer(allocator, VMA_MEMORY_USAGE_CPU_ONLY, size, VK_BUFFER_USAGE_TRANSFER_SRC_BIT);

        stagingBuffer.loadGenericData(data);

        transitionLayout(cmdPool, VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL);

        stagingBuffer.copyToImage(cmdPool, 
                                  m_image, 
                                  VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL, 
                                  { 
                                      static_cast<uint32_t>(width), 
                                      static_cast<uint32_t>(height), 
                                      1 
                                  });
        transitionLayout(cmdPool, VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL);

        createSampler(gpu);
    }

    void TexturedImage::createSampler(GPU* gpu)
    {
        VkSamplerCreateInfo samplerInfo         = {};
        samplerInfo.sType                       = VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO;
        samplerInfo.addressModeU                = VK_SAMPLER_ADDRESS_MODE_REPEAT;
        samplerInfo.addressModeV                = VK_SAMPLER_ADDRESS_MODE_REPEAT;
        samplerInfo.addressModeW                = VK_SAMPLER_ADDRESS_MODE_REPEAT;
        samplerInfo.magFilter                   = VK_FILTER_LINEAR;
        samplerInfo.minFilter                   = VK_FILTER_LINEAR;
        samplerInfo.anisotropyEnable            = VK_TRUE;

        VkPhysicalDeviceProperties properties;
        vkGetPhysicalDeviceProperties(gpu->get(), &properties);

        samplerInfo.maxAnisotropy               = properties.limits.maxSamplerAnisotropy;
        samplerInfo.borderColor                 = VK_BORDER_COLOR_INT_OPAQUE_BLACK;

        samplerInfo.compareEnable               = VK_FALSE;
        samplerInfo.compareOp                   = VK_COMPARE_OP_ALWAYS;
        samplerInfo.unnormalizedCoordinates     = VK_FALSE;

        samplerInfo.mipmapMode                  = VK_SAMPLER_MIPMAP_MODE_LINEAR;

        samplerInfo.maxLod                      = 0.0f;
        samplerInfo.minLod                      = 0.0f;
        samplerInfo.mipLodBias                  = 0.0f;

        GM_CORE_ASSERT(vkCreateSampler(m_device->get(), &samplerInfo, nullptr, &m_sampler) == VK_SUCCESS,
                       "Failed to create image sampler!");
    }
}