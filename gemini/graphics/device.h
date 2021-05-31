#pragma once

#include "gpu.h"
#include "vma.h"

class Device
{
public:
    Device();
    ~Device();

    void create(const Instance& instance, const GPU& gpu);

    void destroy();

    VkDevice get() const { return m_device; }

    VkQueue getGraphicsQueue() const { return m_graphicsQueue; }

    VkQueue getPresentQueue() const { return m_presentQueue; }

    VmaAllocator getAllocator() const { return m_allocator; }

private:
    void createAllocator(const Instance& instance, const GPU& gpu);

private:
    VkDevice                            m_device                    = VK_NULL_HANDLE;

    VkQueue                             m_graphicsQueue             = VK_NULL_HANDLE;
    VkQueue                             m_presentQueue              = VK_NULL_HANDLE;

    VmaAllocator                        m_allocator                 = VK_NULL_HANDLE;
};