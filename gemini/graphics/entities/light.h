#pragma once

#include "core/core.h"

namespace gm
{
    struct Light
    {
        alignas(16) glm::vec3 position = glm::vec3(5.0f, 5.0f, 5.0f);
        alignas(16) glm::vec3 color = glm::vec3(20.0f, 20.0f, 20.0f);
        alignas(4) float intensity = 1.0f;
        alignas(4) float radius = 10.0f;
    };
}
