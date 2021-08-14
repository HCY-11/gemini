#include "render_object.h"

namespace gm
{
    RenderObject::RenderObject(
        Entity* entity, 
        GPU* gpu, 
        Device* device, 
        Pipeline* pipeline, 
        CommandPool* cmdPool, 
        VmaAllocator allocator, 
        const Camera& camera, 
        const Light& light) :
        m_entity(entity), m_setHandler(device, pipeline)
    {
        m_vbo.loadData(device, cmdPool, allocator, entity->getMesh().vertices);
        m_ibo.loadData(device, cmdPool, allocator, entity->getMesh().indices);

        m_albedo = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.albedoFile);
        m_roughness = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.roughnessFile);
        m_metallic = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.metallicFile);
        m_ao = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.aoFile);

        m_setHandler.addSampler(m_albedo.get(), 0);
        m_setHandler.addSampler(m_roughness.get(), 1);
        m_setHandler.addSampler(m_metallic.get(), 2);
        m_setHandler.addSampler(m_ao.get(), 3);

        UBOData uboData = { camera.position, light };
        VkDeviceSize size = sizeof(UBOData);
        m_uniformBuffer = makeScope<UniformBuffer>(device, cmdPool, allocator, uboData);

        m_setHandler.addUniformBuffer(m_uniformBuffer.get(), 4);

        m_setHandler.write();
    }

    RenderObject::~RenderObject()
    {
        delete m_entity;
    }
}