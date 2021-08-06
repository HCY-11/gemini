#pragma once

#include "core/core.h"

namespace gm
{
    struct Material
    {
        std::string albedoFile;
        std::string normalFile;
        std::string roughnessFile;
        std::string metallicFile;
        std::string aoFile;
    };
}