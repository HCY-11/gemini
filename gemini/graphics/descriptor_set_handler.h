#pragma once

#include "core/core.h"

#include "graphics/buffers/uniform_buffer.h"

#include "graphics/images/textured_image.h"

namespace gm
{
    class DescriptorSetHandler
    {
    public:
        DescriptorSetHandler(Device* device, Pipeline* pipeline);
        ~DescriptorSetHandler() = default;

        void allocate(Pipeline* pipeline);

        void addSampler(TexturedImage* image, uint32_t binding);

        void addUniformBuffer(UniformBuffer* buffer, uint32_t binding);

        void updateWrites();

        void write();

        void bind(VkCommandBuffer cmdBuf, VkPipelineLayout pipelineLayout);

    private:
        Device*                                 m_device        = nullptr;

        VkDescriptorSet                         m_set           = {};

        std::vector<VkWriteDescriptorSet>       m_writes        = {};

        std::vector<VkDescriptorImageInfo>      m_imageInfos    = {};
        std::vector<VkDescriptorBufferInfo>     m_bufferInfos   = {};

        VkDeviceSize                            m_bufferOffset  = 0;

        VkDescriptorSetAllocateInfo             m_allocInfo     = {};
    };
}