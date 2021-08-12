#pragma once

#include "core/core.h"

namespace gm
{
    struct PushConstant
    {
        alignas(16) glm::mat4 model;
        alignas(16) glm::mat4 projectionView;
    };
}