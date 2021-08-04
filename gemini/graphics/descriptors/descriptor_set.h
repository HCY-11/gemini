#pragma once

#include "graphics/pipeline.h"
#include "graphics/images/image.h"
#include "graphics/buffers/buffer.h"

namespace gm
{
    class DescriptorSet
    {
    public:
        DescriptorSet() = default;
        DescriptorSet(Device* device, Pipeline* pipeline, const TexturedImage& image, uint32_t binding, uint32_t count);
        DescriptorSet(Device* device, Pipeline* pipeline, const Buffer& buffer, uint32_t binding, uint32_t count);
        ~DescriptorSet() = default;

        void init(Device* device, Pipeline* pipeline, const TexturedImage& image, uint32_t binding, uint32_t count );

        void init(Device* device, Pipeline* pipeline, const Buffer& buffer, uint32_t binding, uint32_t count);

        inline void update()
        {
            vkUpdateDescriptorSets(m_device->get(), m_writes.size(), m_writes.data(), 0, nullptr);
        }

        inline const std::vector<VkDescriptorSet>& get() const { return m_sets; }
    
    private:
        Device*                                 m_device            = nullptr;

        std::vector<VkDescriptorSet>            m_sets;
        std::vector<VkWriteDescriptorSet>       m_writes;

        VkDescriptorImageInfo                   m_imageInfo;
        VkDescriptorBufferInfo                  m_bufferInfo;
    };
}
