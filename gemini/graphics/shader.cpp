#include "shader.h"

namespace gm
{
    Shader::Shader(Device* device, const char* filePath, VkShaderStageFlagBits shaderStage) : 
        m_stage(shaderStage)
    {
        std::vector<char> spvChars = readFromFile(filePath);

        // Reflection
        const uint32_t* ptr = reinterpret_cast<const uint32_t*>(spvChars.data());
        size_t numWords = spvChars.size() / sizeof(uint32_t);
        spirv_cross::Compiler compiler(ptr, numWords);

        auto active = compiler.get_active_interface_variables();
        spirv_cross::ShaderResources resources = compiler.get_shader_resources(active);
        compiler.set_enabled_interface_variables(active);

        if (!resources.push_constant_buffers.empty())
        {
            const spirv_cross::SPIRType& type = compiler.get_type(resources.push_constant_buffers[0].base_type_id);

            VkPushConstantRange pushConstantRange   = {};
            pushConstantRange.offset                = compiler.get_decoration(resources.push_constant_buffers[0].id, spv::DecorationOffset);
            pushConstantRange.size                  = compiler.get_declared_struct_size(type);
            pushConstantRange.stageFlags            = m_stage;

            m_pushConstantRange.push_back(pushConstantRange);
        }

        if (!resources.uniform_buffers.empty())
        {
            VkDescriptorPoolSize poolSize   = {};
            poolSize.descriptorCount        = 2048;
            poolSize.type                   = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;

            for (const auto& ubo : resources.uniform_buffers)
            {
                VkDescriptorSetLayoutBinding binding            = {};
                binding.binding                                 = compiler.get_decoration(ubo.id, spv::DecorationBinding);
                binding.descriptorCount                         = 1;
                binding.descriptorType                          = poolSize.type;
                binding.pImmutableSamplers                      = nullptr;
                binding.stageFlags                              = m_stage;
                
                m_setLayoutBindings.push_back(binding);
            }

            m_descriptorPoolSizes.push_back(poolSize);
        }

        if (!resources.sampled_images.empty())
        {
            VkDescriptorPoolSize poolSize   = {};
            poolSize.descriptorCount        = 4096;
            poolSize.type                   = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;

            for (const auto& sampler : resources.sampled_images)
            {
                VkDescriptorSetLayoutBinding binding    = {};
                binding.binding                         = compiler.get_decoration(sampler.id, spv::DecorationBinding);
                binding.descriptorCount                 = 1;
                binding.descriptorType                  = poolSize.type;
                binding.pImmutableSamplers              = nullptr;
                binding.stageFlags                      = m_stage;

                m_setLayoutBindings.push_back(binding);
            }

            m_descriptorPoolSizes.push_back(poolSize);
        }

        createShaderModule(device, ptr, spvChars.size());
    }

    void Shader::createShaderModule(Device* device, const uint32_t* code, uint32_t codeSize)
    {
        VkShaderModuleCreateInfo createInfo     = {};
        createInfo.sType                        = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
        createInfo.codeSize                     = codeSize;
        createInfo.pCode                        = code;

        GM_CORE_ASSERT(vkCreateShaderModule(device->get(), &createInfo, nullptr, &m_module) == VK_SUCCESS,
                       "Failed to create shader module!");
    }

    std::vector<char> Shader::readFromFile(const char* filePath)
    {
        std::ifstream file(JOIN_WITH_ROOTDIR(filePath).c_str(), std::ios::ate | std::ios::binary);

        if (file.fail())
        {
            GM_CORE_ASSERT("Failed to find file {0}", filePath);
        }

        size_t size  = static_cast<size_t>(file.tellg());

        file.seekg(0);

        std::vector<char> chars(size);

        file.read(chars.data(), size);

        file.close();

        return chars;
    }
}