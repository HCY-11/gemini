#pragma once

#include "core/core.h"

#include "graphics/device.h"

namespace gm
{
    class Shader
    {
    public:
        Shader(Device* device, const std::filesystem::path& filePath, VkShaderStageFlagBits shaderStage);
        ~Shader() = default;

        inline const VkShaderModule& getModule() const { return m_module; }

        inline const VkShaderStageFlagBits& getStage() const { return m_stage; }

        inline const std::vector<VkPushConstantRange>& getPushConstantRanges() const { return m_pushConstantRange; }

        inline const std::vector<VkDescriptorSetLayoutBinding>& getSetLayoutBindings() const { return m_setLayoutBindings; }

        inline const std::vector<VkDescriptorPoolSize>& getDescriptorPoolSizes() const { return m_descriptorPoolSizes; }

    private:
        void createShaderModule(Device* device, const uint32_t* code, uint32_t codeSize);

        std::vector<char> readFromFile(const std::filesystem::path& filePath);

    private:
        VkShaderStageFlagBits                       m_stage                     = {};

        VkShaderModule                              m_module                    = VK_NULL_HANDLE;

        std::vector<VkDescriptorSetLayoutBinding>   m_setLayoutBindings         = {};
        std::vector<VkDescriptorPoolSize>           m_descriptorPoolSizes       = {};
        std::vector<VkPushConstantRange>            m_pushConstantRange         = {}; // Only one push constant range supported ATM
    };
}
