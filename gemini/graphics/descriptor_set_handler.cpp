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
    }

    void DescriptorSetHandler::addSampler(TexturedImage* image, uint32_t binding)
    {
        VkDescriptorImageInfo imageInfo = {};
        imageInfo.imageLayout           = image->getLayout();
        imageInfo.imageView             = image->getView();
        imageInfo.sampler               = image->getSampler();

        m_imageInfos.push_back(imageInfo);

        VkWriteDescriptorSet write      = {};
        write.sType                     = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
        write.descriptorCount           = 1;
        write.descriptorType            = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;
        write.dstArrayElement           = 0;
        write.dstBinding                = binding;

        m_writes.push_back(write);
    }

    void DescriptorSetHandler::addUniformBuffer(UniformBuffer* buffer, uint32_t binding)
    {
        VkDescriptorBufferInfo bufferInfo   = {};
        bufferInfo.buffer                   = buffer->get();
        bufferInfo.offset                   = m_bufferOffset;
        bufferInfo.range                    = buffer->getSize();

        m_bufferInfos.push_back(bufferInfo);

        VkWriteDescriptorSet write          = {};
        write.sType                         = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
        write.descriptorCount               = 1;
        write.descriptorType                = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
        write.dstArrayElement               = 0;
        write.dstBinding                    = binding;

        m_writes.push_back(write);
    }

    void DescriptorSetHandler::write()
    {
        uint32_t imageInfoIndex = 0;
        uint32_t bufferInfoIndex = 0;

        for (auto& write : m_writes)
        {
            switch (write.descriptorType)
            {
                case VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER:
                    write.pImageInfo              = &m_imageInfos[imageInfoIndex];
                    imageInfoIndex++;
                    break;
                case VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER:
                    write.pBufferInfo             = &m_bufferInfos[bufferInfoIndex];
                    bufferInfoIndex++;
                    break;
                default:
                    GM_CORE_ERROR("Unsupported descriptor type {0} added!", write.descriptorType);
                    break;
            }

            write.dstSet = m_set;
        }

        vkUpdateDescriptorSets(m_device->get(), m_writes.size(), m_writes.data(), 0, nullptr);
    }

    void DescriptorSetHandler::bind(VkCommandBuffer cmdBuf, VkPipelineLayout pipelineLayout)
    {
        vkCmdBindDescriptorSets(cmdBuf, VK_PIPELINE_BIND_POINT_GRAPHICS, pipelineLayout, 0, 1, &m_set, 0, nullptr);
    }
}