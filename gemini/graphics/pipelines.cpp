#include "pipelines.h"
#include "logging/logger.h"

namespace gm
{
    void PipelineBuilder::addShaderStage(PipelineInfo* info, VkShaderStageFlagBits stage, const char* filePath)
    {
        VkPipelineShaderStageCreateInfo shaderStageInfo         = {};
        shaderStageInfo.sType                                   = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
        shaderStageInfo.stage                                   = stage;
        shaderStageInfo.pName                                   = "main";

        info->shaderStageInfos.push_back(shaderStageInfo);
        info->shaderFilePaths.push_back(filePath);
    }

    void PipelineBuilder::populateVertexInputStateInfo(PipelineInfo* info)
    {
        info->vertexInputInfo.sType                                = VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;

        info->vertexInputInfo.vertexAttributeDescriptionCount      = info->attributeDescriptions.size();
        info->vertexInputInfo.pVertexAttributeDescriptions         = info->attributeDescriptions.data();

        info->vertexInputInfo.vertexBindingDescriptionCount        = 1;
        info->vertexInputInfo.pVertexBindingDescriptions           = &info->bindingDescription;
    }

    void PipelineBuilder::populateInputAssemblyStateInfo(PipelineInfo* info, VkPrimitiveTopology topology, VkBool32 primitiveRestartEnable)
    {
        info->inputAssemblyInfo.sType                              = VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
        info->inputAssemblyInfo.topology                           = topology;
        info->inputAssemblyInfo.primitiveRestartEnable             = primitiveRestartEnable;
    }

    void PipelineBuilder::populateViewportStateInfo(PipelineInfo* info, Swapchain* swapchain)
    {
        info->viewport.width                                       = static_cast<float>(swapchain->getExtent().width);
        info->viewport.height                                      = -static_cast<float>(swapchain->getExtent().height); // Flip viewport
        info->viewport.x                                           = 0.0f;
        info->viewport.y                                           = static_cast<float>(swapchain->getExtent().height);
        info->viewport.maxDepth                                    = 1.0f;
        info->viewport.minDepth                                    = 0.0f;

        info->scissor.extent                                       = swapchain->getExtent();
        info->scissor.offset                                       = {0, 0};

        info->viewportInfo.sType                                   = VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;
        info->viewportInfo.viewportCount                           = 1;
        info->viewportInfo.pViewports                              = &info->viewport;
        info->viewportInfo.scissorCount                            = 1;
        info->viewportInfo.pScissors                               = &info->scissor;
    }

    void PipelineBuilder::populateRasterizationStateInfo(PipelineInfo* info, VkPolygonMode polygonMode, VkCullModeFlagBits cullMode, float lineWidth)
    {
        info->rasterizationInfo.sType                              = VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
        info->rasterizationInfo.depthBiasEnable                    = VK_FALSE;
        info->rasterizationInfo.depthClampEnable                   = VK_FALSE;
        info->rasterizationInfo.frontFace                          = VK_FRONT_FACE_COUNTER_CLOCKWISE;
        info->rasterizationInfo.lineWidth                          = lineWidth;
        info->rasterizationInfo.polygonMode                        = polygonMode;
        info->rasterizationInfo.cullMode                           = cullMode;
        info->rasterizationInfo.rasterizerDiscardEnable            = VK_FALSE;
    }

    void PipelineBuilder::populateDepthStencilStateInfo(PipelineInfo* info, VkBool32 shouldDepthTest, VkBool32 shouldDepthWrite)
    {
        info->depthStencilInfo.sType                                = VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
        info->depthStencilInfo.stencilTestEnable                    = VK_FALSE;
        info->depthStencilInfo.depthTestEnable                      = shouldDepthTest;
        info->depthStencilInfo.depthWriteEnable                     = shouldDepthWrite;
        info->depthStencilInfo.depthCompareOp                       = VK_COMPARE_OP_LESS;
        info->depthStencilInfo.depthBoundsTestEnable                = VK_FALSE;
    }

    void PipelineBuilder::populateColorBlendAttachmentStateInfo(PipelineInfo* info)
    {
        info->colorAttachment.colorWriteMask                       = VK_COLOR_COMPONENT_R_BIT | 
                                                                      VK_COLOR_COMPONENT_G_BIT | 
                                                                      VK_COLOR_COMPONENT_B_BIT |
                                                                      VK_COLOR_COMPONENT_A_BIT;
        info->colorAttachment.blendEnable                          = VK_TRUE;
        info->colorAttachment.srcAlphaBlendFactor                  = VK_BLEND_FACTOR_ONE;
        info->colorAttachment.dstAlphaBlendFactor                  = VK_BLEND_FACTOR_ZERO;
        info->colorAttachment.alphaBlendOp                         = VK_BLEND_OP_ADD;
        info->colorAttachment.srcColorBlendFactor                  = VK_BLEND_FACTOR_SRC_ALPHA;
        info->colorAttachment.dstColorBlendFactor                  = VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA;
        info->colorAttachment.colorBlendOp                         = VK_BLEND_OP_ADD;
    }

    void PipelineBuilder::populateColorBlendStateInfo(PipelineInfo* info)
    {
        info->colorBlendInfo.sType                                 = VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
        info->colorBlendInfo.attachmentCount                       = 1;
        info->colorBlendInfo.pAttachments                          = &info->colorAttachment;
        info->colorBlendInfo.logicOpEnable                         = VK_FALSE;
    }

