#include "descriptor_set.h"

namespace gm
{
    DescriptorSet::DescriptorSet(Device* device, Pipeline* pipeline, const TexturedImage& image, uint32_t binding, uint32_t count) : m_device(device)
    {
        init(device, pipeline, image, binding, count);
    }

    DescriptorSet::DescriptorSet(Device* device, Pipeline* pipeline, const Buffer& buffer, uint32_t binding, uint32_t count)
    {
        init(device, pipeline, buffer, binding, count);
    }

    // TODO: Refactor!
    void DescriptorSet::init(Device* device, Pipeline* pipeline, const TexturedImage& image, uint32_t binding, uint32_t count)
    {
        m_device = device;

        m_sets.resize(count);
        std::vector<VkDescriptorSetLayout> setLayouts(count, pipeline->getDescriptorSetLayout());

        VkDescriptorSetAllocateInfo allocInfo       = {};
        allocInfo.sType                             = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
        allocInfo.descriptorPool                    = pipeline->getDescriptorPool();
        allocInfo.descriptorSetCount                = count;
        allocInfo.pSetLayouts                       = setLayouts.data();

        GM_CORE_ASSERT(vkAllocateDescriptorSets(device->get(), &allocInfo, m_sets.data()) == VK_SUCCESS,
                       "Failed to create descriptor set!");

        m_imageInfo.imageLayout             = image.getLayout();
        m_imageInfo.imageView               = image.getView();
        m_imageInfo.sampler                 = image.getSampler();

        m_writes.resize(m_sets.size());

        for (size_t i = 0; i < m_writes.size(); i++)
        {
            m_writes[i].sType                       = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
            m_writes[i].descriptorCount             = 1;
            m_writes[i].descriptorType              = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;
            m_writes[i].dstArrayElement             = 0;
            m_writes[i].dstBinding                  = binding;
            m_writes[i].dstSet                      = m_sets[i];
            m_writes[i].pImageInfo                  = &m_imageInfo;
            m_writes[i].pBufferInfo                 = nullptr;
            m_writes[i].pTexelBufferView            = nullptr;
            m_writes[i].pNext                       = nullptr;
        }

        vkUpdateDescriptorSets(device->get(), m_writes.size(), m_writes.data(), 0, nullptr);
    }

    void DescriptorSet::init(Device* device, Pipeline* pipeline, const Buffer& buffer, uint32_t binding, uint32_t count)
    {
        m_device = device;

        VkDescriptorSetAllocateInfo allocInfo       = {};
        allocInfo.sType                             = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
        allocInfo.descriptorPool                    = pipeline->getDescriptorPool();
        allocInfo.descriptorSetCount                = count;
        allocInfo.pSetLayouts                       = &pipeline->getDescriptorSetLayout();

        GM_CORE_ASSERT(vkAllocateDescriptorSets(device->get(), &allocInfo, m_sets.data()) == VK_SUCCESS,
                       "Failed to create descriptor set!");

        m_bufferInfo.buffer                         = buffer.get();
        m_bufferInfo.offset                         = 0;
        m_bufferInfo.range                          = buffer.getSize();

        m_writes.resize(m_sets.size());

        for (size_t i = 0; i < m_writes.size(); i++)
        {
            m_writes[i].sType                       = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
            m_writes[i].descriptorCount             = 1;
            m_writes[i].descriptorType              = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;
            m_writes[i].dstArrayElement             = 0;
            m_writes[i].dstBinding                  = binding;
            m_writes[i].dstSet                      = m_sets[i];
            m_writes[i].pBufferInfo                 = &m_bufferInfo;
            m_writes[i].pImageInfo                  = nullptr;
            m_writes[i].pTexelBufferView            = nullptr;
            m_writes[i].pNext                       = nullptr;
        }

        vkUpdateDescriptorSets(device->get(), m_writes.size(), m_writes.data(), 0, nullptr);
    }
}