#pragma once

#include "core/core.h"

namespace gm
{
    struct Material
    {
        std::filesystem::path albedoFile;
        std::filesystem::path normalFile;
        std::filesystem::path roughnessFile;
        std::filesystem::path metallicFile;
        std::filesystem::path aoFile;
    };
}