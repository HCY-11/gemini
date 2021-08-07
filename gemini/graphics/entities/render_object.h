#pragma once

#include "graphics/device.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"

#include "graphics/images/textured_image.h"

#include "graphics/entities/entity.h"

#include "graphics/descriptor_set_handler.h"

namespace gm
{
    class RenderObject
    {
    public:
        RenderObject(Entity* entity, GPU* gpu, Device* device, Pipeline* pipeline, CommandPool* cmdPool, VmaAllocator allocator) :
            m_entity(entity), m_setHandler(device, pipeline)
        {
            m_vbo.loadData(device, cmdPool, allocator, entity->getMesh().vertices);
            m_ibo.loadData(device, cmdPool, allocator, entity->getMesh().indices);

            m_albedo = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.albedoFile);
            m_roughness = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.roughnessFile);
            m_metallic = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.metallicFile);
            m_ao = makeScope<TexturedImage>(gpu, device, cmdPool, allocator, entity->getMesh().material.aoFile);

            m_setHandler.push(m_albedo.get(), 0);
            m_setHandler.push(m_roughness.get(), 1);
            m_setHandler.push(m_metallic.get(), 2);
            m_setHandler.push(m_ao.get(), 3);

            m_setHandler.write();
        }

        ~RenderObject()
        {
            delete m_entity;
        };

        inline void initDescriptorSets(Pipeline* pipeline) { m_setHandler.allocate(pipeline); }

        inline const VertexBuffer& getVBO() const { return m_vbo; }

        inline const IndexBuffer& getIBO() const { return m_ibo; }

        inline Entity* getEntity() const { return m_entity; }

        inline DescriptorSetHandler& getSetHandler() { return m_setHandler; }

    private:
        Entity*                     m_entity        = nullptr;

        VertexBuffer                m_vbo;
        IndexBuffer                 m_ibo;

        Scope<TexturedImage>        m_albedo;
        Scope<TexturedImage>        m_roughness;
        Scope<TexturedImage>        m_metallic;
        Scope<TexturedImage>        m_ao;

        DescriptorSetHandler        m_setHandler;
    };
}
