#include "graphics_layer.h"

#include "graphics/math/math.h"

namespace gm
{
    GraphicsLayer::GraphicsLayer(Window* window, Camera& camera, Light& light, uint32_t framesInFlight, const std::string& name) :
        Layer(name),
        m_window(window),
        m_camera(camera),
        m_light(light),
        m_instance(new Instance()), 
        m_surface(new Surface(m_window, m_instance.get())), 
        m_gpu(new GPU(m_instance.get(), m_surface.get())),
        m_device(new Device(m_instance.get(), m_gpu.get())),
        m_framesInFlight(framesInFlight)
    {
        createAllocator();

        m_depthImage = new DepthImage(m_window, m_gpu.get(), m_device.get(), m_allocator);

        m_swapchain = makeScope<Swapchain>(m_window, m_surface.get(), m_gpu.get(), m_device.get());
        m_renderPass = makeScope<RenderPass>(m_device.get(), m_swapchain.get(), m_depthImage);
        m_framebuffers = makeScope<Framebuffers>(m_device.get(), m_renderPass.get(), m_swapchain.get(), m_depthImage, m_swapchain->getImageViews().size());
        m_commandPool = makeScope<CommandPool>(m_gpu.get(), m_device.get());

        m_commandBuffers.resize(m_swapchain->getImageViews().size());
        m_commandPool->allocateCommandBuffers(VK_COMMAND_BUFFER_LEVEL_PRIMARY, m_commandBuffers.size(), m_commandBuffers.data());

        buildGraphicsPipeline();

        createSyncObjects();

        m_projectionViewMatrix = Math::createProjectionViewMatrix(m_window, m_camera);
    }

    GraphicsLayer::~GraphicsLayer()
    {
        vkDeviceWaitIdle(m_device->get());

        for (const auto& object : m_renderObjects)
        {
            delete object;
        }

        delete m_depthImage;

        vmaDestroyAllocator(m_allocator);

        m_commandPool->freeCommandBuffers(m_commandBuffers.size(), m_commandBuffers.data());

        for (uint32_t i = 0; i < m_framesInFlight; i++)
        {
            vkDestroySemaphore(m_device->get(), m_imageAvailableSemaphores[i], nullptr);
            vkDestroySemaphore(m_device->get(), m_renderFinishedSemaphores[i], nullptr);

            vkDestroyFence(m_device->get(), m_inFlightFences[i], nullptr);
        }
    }

    void GraphicsLayer::onUpdate()
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

        VkClearValue clearColor                     = {};
        clearColor.color                            = { 0.0f, 0.0f, 0.0f, 1.0f };

        VkClearValue clearDepth                     = {};
        clearDepth.depthStencil.depth               = 1.0f;

        VkClearValue clearValues[]                  = { clearColor, clearDepth };

        GM_CORE_ASSERT(vkBeginCommandBuffer(m_commandBuffers[imageIndex], &cmdBeginInfo) == VK_SUCCESS, "Failed to begin command buffer!");

        VkRenderPassBeginInfo passBeginInfo         = {};
        passBeginInfo.sType                         = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
        passBeginInfo.renderPass                    = m_renderPass->get();
        passBeginInfo.clearValueCount               = 2;
        passBeginInfo.pClearValues                  = clearValues;
        passBeginInfo.framebuffer                   = m_framebuffers->get()[imageIndex];
        passBeginInfo.renderArea.offset             = { 0, 0 };
        passBeginInfo.renderArea.extent             = m_swapchain->getExtent();


        vkCmdBeginRenderPass(m_commandBuffers[imageIndex], &passBeginInfo, VK_SUBPASS_CONTENTS_INLINE);

