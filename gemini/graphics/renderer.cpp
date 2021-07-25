#include "renderer.h"
#include "logging/logger.h"

namespace gm
{
    Renderer::Renderer(
            Window* window, 
            RenderPass* renderPass,
            Swapchain* swapchain,
            Pipeline* pipeline,
            Device* device,
            GPU* gpu,
            Surface* surface,
            uint32_t framesInFlight) :
        m_window(window),
        m_renderPass(renderPass),
        m_swapchain(swapchain),
        m_pipeline(pipeline),
        m_device(device),
        m_gpu(gpu),
        m_surface(surface),
        m_framesInFlight(framesInFlight)
    {
        createFramebuffers();
        createCommandPool();
        allocateCommandBuffers();
        createSyncObjects();
    }

    Renderer::~Renderer()
    {
        vkDestroyCommandPool(m_device->get(), m_commandPool, nullptr);

        for (uint32_t i = 0; i < m_framesInFlight; i++)
        {
            vkDestroySemaphore(m_device->get(), m_imageAvailableSemaphores[i], nullptr);
            vkDestroySemaphore(m_device->get(), m_renderFinishedSemaphores[i], nullptr);

            vkDestroyFence(m_device->get(), m_inFlightFences[i], nullptr);
        }
    }

    void Renderer::draw()
    {
        vkWaitForFences(m_device->get(), 1, &m_inFlightFences[m_currentFrame], VK_TRUE, UINT64_MAX);

        uint32_t imageIndex;
        VkResult result = vkAcquireNextImageKHR(m_device->get(), m_swapchain->get(), UINT64_MAX, m_imageAvailableSemaphores[m_currentFrame], VK_NULL_HANDLE, &imageIndex);
        if (result == VK_ERROR_OUT_OF_DATE_KHR)
        {
            recreateSwapchain();
            return;
        }
        else if (result != VK_SUCCESS && result != VK_SUBOPTIMAL_KHR)
        {
            GM_CORE_ERROR("Acquiring image failed!");
        }

        if (m_imagesInFlightFences[imageIndex] != VK_NULL_HANDLE)
        {
            vkWaitForFences(m_device->get(), 1, &m_imagesInFlightFences[imageIndex], VK_TRUE, UINT64_MAX);
        }

        m_imagesInFlightFences[imageIndex] = m_inFlightFences[m_currentFrame];

        VkCommandBufferBeginInfo cmdBeginInfo       = {};
        cmdBeginInfo.sType                          = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
        cmdBeginInfo.flags                          = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;

        VkClearValue clearColor                     = { 1.0, 1.0, 1.0, 1.0 };

        GM_CORE_ASSERT(vkBeginCommandBuffer(m_commandBuffers[imageIndex], &cmdBeginInfo) == VK_SUCCESS, "Failed to begin command buffer!");

        VkRenderPassBeginInfo passBeginInfo         = {};
        passBeginInfo.sType                         = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
        passBeginInfo.renderPass                    = m_renderPass->get();
        passBeginInfo.clearValueCount               = 1;
        passBeginInfo.pClearValues                  = &clearColor;
        passBeginInfo.framebuffer                   = m_framebuffers[imageIndex];
        passBeginInfo.renderArea.offset             = { 0, 0 };
        passBeginInfo.renderArea.extent             = m_swapchain->getExtent();


        vkCmdBeginRenderPass(m_commandBuffers[imageIndex], &passBeginInfo, VK_SUBPASS_CONTENTS_INLINE);

        vkCmdBindPipeline(m_commandBuffers[imageIndex], VK_PIPELINE_BIND_POINT_GRAPHICS, m_pipeline->value);

        vkCmdDraw(m_commandBuffers[imageIndex], 3, 1, 0, 0);

        vkCmdEndRenderPass(m_commandBuffers[imageIndex]);

        GM_CORE_ASSERT(vkEndCommandBuffer(m_commandBuffers[imageIndex]) == VK_SUCCESS, "Failed to end command buffer!");


        VkSubmitInfo submitInfo                     = {};
        submitInfo.sType                            = VK_STRUCTURE_TYPE_SUBMIT_INFO;
        submitInfo.commandBufferCount               = 1;
        submitInfo.pCommandBuffers                  = &m_commandBuffers[imageIndex];

        submitInfo.signalSemaphoreCount             = 1;
        submitInfo.pSignalSemaphores                = &m_renderFinishedSemaphores[m_currentFrame];

        submitInfo.waitSemaphoreCount               = 1;
        submitInfo.pWaitSemaphores                  = &m_imageAvailableSemaphores[m_currentFrame];

        VkPipelineStageFlags waitStage              = VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT;

        submitInfo.pWaitDstStageMask                = &waitStage;

        vkResetFences(m_device->get(), 1, &m_inFlightFences[m_currentFrame]);

        GM_CORE_ASSERT(vkQueueSubmit(m_device->getGraphicsQueue(), 1, &submitInfo, m_inFlightFences[m_currentFrame]) == VK_SUCCESS,
                        "Failed to submit command buffer!");

        VkPresentInfoKHR presentInfo                = {};
        presentInfo.sType                           = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
        presentInfo.swapchainCount                  = 1;
        presentInfo.pSwapchains                     = &m_swapchain->get();
        presentInfo.waitSemaphoreCount              = 1;
        presentInfo.pWaitSemaphores                 = &m_renderFinishedSemaphores[m_currentFrame];
        presentInfo.pImageIndices                   = &imageIndex;

        result = vkQueuePresentKHR(m_device->getPresentQueue(), &presentInfo);

        if (result == VK_ERROR_OUT_OF_DATE_KHR || result == VK_SUBOPTIMAL_KHR || m_window->isResized())
        {
            m_window->setIsResized(false);
            recreateSwapchain();
        }
        else if (result != VK_SUCCESS)
        {
            GM_CORE_ERROR("Presentation failed!");
        }

        m_currentFrame = (m_currentFrame + 1) % m_framesInFlight;
    }

