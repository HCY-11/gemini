#pragma once

#include "core/core.h"

namespace gm
{
    class DescriptorSetHandler
    {
    public:
        DescriptorSetHandler(Device* device, Pipeline* pipeline);
        ~DescriptorSetHandler() = default;

        void allocate(Pipeline* pipeline);

        void push(TexturedImage* image, uint32_t binding);

        void write();

        void bind(VkCommandBuffer cmdBuf, VkPipelineLayout pipelineLayout);

    private:
        Device*                                 m_device        = nullptr;

        VkDescriptorSet                         m_set           = {};

        std::vector<VkWriteDescriptorSet>       m_writes        = {};

        std::vector<VkDescriptorImageInfo>      m_imageInfos    = {};

        VkDescriptorSetAllocateInfo             m_allocInfo     = {};
    };
}