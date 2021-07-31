#include "graphics_layer.h"

#include "graphics/math/math.h"

namespace gm
{
    GraphicsLayer::GraphicsLayer(Window* window, Camera& camera, uint32_t framesInFlight, const std::string& name) :
        Layer(name),
        m_window(window),
        m_camera(camera),
        m_instance(new Instance()), 
        m_surface(new Surface(m_window, m_instance.get())), 
        m_gpu(new GPU(m_instance.get(), m_surface.get())),
        m_device(new Device(m_instance.get(), m_gpu.get())),

        // TODO: Get rid of allocator class and just use previous createAllocator()
        // Move allocator dependent/depth image dependant resources into constructor body
        m_allocator(new Allocator(m_instance.get(), m_gpu.get(), m_device.get())),

        // TODO: Make this its own class and add function to find supported formats
        m_depthImage(new Image(
            m_window,
            m_device.get(),
            m_allocator,
            VMA_MEMORY_USAGE_GPU_ONLY,
            VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT,
            VK_IMAGE_TYPE_2D,
            VK_FORMAT_D32_SFLOAT,
            VK_SAMPLE_COUNT_1_BIT,
            VK_IMAGE_TILING_OPTIMAL,
            VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT,
            VK_IMAGE_ASPECT_DEPTH_BIT
        )),
        m_swapchain(new Swapchain(m_window, m_surface.get(), m_gpu.get(), m_device.get())),
        m_renderPass(new RenderPass(m_device.get(), m_swapchain.get(), m_depthImage)),
        m_framebuffers(new Framebuffers(m_device.get(), m_renderPass.get(), m_swapchain.get(), m_depthImage, m_swapchain->getImageViews().size())),
        m_commandPool(new CommandPool(m_gpu.get(), m_device.get())),
        m_framesInFlight(framesInFlight)
    {
        m_commandBuffers.resize(m_swapchain->getImageViews().size());
        m_commandPool->allocateCommandBuffers(VK_COMMAND_BUFFER_LEVEL_PRIMARY, m_commandBuffers.size(), m_commandBuffers.data());

        buildPipelines();

        createSyncObjects();

        m_projectionViewMatrix = Math::createProjectionViewMatrix(m_window, m_camera);
    }

    GraphicsLayer::~GraphicsLayer()
    {
        vkDeviceWaitIdle(m_device->get());

        for (const auto& entity : m_entities)
        {
            delete entity;
        }

        delete m_depthImage;

        delete m_allocator;

        m_commandPool->freeCommandBuffers(m_commandBuffers.size(), m_commandBuffers.data());

        PipelineBuilder::destroyPipeline(m_device.get(), &m_rasterizerPipeline);

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
        clearColor.color                            = { 1.0f, 1.0f, 1.0f, 1.0f };

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

        vkCmdBindPipeline(m_commandBuffers[imageIndex], VK_PIPELINE_BIND_POINT_GRAPHICS, m_rasterizerPipeline.value);

        for (const auto& entity : m_entities)
        {
            VkDeviceSize offset = 0;
            vkCmdBindVertexBuffers(m_commandBuffers[imageIndex], 0, 1, &entity->getVBO().get(), &offset);

            vkCmdBindIndexBuffer(m_commandBuffers[imageIndex], entity->getIBO().get(), 0, VK_INDEX_TYPE_UINT16);

            EntityPushConstant pushConstant = { m_projectionViewMatrix * Math::createModelMatrix(entity) };
            vkCmdPushConstants(m_commandBuffers[imageIndex], m_rasterizerPipeline.layout, VK_SHADER_STAGE_VERTEX_BIT, 0, sizeof(EntityPushConstant), &pushConstant);

            vkCmdDrawIndexed(m_commandBuffers[imageIndex], entity->getIBO().getNumIndices(), 1, entity->getIBO().getFirstIndex(), 0, 0);
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
            Entity* newEntity = static_cast<EntityAddEvent&>(e).getData();
            newEntity->loadMesh(m_device.get(), m_commandPool.get(), m_allocator);
            m_entities.push_back(newEntity);
        }
    }

    void GraphicsLayer::buildPipelines()
    {
        PipelineBuilder::addShaderStage(&m_pipelineInfo, VK_SHADER_STAGE_VERTEX_BIT, "gemini/graphics/shaders/vert.spv");
        PipelineBuilder::addShaderStage(&m_pipelineInfo, VK_SHADER_STAGE_FRAGMENT_BIT, "gemini/graphics/shaders/frag.spv");

        PipelineBuilder::populateStateInfosDefault(&m_pipelineInfo, m_swapchain.get());

        PipelineBuilder::addPushConstant(&m_pipelineInfo, sizeof(EntityPushConstant), VK_SHADER_STAGE_VERTEX_BIT);

        PipelineBuilder::buildPipeline(&m_pipelineInfo, m_device.get(), m_renderPass.get(), &m_rasterizerPipeline);
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

        m_commandPool->freeCommandBuffers(m_commandBuffers.size(), m_commandBuffers.data());

        PipelineBuilder::destroyPipeline(m_device.get(), &m_rasterizerPipeline);

        m_renderPass.reset();

        m_swapchain.reset();


        // Recreate
        m_swapchain = makeScope<Swapchain>(m_window, m_surface.get(), m_gpu.get(), m_device.get());

        m_renderPass = makeScope<RenderPass>(m_device.get(), m_swapchain.get(), m_depthImage);

        PipelineBuilder::populateViewportStateInfo(&m_pipelineInfo, m_swapchain.get());

        PipelineBuilder::buildPipeline(&m_pipelineInfo, m_device.get(), m_renderPass.get(), &m_rasterizerPipeline);

        m_framebuffers = makeScope<Framebuffers>(m_device.get(), m_renderPass.get(), m_swapchain.get(), m_depthImage, m_swapchain->getImageViews().size());

        m_commandPool->allocateCommandBuffers(VK_COMMAND_BUFFER_LEVEL_PRIMARY, m_commandBuffers.size(), m_commandBuffers.data());

        m_imagesInFlightFences.resize(m_swapchain->getImageViews().size(), VK_NULL_HANDLE);

        m_projectionViewMatrix = Math::createProjectionViewMatrix(m_window, m_camera);
    }
}
