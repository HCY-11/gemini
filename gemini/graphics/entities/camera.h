#pragma once

#include "graphics/entities/transform.h"

namespace gm
{
    struct Camera
    {
        glm::vec3 position      = glm::vec3(0.0f, 0.0f, 0.0f);
        glm::vec3 rotation      = glm::vec3(0.0f);

        float fovAngle          = 45.0f;
    };
}