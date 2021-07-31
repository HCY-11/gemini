#pragma once

#include "core/core.h"

#include "graphics/entities/entity.h"

namespace gm
{
    class Math
    {
    public:
        static glm::mat4 createModelMatrix(Entity* entity); 

        static glm::mat4 createProjectionViewMatrix(Window* window, const Camera& camera);
    };
}