    void PipelineBuilder::populateMultiSampleStateInfo(PipelineInfo* info)
    {
        info->multiSampleInfo.sType                                = VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
        info->multiSampleInfo.rasterizationSamples                 = VK_SAMPLE_COUNT_1_BIT;
        info->multiSampleInfo.sampleShadingEnable                  = VK_FALSE;
    }

    void PipelineBuilder::populateDynamicStateInfo(PipelineInfo* info)
    {
        // Not using for now...
    }

    void PipelineBuilder::populateStateInfosDefault(PipelineInfo* info, Swapchain* swapchain)
    {
        populateVertexInputStateInfo(info);
        populateInputAssemblyStateInfo(info);
        populateViewportStateInfo(info, swapchain);
        populateRasterizationStateInfo(info);
        populateDepthStencilStateInfo(info);
        populateMultiSampleStateInfo(info);
        populateColorBlendAttachmentStateInfo(info);
        populateColorBlendStateInfo(info);
        populateDynamicStateInfo(info);
    }

    void PipelineBuilder::addPushConstant(PipelineInfo* info, uint32_t size, VkShaderStageFlags shaderStage)
    {
        VkPushConstantRange pushConstant            = {};
        pushConstant.offset                         = info->pushConstantOffset;
        pushConstant.size                           = size;
        pushConstant.stageFlags                     = shaderStage;

        info->pushConstants.push_back(pushConstant);

        info->pushConstantOffset += size;
    }

    void PipelineBuilder::buildPipeline(PipelineInfo* info, Device* device, RenderPass* renderPass, Pipeline* dst)
    {
        for (uint32_t i = 0; i < info->shaderFilePaths.size(); i++)
        {
            info->shaderStageInfos[i].module = createShaderModule(device, info->shaderFilePaths[i]);
        }

        VkPipelineLayoutCreateInfo layoutInfo       = {};
        layoutInfo.sType                            = VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
        layoutInfo.pushConstantRangeCount           = info->pushConstants.size();
        layoutInfo.pPushConstantRanges              = info->pushConstants.data();
        layoutInfo.setLayoutCount                   = 0;
        layoutInfo.pSetLayouts                      = nullptr;

        GM_CORE_ASSERT(vkCreatePipelineLayout(device->get(), &layoutInfo, nullptr, &dst->layout) == VK_SUCCESS, "Failed to create pipeline layout!");

        VkGraphicsPipelineCreateInfo pipelineInfo   = {};
        pipelineInfo.sType                          = VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
        pipelineInfo.layout                         = dst->layout;
        pipelineInfo.basePipelineHandle             = VK_NULL_HANDLE;
        pipelineInfo.basePipelineIndex              = -1;
        pipelineInfo.renderPass                     = renderPass->get();
        pipelineInfo.subpass                        = 0;
        pipelineInfo.stageCount                     = info->shaderStageInfos.size();
        pipelineInfo.pStages                        = info->shaderStageInfos.data();
        pipelineInfo.pVertexInputState              = &info->vertexInputInfo;
        pipelineInfo.pInputAssemblyState            = &info->inputAssemblyInfo;
        pipelineInfo.pViewportState                 = &info->viewportInfo;
        pipelineInfo.pRasterizationState            = &info->rasterizationInfo;
        pipelineInfo.pMultisampleState              = &info->multiSampleInfo;
        pipelineInfo.pDepthStencilState             = &info->depthStencilInfo;
        pipelineInfo.pColorBlendState               = &info->colorBlendInfo;
        pipelineInfo.pDynamicState                  = nullptr;

        GM_CORE_ASSERT(vkCreateGraphicsPipelines(device->get(), VK_NULL_HANDLE, 1, &pipelineInfo, nullptr, &dst->value) == VK_SUCCESS,
                        "Failed to create graphics pipeline!");

        for (const auto& stageInfo : info->shaderStageInfos)
        {
            vkDestroyShaderModule(device->get(), stageInfo.module, nullptr);
        }
    }

    void PipelineBuilder::destroyPipeline(Device* device, Pipeline* pipeline)
    {
        vkDestroyPipelineLayout(device->get(), pipeline->layout, nullptr);
        vkDestroyPipeline(device->get(), pipeline->value, nullptr);
    }

    VkShaderModule PipelineBuilder::createShaderModule(Device* device, const char* filePath)
    {
        std::string fullPath = static_cast<std::string>(GM_ROOTDIR) + static_cast<std::string>(filePath);
        std::ifstream file(fullPath, std::ios::ate | std::ios::binary);

        if (!file.is_open())
        {
            GM_CORE_ERROR("Failed to find shader file {0}", fullPath);
        }

        size_t fileSize = static_cast<size_t>(file.tellg());

        std::vector<char> byteBuf(fileSize);

        file.seekg(0);

        file.read(byteBuf.data(), fileSize);

        file.close();

        VkShaderModuleCreateInfo moduleInfo     = {};
        moduleInfo.sType                        = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
        moduleInfo.codeSize                     = byteBuf.size();
        moduleInfo.pCode                        = reinterpret_cast<const uint32_t*>(byteBuf.data());

        VkShaderModule shaderModule = VK_NULL_HANDLE;

        GM_CORE_ASSERT(vkCreateShaderModule(device->get(), &moduleInfo, nullptr, &shaderModule) == VK_SUCCESS,
                        "Failed to create shader module!");

        return shaderModule;
    }
}
