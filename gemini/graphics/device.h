#pragma once

#include "graphics/gpu.h"
#include "graphics/deletion_queue.h"

namespace gm
{
    class Device
    {
    public:
        Device(Instance* instance, GPU* gpu);
        ~Device();

        inline VkDevice get() const { return m_device; }

        inline VkQueue getGraphicsQueue() const { return m_graphicsQueue; }

        inline VkQueue getPresentQueue() const { return m_presentQueue; }

    private:
        VkDevice                            m_device                    = VK_NULL_HANDLE;

        VkQueue                             m_graphicsQueue             = VK_NULL_HANDLE;
        VkQueue                             m_presentQueue              = VK_NULL_HANDLE;
    };
}
