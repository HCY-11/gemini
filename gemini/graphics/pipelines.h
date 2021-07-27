#pragma once

#include "graphics/device.h"
#include "graphics/swapchain.h"
#include "graphics/render_pass.h"

namespace gm
{
    struct PipelineInfo
    {
        std::vector<VkPipelineShaderStageCreateInfo>        shaderStageInfos = {};
        std::vector<const char*>                            shaderFilePaths = {};

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

        ~Pipeline() = default;
    };

    class PipelineBuilder
    {
    public:
        static void addShaderStage(PipelineInfo* info, VkShaderStageFlagBits stage, const char* filePath);

        static void populateVertexInputStateInfo(PipelineInfo* info);

        static void populateInputAssemblyStateInfo(
                                        PipelineInfo* info, 
                                        VkPrimitiveTopology topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST, 
                                        VkBool32 primitiveRestartEnable = VK_FALSE);
        
        static void populateViewportStateInfo(PipelineInfo* info, Swapchain* swapchain);

        static void populateRasterizationStateInfo(
                                        PipelineInfo* info,
                                        VkPolygonMode polygonMode = VK_POLYGON_MODE_FILL, 
                                        VkCullModeFlagBits cullMode = VK_CULL_MODE_BACK_BIT, 
                                        float lineWidth = 1.0f);
                                        
        static void populateMultiSampleStateInfo(PipelineInfo* info);

        static void populateDepthStencilStateInfo(PipelineInfo* info);

        static void populateColorBlendAttachmentStateInfo(PipelineInfo* info);

        static void populateColorBlendStateInfo(PipelineInfo* info);

        static void populateDynamicStateInfo(PipelineInfo* info);

        // Acts as replacement for populate* functions with the exception of shader stages; uses default parameters
        static void populateStateInfosDefault(PipelineInfo* info, Swapchain* swapchain);

        // Can only be called once all other create* functions are called.
        static void buildPipeline(Device* device, RenderPass* renderPass, Pipeline* dst);

        static void destroyPipeline(Device* device, Pipeline* pipeline);

    private:
        static VkShaderModule createShaderModule(Device* device, const char* filePath);
    };
}
