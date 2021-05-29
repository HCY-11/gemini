#pragma once

#include <string>
#include <vector>

#include "device.h"
#include "swapchain.h"
#include "renderpass.h"

struct PipelineInfo
{
    std::vector<VkPipelineShaderStageCreateInfo>        shaderStageInfos;
    std::vector<const char*>                            shaderFilePaths;

    VkPipelineVertexInputStateCreateInfo                vertexInputInfo;
    VkPipelineInputAssemblyStateCreateInfo              inputAssemblyInfo;
    VkPipelineViewportStateCreateInfo                   viewportInfo;
    VkPipelineRasterizationStateCreateInfo              rasterizationInfo;
    VkPipelineMultisampleStateCreateInfo                multiSampleInfo;
    VkPipelineDepthStencilStateCreateInfo               depthStencilInfo;
    VkPipelineColorBlendAttachmentState                 colorAttachment;
    VkPipelineColorBlendStateCreateInfo                 colorBlendInfo;
    VkPipelineDynamicStateCreateInfo                    dynamicStateInfo;

    VkViewport                                          viewport;
    VkRect2D                                            scissor;
};

struct Pipeline
{
    PipelineInfo info;
    VkPipeline value;
    VkPipelineLayout layout;

    Pipeline()
    {
        info            = {};
        value           = VK_NULL_HANDLE;
        layout          = VK_NULL_HANDLE;
    }

    void destroy(const Device& device)
    {
        vkDestroyPipelineLayout(device.get(), layout, nullptr);
        vkDestroyPipeline(device.get(), value, nullptr);
    }
};

class PipelineBuilder
{
public:
    static void addShaderStage(PipelineInfo& info, VkShaderStageFlagBits stage, const char* filePath);

    static void populateVertexInputStateInfo(PipelineInfo& info);

    static void populateInputAssemblyStateInfo(
                                    PipelineInfo& info, 
                                    VkPrimitiveTopology topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST, 
                                    VkBool32 primitiveRestartEnable = VK_FALSE);
    
    static void populateViewportStateInfo(PipelineInfo& info, const Swapchain& swapchain);

    static void populateRasterizationStateInfo(
                                    PipelineInfo& info,
                                    VkPolygonMode polygonMode = VK_POLYGON_MODE_FILL, 
                                    VkCullModeFlagBits cullMode = VK_CULL_MODE_BACK_BIT, 
                                    float lineWidth = 1.0f);
                                    
    static void populateMultiSampleStateInfo(PipelineInfo& info);

    static void populateDepthStencilStateInfo(PipelineInfo& info);

    static void populateColorBlendAttachmentStateInfo(PipelineInfo& info);

    static void populateColorBlendStateInfo(PipelineInfo& info);

    static void populateDynamicStateInfo(PipelineInfo& info);

    // Acts as replacement for populate* functions with the exception of shader stages; uses default parameters
    static void populateStateInfosDefault(PipelineInfo& info, const Swapchain& swapchain);

    // Can only be called once all other create* functions are called.
    static void build(const Device& device, const RenderPass& renderPass, Pipeline& dst0);

    static VkShaderModule createShaderModule(const Device& device, const char* filePath);
};

    
