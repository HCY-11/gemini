#pragma once

#include "gpu.h"

class Device
{
public:
    Device();
    ~Device();

    void create(const Instance& instance, const GPU& gpu);

    void destroy();

    inline VkDevice get() const { return m_device; }

    inline VkQueue getGraphicsQueue() const { return m_graphicsQueue; }

    inline VkQueue getPresentQueue() const { return m_presentQueue; }

private:
    VkDevice                            m_device                    = VK_NULL_HANDLE;

    VkQueue                             m_graphicsQueue             = VK_NULL_HANDLE;
    VkQueue                             m_presentQueue              = VK_NULL_HANDLE;
};