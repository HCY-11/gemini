#pragma once

#include "core/core.h"

namespace gm
{
    struct Transform
    {
        glm::vec3 position      = glm::vec3(0.0f);
        glm::vec3 rotation      = glm::vec3(0.0f);
        glm::vec3 scale         = glm::vec3(1.0f);

        Transform()
        {

        }
    };
}
