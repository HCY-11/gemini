#include "pipeline.h"
#include "logging/logger.h"

namespace gm
{
    Pipeline::Pipeline(GPU* gpu, Device* device, Swapchain* swapchain, RenderPass* renderPass) : 
        m_gpu(gpu), m_device(device), m_swapchain(swapchain), m_renderPass(renderPass)
    {
        populateStateInfosDefault();
    }

    Pipeline::~Pipeline()
    {
        vkDestroyDescriptorSetLayout(m_device->get(), m_setLayout, nullptr);
        vkDestroyDescriptorPool(m_device->get(), m_descriptorPool, nullptr);
        vkDestroyPipelineLayout(m_device->get(), m_layout, nullptr);
        vkDestroyPipeline(m_device->get(), m_pipeline, nullptr);
    }

    void Pipeline::addShader(Shader* shader)
    {
        VkPipelineShaderStageCreateInfo shaderStageInfo         = {};
        shaderStageInfo.sType                                   = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
        shaderStageInfo.stage                                   = shader->getStage();
        shaderStageInfo.pName                                   = "main";
        shaderStageInfo.module                                  = shader->getModule();

        m_info.shaderStageInfos.push_back(shaderStageInfo);
        m_info.layoutBindings.insert(m_info.layoutBindings.end(), shader->getSetLayoutBindings().begin(), shader->getSetLayoutBindings().end());
        m_info.poolSizes.insert(m_info.poolSizes.end(), shader->getDescriptorPoolSizes().begin(), shader->getDescriptorPoolSizes().end());
        m_info.pushConstants.insert(m_info.pushConstants.end(), shader->getPushConstantRanges().begin(), shader->getPushConstantRanges().end());
    }

    void Pipeline::populateVertexInputStateInfo()
    {
        m_info.vertexInputInfo.sType                                = VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;

        m_info.vertexInputInfo.vertexAttributeDescriptionCount      = m_info.attributeDescriptions.size();
        m_info.vertexInputInfo.pVertexAttributeDescriptions         = m_info.attributeDescriptions.data();

        m_info.vertexInputInfo.vertexBindingDescriptionCount        = 1;
        m_info.vertexInputInfo.pVertexBindingDescriptions           = &m_info.bindingDescription;
    }

    void Pipeline::populateInputAssemblyStateInfo(VkPrimitiveTopology topology, VkBool32 primitiveRestartEnable)
    {
        m_info.inputAssemblyInfo.sType                              = VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
        m_info.inputAssemblyInfo.topology                           = topology;
        m_info.inputAssemblyInfo.primitiveRestartEnable             = primitiveRestartEnable;
    }

    void Pipeline::populateViewportStateInfo()
    {
        m_info.viewport.width                                       = static_cast<float>(m_swapchain->getExtent().width);
        m_info.viewport.height                                      = -static_cast<float>(m_swapchain->getExtent().height); // Flip viewport
        m_info.viewport.x                                           = 0.0f;
        m_info.viewport.y                                           = static_cast<float>(m_swapchain->getExtent().height);
        m_info.viewport.maxDepth                                    = 1.0f;
        m_info.viewport.minDepth                                    = 0.0f;

        m_info.scissor.extent                                       = m_swapchain->getExtent();
        m_info.scissor.offset                                       = {0, 0};

        m_info.viewportInfo.sType                                   = VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;
        m_info.viewportInfo.viewportCount                           = 1;
        m_info.viewportInfo.pViewports                              = &m_info.viewport;
        m_info.viewportInfo.scissorCount                            = 1;
        m_info.viewportInfo.pScissors                               = &m_info.scissor;
    }

    void Pipeline::populateRasterizationStateInfo(VkPolygonMode polygonMode, VkCullModeFlagBits cullMode, float lineWidth)
    {
        m_info.rasterizationInfo.sType                              = VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
        m_info.rasterizationInfo.depthBiasEnable                    = VK_FALSE;
        m_info.rasterizationInfo.depthClampEnable                   = VK_FALSE;
        m_info.rasterizationInfo.frontFace                          = VK_FRONT_FACE_COUNTER_CLOCKWISE;
        m_info.rasterizationInfo.lineWidth                          = lineWidth;
        m_info.rasterizationInfo.polygonMode                        = polygonMode;
        m_info.rasterizationInfo.cullMode                           = cullMode;
        m_info.rasterizationInfo.rasterizerDiscardEnable            = VK_FALSE;
    }

    void Pipeline::populateDepthStencilStateInfo(VkBool32 shouldDepthTest, VkBool32 shouldDepthWrite)
    {
        m_info.depthStencilInfo.sType                                = VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
        m_info.depthStencilInfo.stencilTestEnable                    = VK_FALSE;
        m_info.depthStencilInfo.depthTestEnable                      = shouldDepthTest;
        m_info.depthStencilInfo.depthWriteEnable                     = shouldDepthWrite;
        m_info.depthStencilInfo.depthCompareOp                       = VK_COMPARE_OP_LESS;
        m_info.depthStencilInfo.depthBoundsTestEnable                = VK_FALSE;
    }

