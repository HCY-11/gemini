#include "renderpass.h"

#include "util/util.h"

RenderPass::RenderPass()
{

}

RenderPass::~RenderPass()
{

}

void RenderPass::create(const Device& device, const Swapchain& swapchain)
{
    VkAttachmentDescription colorAttachment     = {};
    colorAttachment.format                      = swapchain.getSurfaceFormat().format;
    colorAttachment.samples                     = VK_SAMPLE_COUNT_1_BIT;
    colorAttachment.initialLayout               = VK_IMAGE_LAYOUT_UNDEFINED;
    colorAttachment.finalLayout                 = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;
    colorAttachment.loadOp                      = VK_ATTACHMENT_LOAD_OP_CLEAR;
    colorAttachment.storeOp                     = VK_ATTACHMENT_STORE_OP_STORE;
    colorAttachment.stencilLoadOp               = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
    colorAttachment.stencilStoreOp              = VK_ATTACHMENT_STORE_OP_DONT_CARE;

    VkAttachmentReference colorReference        = {};
    colorReference.attachment                   = 0;
    colorReference.layout                       = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL;

    VkSubpassDescription subpass                = {};
    subpass.colorAttachmentCount                = 1;
    subpass.pColorAttachments                   = &colorReference;

    VkRenderPassCreateInfo renderPassInfo       = {};
    renderPassInfo.sType                        = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
    renderPassInfo.attachmentCount              = 1;
    renderPassInfo.pAttachments                 = &colorAttachment;
    renderPassInfo.subpassCount                 = 1;
    renderPassInfo.pSubpasses                   = &subpass;

    CHECK_VK_RESULT(vkCreateRenderPass(device.get(), &renderPassInfo, nullptr, &m_renderPass),
                    "Failed to create render pass!");
}

void RenderPass::destroy(const Device& device)
{
    vkDestroyRenderPass(device.get(), m_renderPass, nullptr);
}