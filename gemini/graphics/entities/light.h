#pragma once

#include "core/core.h"

namespace gm
{
    struct Light
    {
        glm::vec3 position = glm::vec3(5.0f, 5.0f, 5.0f);
        float intensity = 1.0f;
        glm::vec3 color = glm::vec3(20.0f, 20.0f, 20.0f);
        float radius = 10.0f;
    };
}
