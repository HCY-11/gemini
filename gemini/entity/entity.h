#pragma once

#include "mesh.h"

struct Entity
{
    Mesh mesh;

    Entity(Mesh inMesh)
    {
        mesh = inMesh;
    }
};