    void Renderer::createFramebuffers()
    {
        m_framebuffers.resize(m_swapchain->getImageViews().size());

        for (uint32_t i = 0; i < m_framebuffers.size(); i++)
        {
            VkFramebufferCreateInfo bufferInfo      = {};
            bufferInfo.sType                        = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
            bufferInfo.renderPass                   = m_renderPass->get();
            bufferInfo.attachmentCount              = 1;
            bufferInfo.pAttachments                 = &m_swapchain->getImageViews().data()[i];
            bufferInfo.width                        = m_swapchain->getExtent().width;
            bufferInfo.height                       = m_swapchain->getExtent().height;
            bufferInfo.layers                       = 1;

            GM_CORE_ASSERT(vkCreateFramebuffer(m_device->get(), &bufferInfo, nullptr, &m_framebuffers[i]) == VK_SUCCESS,
                            "Failed to create framebuffer!");
        }
    }

    void Renderer::createSyncObjects()
    {
        VkSemaphoreCreateInfo semaphoreInfo         = {};
        semaphoreInfo.sType                         = VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO;

        m_imageAvailableSemaphores.resize(m_framesInFlight);
        m_renderFinishedSemaphores.resize(m_framesInFlight);

        VkFenceCreateInfo fenceInfo                 = {};
        fenceInfo.sType                             = VK_STRUCTURE_TYPE_FENCE_CREATE_INFO;
        fenceInfo.flags                             = VK_FENCE_CREATE_SIGNALED_BIT;

        m_inFlightFences.resize(m_framesInFlight);
        m_imagesInFlightFences.resize(m_swapchain->getImageViews().size(), VK_NULL_HANDLE);

        for (uint32_t i = 0; i < m_framesInFlight; i++)
        {
            GM_CORE_ASSERT(vkCreateSemaphore(m_device->get(), &semaphoreInfo, nullptr, &m_imageAvailableSemaphores[i]) == VK_SUCCESS, 
                            "Failed to create image avaliable semaphore!");
            GM_CORE_ASSERT(vkCreateSemaphore(m_device->get(), &semaphoreInfo, nullptr, &m_renderFinishedSemaphores[i]) == VK_SUCCESS, 
                            "Failed to create render finished semaphore!");
            
            GM_CORE_ASSERT(vkCreateFence(m_device->get(), &fenceInfo, nullptr, &m_inFlightFences[i]) == VK_SUCCESS,
                            "Failed to create fence!");
        }
    }

    void Renderer::createCommandPool()
    {
        VkCommandPoolCreateInfo poolInfo        = {};
        poolInfo.sType                          = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
        poolInfo.queueFamilyIndex               = m_gpu->getQueueFamilyIndices().graphics.value();
        poolInfo.flags                          = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT |
                                                  VK_COMMAND_POOL_CREATE_TRANSIENT_BIT;

        GM_CORE_ASSERT(vkCreateCommandPool(m_device->get(), &poolInfo, nullptr, &m_commandPool) == VK_SUCCESS,
                        "Failed to create command pool!");
    }

    void Renderer::allocateCommandBuffers()
    {
        m_commandBuffers.resize(m_framebuffers.size());

        VkCommandBufferAllocateInfo allocInfo           = {};
        allocInfo.sType                                 = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
        allocInfo.commandPool                           = m_commandPool;
        allocInfo.commandBufferCount                    = m_commandBuffers.size();
        allocInfo.level                                 = VK_COMMAND_BUFFER_LEVEL_PRIMARY;

        GM_CORE_ASSERT(vkAllocateCommandBuffers(m_device->get(), &allocInfo, m_commandBuffers.data()) == VK_SUCCESS,
                        "Failed to allocate command buffers!");
    }

    void Renderer::recreateSwapchain()
    {
        // TODO: implement this method
    }
}
