#pragma once

#include "graphics/render_pass.h"
#include "graphics/entities/vertex.h"

namespace gm
{
    struct PipelineInfo
    {
        std::vector<VkPipelineShaderStageCreateInfo>        shaderStageInfos            = {};
        std::vector<const char*>                            shaderFilePaths             = {};

        std::array<VkVertexInputAttributeDescription, 3>    attributeDescriptions       = Vertex::getAttributeDescriptions();
        VkVertexInputBindingDescription                     bindingDescription          = Vertex::getBindingDescription();

        VkPipelineVertexInputStateCreateInfo                vertexInputInfo;
        VkPipelineInputAssemblyStateCreateInfo              inputAssemblyInfo;
        VkPipelineViewportStateCreateInfo                   viewportInfo;
        VkPipelineRasterizationStateCreateInfo              rasterizationInfo;
        VkPipelineMultisampleStateCreateInfo                multiSampleInfo;
        VkPipelineDepthStencilStateCreateInfo               depthStencilInfo;
        VkPipelineColorBlendAttachmentState                 colorAttachment;
        VkPipelineColorBlendStateCreateInfo                 colorBlendInfo;
        VkPipelineDynamicStateCreateInfo                    dynamicStateInfo;

        std::vector<VkPushConstantRange>                    pushConstants;
        uint32_t                                            pushConstantOffset          = 0;

        VkViewport                                          viewport;
        VkRect2D                                            scissor;
    };

    struct Pipeline
    {
        VkPipeline value;
        VkPipelineLayout layout;

        Pipeline()
        {
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

        // TODO: Eventually, this macro may be removed
        static void populateRasterizationStateInfo(
                                        PipelineInfo* info,
                                        VkPolygonMode polygonMode = VK_POLYGON_MODE_FILL, 
#ifdef NDEBUG
                                        VkCullModeFlagBits cullMode = VK_CULL_MODE_BACK_BIT,
#else
                                        VkCullModeFlagBits cullMode = VK_CULL_MODE_NONE,
#endif
                                        float lineWidth = 1.0f);
                                        
        static void populateMultiSampleStateInfo(PipelineInfo* info);

        static void populateDepthStencilStateInfo(
                                        PipelineInfo* info, 
                                        VkBool32 shouldDepthTest = VK_TRUE, 
                                        VkBool32 shouldDepthWrite = VK_TRUE);

        static void populateColorBlendAttachmentStateInfo(PipelineInfo* info);

        static void populateColorBlendStateInfo(PipelineInfo* info);

        static void populateDynamicStateInfo(PipelineInfo* info);

        // Acts as replacement for populate* functions with the exception of shader stages; uses default parameters
        static void populateStateInfosDefault(PipelineInfo* info, Swapchain* swapchain);

        static void addPushConstant(PipelineInfo* info, uint32_t size, VkShaderStageFlags shaderStage);

        // Can only be called once all other create* functions are called.
        static void buildPipeline(PipelineInfo* info, Device* device, RenderPass* renderPass, Pipeline* dst);

        static void destroyPipeline(Device* device, Pipeline* pipeline);

    private:
        static VkShaderModule createShaderModule(Device* device, const char* filePath);
    };
}
