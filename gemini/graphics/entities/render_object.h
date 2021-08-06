#pragma once

#include "graphics/device.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"

#include "graphics/images/textured_image.h"

#include "graphics/entities/entity.h"

#include "graphics/descriptors/descriptor_set.h"

namespace gm
{
    class RenderObject
    {
    public:
        RenderObject(Entity* entity, GPU* gpu, Device* device, Pipeline* pipeline, CommandPool* cmdPool, VmaAllocator allocator) :
            m_entity(entity)
        {
            m_vbo.loadData(device, cmdPool, allocator, entity->getMesh().vertices);
            m_ibo.loadData(device, cmdPool, allocator, entity->getMesh().indices);

            m_texturedImage.loadData(gpu, device, cmdPool, allocator, entity->getMesh().material.albedoFile);

            m_samplerDescriptor.init(device, pipeline, m_texturedImage, 0, 1);
        }

        ~RenderObject()
        {
            delete m_entity;
        };

        inline void initDescriptorSets(Device* device, Pipeline* pipeline) { m_samplerDescriptor.init(device, pipeline, m_texturedImage, 0, 1); }

        inline const VertexBuffer& getVBO() const { return m_vbo; }

        inline const IndexBuffer& getIBO() const { return m_ibo; }

        inline const DescriptorSet& getSamplerDescriptor() const { return m_samplerDescriptor; }

        inline Entity* getEntity() const { return m_entity; }

    private:
        Entity*         m_entity        = nullptr;

        VertexBuffer    m_vbo;
        IndexBuffer     m_ibo;
        TexturedImage   m_texturedImage;

        DescriptorSet   m_samplerDescriptor;
    };
}
