#include "framebuffers.h"

namespace gm
{
    Framebuffers::Framebuffers(Device* device, RenderPass* renderPass, Swapchain* swapchain, Image* depthImage, size_t size) : m_device(device)
    {
        m_data.resize(swapchain->getImageViews().size());

        for (uint32_t i = 0; i < m_data.size(); i++)
        {
            VkImageView attachments[]               = { swapchain->getImageViews().data()[i], depthImage->getView() };

            VkFramebufferCreateInfo bufferInfo      = {};
            bufferInfo.sType                        = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
            bufferInfo.renderPass                   = renderPass->get();
            bufferInfo.attachmentCount              = 2;
            bufferInfo.pAttachments                 = attachments;
            bufferInfo.width                        = swapchain->getExtent().width;
            bufferInfo.height                       = swapchain->getExtent().height;
            bufferInfo.layers                       = 1;

            GM_CORE_ASSERT(vkCreateFramebuffer(m_device->get(), &bufferInfo, nullptr, &m_data[i]) == VK_SUCCESS,
                            "Failed to create framebuffer!");
        }
    }

    Framebuffers::~Framebuffers()
    {
        for (const auto& buf : m_data)
        {
            vkDestroyFramebuffer(m_device->get(), buf, nullptr);
        }
    }
}