    void Pipeline::populateColorBlendAttachmentStateInfo()
    {
        m_info.colorAttachment.colorWriteMask                       = VK_COLOR_COMPONENT_R_BIT | 
                                                                      VK_COLOR_COMPONENT_G_BIT | 
                                                                      VK_COLOR_COMPONENT_B_BIT |
                                                                      VK_COLOR_COMPONENT_A_BIT;
        m_info.colorAttachment.blendEnable                          = VK_TRUE;
        m_info.colorAttachment.srcAlphaBlendFactor                  = VK_BLEND_FACTOR_ONE;
        m_info.colorAttachment.dstAlphaBlendFactor                  = VK_BLEND_FACTOR_ZERO;
        m_info.colorAttachment.alphaBlendOp                         = VK_BLEND_OP_ADD;
        m_info.colorAttachment.srcColorBlendFactor                  = VK_BLEND_FACTOR_SRC_ALPHA;
        m_info.colorAttachment.dstColorBlendFactor                  = VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA;
        m_info.colorAttachment.colorBlendOp                         = VK_BLEND_OP_ADD;
    }

    void Pipeline::populateColorBlendStateInfo()
    {
        m_info.colorBlendInfo.sType                                 = VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
        m_info.colorBlendInfo.attachmentCount                       = 1;
        m_info.colorBlendInfo.pAttachments                          = &m_info.colorAttachment;
        m_info.colorBlendInfo.logicOpEnable                         = VK_FALSE;
    }

    void Pipeline::populateMultiSampleStateInfo()
    {
        m_info.multiSampleInfo.sType                                = VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
        m_info.multiSampleInfo.rasterizationSamples                 = VK_SAMPLE_COUNT_1_BIT;
        m_info.multiSampleInfo.sampleShadingEnable                  = VK_FALSE;
    }

    void Pipeline::populateDynamicStateInfo()
    {
        // Not using for now...
    }

    void Pipeline::populateStateInfosDefault()
    {
        populateVertexInputStateInfo();
        populateInputAssemblyStateInfo();
        populateViewportStateInfo();
        populateRasterizationStateInfo();
        populateDepthStencilStateInfo();
        populateMultiSampleStateInfo();
        populateColorBlendAttachmentStateInfo();
        populateColorBlendStateInfo();
        populateDynamicStateInfo();
    }

    void Pipeline::build()
    {
        createDescriptorSetObjects();

        VkPipelineLayoutCreateInfo layoutInfo       = {};
        layoutInfo.sType                            = VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
        layoutInfo.pushConstantRangeCount           = m_info.pushConstants.size();
        layoutInfo.pPushConstantRanges              = m_info.pushConstants.data();
        layoutInfo.setLayoutCount                   = 1;
        layoutInfo.pSetLayouts                      = &m_setLayout;

        GM_CORE_ASSERT(vkCreatePipelineLayout(m_device->get(), &layoutInfo, nullptr, &m_layout) == VK_SUCCESS, 
                       "Failed to create pipeline layout!");

        VkGraphicsPipelineCreateInfo pipelineInfo   = {};
        pipelineInfo.sType                          = VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
        pipelineInfo.layout                         = m_layout;
        pipelineInfo.basePipelineHandle             = VK_NULL_HANDLE;
        pipelineInfo.basePipelineIndex              = -1;
        pipelineInfo.renderPass                     = m_renderPass->get();
        pipelineInfo.subpass                        = 0;
        pipelineInfo.stageCount                     = m_info.shaderStageInfos.size();
        pipelineInfo.pStages                        = m_info.shaderStageInfos.data();
        pipelineInfo.pVertexInputState              = &m_info.vertexInputInfo;
        pipelineInfo.pInputAssemblyState            = &m_info.inputAssemblyInfo;
        pipelineInfo.pViewportState                 = &m_info.viewportInfo;
        pipelineInfo.pRasterizationState            = &m_info.rasterizationInfo;
        pipelineInfo.pMultisampleState              = &m_info.multiSampleInfo;
        pipelineInfo.pDepthStencilState             = &m_info.depthStencilInfo;
        pipelineInfo.pColorBlendState               = &m_info.colorBlendInfo;
        pipelineInfo.pDynamicState                  = nullptr;

        GM_CORE_ASSERT(vkCreateGraphicsPipelines(m_device->get(), VK_NULL_HANDLE, 1, &pipelineInfo, nullptr, &m_pipeline) == VK_SUCCESS,
                        "Failed to create graphics pipeline!");

        for (const auto& stageInfo : m_info.shaderStageInfos)
        {
            vkDestroyShaderModule(m_device->get(), stageInfo.module, nullptr);
        }
    }

    void Pipeline::createDescriptorSetObjects()
    {
        VkDescriptorSetLayoutCreateInfo setInfo     = {};
        setInfo.sType                               = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
        setInfo.bindingCount                        = m_info.layoutBindings.size();
        setInfo.pBindings                           = m_info.layoutBindings.data();

        GM_CORE_ASSERT(vkCreateDescriptorSetLayout(m_device->get(), &setInfo, nullptr, &m_setLayout) == VK_SUCCESS,
                       "Failed to create descriptor set layout!");

        VkDescriptorPoolCreateInfo poolInfo         = {};
        poolInfo.sType                              = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
        poolInfo.maxSets                            = 8192;
        poolInfo.poolSizeCount                      = m_info.poolSizes.size();
        poolInfo.pPoolSizes                         = m_info.poolSizes.data();

        GM_CORE_ASSERT(vkCreateDescriptorPool(m_device->get(), &poolInfo, nullptr, &m_descriptorPool) == VK_SUCCESS,
                       "Failed to create descriptor pool!");
    }
}
