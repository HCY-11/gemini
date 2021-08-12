#pragma once

#include "graphics/device.h"

#include "graphics/buffers/vertex_buffer.h"
#include "graphics/buffers/index_buffer.h"
#include "graphics/buffers/uniform_buffer.h"

#include "graphics/images/textured_image.h"

#include "graphics/entities/entity.h"

#include "graphics/descriptor_set_handler.h"

#include "graphics/entities/light.h"

namespace gm
{
    class RenderObject
    {
    public:
        RenderObject(
            Entity* entity, 
            GPU* gpu, 
            Device* device, 
            Pipeline* pipeline, 
            CommandPool* cmdPool, 
            VmaAllocator allocator, 
            const Camera& camera, 
            const Light& light);

        ~RenderObject();

        inline void initDescriptorSets(Pipeline* pipeline) 
        { 
            m_setHandler.allocate(pipeline);
            m_setHandler.write();
        }

        inline void updateUniformBuffer(const Camera& camera, const Light& light)
        {
            m_uniformBuffer->update(camera, light);
        }

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

        Scope<UniformBuffer>        m_uniformBuffer;

        DescriptorSetHandler        m_setHandler;
    };
}
