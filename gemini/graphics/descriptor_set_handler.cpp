#include "descriptor_set_handler.h"

namespace gm
{
    DescriptorSetHandler::DescriptorSetHandler(Device* device, Pipeline* pipeline) : m_device(device)
    {
        allocate(pipeline);
    }

    void DescriptorSetHandler::allocate(Pipeline* pipeline)
    {
        m_allocInfo.sType                   = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
        m_allocInfo.descriptorPool          = pipeline->getDescriptorPool();
        m_allocInfo.pSetLayouts             = &pipeline->getDescriptorSetLayout();
        m_allocInfo.descriptorSetCount      = 1;

        GM_CORE_ASSERT(vkAllocateDescriptorSets(m_device->get(), &m_allocInfo, &m_set) == VK_SUCCESS,
                       "Failed to allocate descriptor sets!");
        
        write();
    }

    void DescriptorSetHandler::push(TexturedImage* image, uint32_t binding)
    {
        VkDescriptorImageInfo imageInfo = {};
        imageInfo.imageLayout           = image->getLayout();
        imageInfo.imageView             = image->getView();
        imageInfo.sampler               = image->getSampler();

        VkWriteDescriptorSet write      = {};
        write.sType                     = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
        write.descriptorCount           = 1;
        write.descriptorType            = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;
        write.dstArrayElement           = 0;
        write.dstBinding                = binding;

        m_imageInfos.push_back(imageInfo);
        m_writes.push_back(write);
    }

    void DescriptorSetHandler::write()
    {
        for (size_t i = 0; i < m_writes.size(); i++)
        {
            m_writes[i].dstSet                    = m_set;
            m_writes[i].pImageInfo                = &m_imageInfos[i];
        }

        vkUpdateDescriptorSets(m_device->get(), m_writes.size(), m_writes.data(), 0, nullptr);
    }

    void DescriptorSetHandler::bind(VkCommandBuffer cmdBuf, VkPipelineLayout pipelineLayout)
    {
        vkCmdBindDescriptorSets(cmdBuf, VK_PIPELINE_BIND_POINT_GRAPHICS, pipelineLayout, 0, 1, &m_set, 0, nullptr);
    }
}