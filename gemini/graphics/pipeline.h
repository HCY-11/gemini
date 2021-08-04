#pragma once

#include "graphics/render_pass.h"
#include "graphics/entities/vertex.h"
#include "graphics/shader.h"

namespace gm
{
    struct PipelineInfo
    {
        std::vector<VkPipelineShaderStageCreateInfo>        shaderStageInfos            = {};
        std::vector<VkDescriptorSetLayoutBinding>           layoutBindings              = {};
        std::vector<VkDescriptorPoolSize>                   poolSizes                   = {};

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

    class Pipeline
    {
    public:
        Pipeline(GPU* gpu, Device* device, Swapchain* swapchain, RenderPass* renderPass);

        ~Pipeline();

        void addShader(Shader* shader);

        void populateVertexInputStateInfo();

        void populateInputAssemblyStateInfo(
                                        VkPrimitiveTopology topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST, 
                                        VkBool32 primitiveRestartEnable = VK_FALSE);
        
        void populateViewportStateInfo();

        void populateRasterizationStateInfo(
                                        VkPolygonMode polygonMode = VK_POLYGON_MODE_FILL, 
#ifdef NDEBUG
                                        VkCullModeFlagBits cullMode = VK_CULL_MODE_BACK_BIT,
#else
                                        VkCullModeFlagBits cullMode = VK_CULL_MODE_NONE,
#endif
                                        float lineWidth = 1.0f);
                                        
        void populateMultiSampleStateInfo();

        void populateDepthStencilStateInfo(
                                        VkBool32 shouldDepthTest = VK_TRUE, 
                                        VkBool32 shouldDepthWrite = VK_TRUE);

        void populateColorBlendAttachmentStateInfo();

        void populateColorBlendStateInfo();

        void populateDynamicStateInfo();

        // Acts as replacement for populate* functions with the exception of shader stages; uses default parameters
        void populateStateInfosDefault();

        // Can only be called once all other create* functions are called.
        void build();

        inline const VkPipeline& get() const { return m_pipeline; }

        inline const VkPipelineLayout& getLayout() const { return m_layout; }

        inline const VkDescriptorPool& getDescriptorPool() const { return m_descriptorPool; }

        inline const VkDescriptorSetLayout& getDescriptorSetLayout() const { return m_setLayout; }

    private:
        void createDescriptorSetObjects();

    private:
        GPU*                        m_gpu               = nullptr;
        Device*                     m_device            = nullptr;
        Swapchain*                  m_swapchain         = nullptr;
        RenderPass*                 m_renderPass        = nullptr;

        VkPipeline                  m_pipeline          = VK_NULL_HANDLE;
        VkPipelineLayout            m_layout            = VK_NULL_HANDLE;

        VkDescriptorPool            m_descriptorPool    = VK_NULL_HANDLE;
        VkDescriptorSetLayout       m_setLayout         = VK_NULL_HANDLE;

        PipelineInfo                m_info              = {};
    };
}