        for (auto& object : m_renderObjects)
        {
            vkCmdBindPipeline(m_commandBuffers[imageIndex], VK_PIPELINE_BIND_POINT_GRAPHICS, m_graphicsPipeline->get());

            VkDeviceSize offset = 0;
            vkCmdBindVertexBuffers(m_commandBuffers[imageIndex], 0, 1, &object->getVBO().get(), &offset);

            vkCmdBindIndexBuffer(m_commandBuffers[imageIndex], object->getIBO().get(), 0, VK_INDEX_TYPE_UINT16);

            object->getSetHandler().bind(m_commandBuffers[imageIndex], m_graphicsPipeline->getLayout());

            PushConstant pushConstant = { Math::createModelMatrix(object->getEntity()), m_projectionViewMatrix };
            vkCmdPushConstants(m_commandBuffers[imageIndex], m_graphicsPipeline->getLayout(), VK_SHADER_STAGE_VERTEX_BIT, 0, sizeof(PushConstant), &pushConstant);

            vkCmdDrawIndexed(m_commandBuffers[imageIndex], object->getIBO().getNumIndices(), 1, object->getIBO().getFirstIndex(), 0, 0);

            object->updateUniformBuffer(m_camera, m_light);
        }

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

    void GraphicsLayer::onEvent(Event& e)
    {
        if (e.getType() == EventType::kEntityAdd)
        {
            m_renderObjects.push_back(
                new RenderObject(
                    static_cast<EntityAddEvent&>(e).getData(), 
                    m_gpu.get(), 
                    m_device.get(), 
                    m_graphicsPipeline.get(), 
                    m_commandPool.get(), 
                    m_allocator,
                    m_camera,
                    m_light)
            );
        }
    }

    void GraphicsLayer::buildGraphicsPipeline()
    {
        m_graphicsPipeline = makeScope<Pipeline>(m_gpu.get(), m_device.get(), m_swapchain.get(), m_renderPass.get());

        m_graphicsPipeline->addShader(new Shader(m_device.get(), "gemini/graphics/shaders/vert.spv", VK_SHADER_STAGE_VERTEX_BIT));
        m_graphicsPipeline->addShader(new Shader(m_device.get(), "gemini/graphics/shaders/frag.spv", VK_SHADER_STAGE_FRAGMENT_BIT));

        m_graphicsPipeline->build();
    }

    void GraphicsLayer::createAllocator()
    {
        VmaAllocatorCreateInfo createInfo       = {};
        createInfo.instance                     = m_instance->get();
        createInfo.device                       = m_device->get();
        createInfo.physicalDevice               = m_gpu->get();

        GM_CORE_ASSERT(vmaCreateAllocator(&createInfo, &m_allocator) == VK_SUCCESS, 
                       "Failed to create allocator!");
    }

    void GraphicsLayer::createSyncObjects()
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

    void GraphicsLayer::recreateSwapchain()
    {
        vkDeviceWaitIdle(m_device->get());

        // Destroy
        m_framebuffers.reset();

        delete m_depthImage;

        m_commandPool->freeCommandBuffers(m_commandBuffers.size(), m_commandBuffers.data());

        m_graphicsPipeline.reset();

        m_renderPass.reset();

        m_swapchain.reset();


        // Recreate
        m_swapchain = makeScope<Swapchain>(m_window, m_surface.get(), m_gpu.get(), m_device.get());

        m_depthImage = new DepthImage(m_window, m_gpu.get(), m_device.get(), m_allocator);

        m_renderPass = makeScope<RenderPass>(m_device.get(), m_swapchain.get(), m_depthImage);

        buildGraphicsPipeline();

        for (auto& object : m_renderObjects)
        {
            object->initDescriptorSets(m_graphicsPipeline.get());
        }

        m_framebuffers = makeScope<Framebuffers>(m_device.get(), m_renderPass.get(), m_swapchain.get(), m_depthImage, m_swapchain->getImageViews().size());

        m_commandPool->allocateCommandBuffers(VK_COMMAND_BUFFER_LEVEL_PRIMARY, m_commandBuffers.size(), m_commandBuffers.data());

        m_imagesInFlightFences.resize(m_swapchain->getImageViews().size(), VK_NULL_HANDLE);

        m_projectionViewMatrix = Math::createProjectionViewMatrix(m_window, m_camera);
    }
}
