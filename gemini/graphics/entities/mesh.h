#pragma once

#include "core/core.h"

#include "graphics/entities/vertex.h"
#include "graphics/entities/transform.h"
#include "graphics/entities/material.h"

namespace gm
{
    struct GM_API Mesh
    {
        std::vector<Vertex> vertices;
        std::vector<uint16_t> indices;

        Material material;

        Mesh() = default;
        Mesh(const std::filesystem::path& inFilePath, const std::filesystem::path& materialPath)
        {
            loadFromFile(inFilePath, materialPath);
        }

        // TODO: add a new asset system w/ assimp and add normal mapping
        void loadFromFile(const std::filesystem::path& filePath, const std::filesystem::path& materialPath)
        {
            material.albedoFile = materialPath / "albedo.png";
            material.normalFile = materialPath / "normal.png";
            material.roughnessFile = materialPath / "roughness.png";
            material.metallicFile = materialPath / "metallic.png";
            material.aoFile = materialPath / "ao.png";

            tinyobj::attrib_t attrib;

            std::vector<tinyobj::shape_t> shapes;
            std::vector<tinyobj::material_t> materials;

            std::string err;

            tinyobj::LoadObj(&attrib, &shapes, &materials, &err, JOIN_WITH_ROOTDIR(filePath).c_str());

            if (err != "")
            {
                GM_CORE_WARN("tinobjloader: {0} has errors/warnings: {1}", filePath, err);
            }

            // Loop through faces
            for (size_t i = 0; i < shapes.size(); i++)
            {
                size_t indexOffset = 0;
                // Loop through polygons
                for (size_t j = 0; j < shapes[i].mesh.num_face_vertices.size(); j++)
                {
                    size_t numVertices = 3;

                    for (size_t k = 0; k < numVertices; k++)
                    {
                        uint16_t newIndex = indexOffset + k;
                        indices.push_back(newIndex);

                        tinyobj::index_t idx = shapes[i].mesh.indices[newIndex];

                        Vertex newVertex = {};

                        newVertex.position.x = attrib.vertices[3 * idx.vertex_index + 0];
                        newVertex.position.y = attrib.vertices[3 * idx.vertex_index + 1];
                        newVertex.position.z = attrib.vertices[3 * idx.vertex_index + 2];

                        newVertex.normal.x = attrib.normals[3 * idx.normal_index + 0];
                        newVertex.normal.y = attrib.normals[3 * idx.normal_index + 1];
                        newVertex.normal.z = attrib.normals[3 * idx.normal_index + 2];

                        newVertex.texCoord.x = attrib.texcoords[2 * idx.texcoord_index + 0];
                        newVertex.texCoord.y = 1 - attrib.texcoords[2 * idx.texcoord_index + 1]; // Invert Y

                        vertices.push_back(newVertex);
                    }

                    indexOffset += numVertices;
                }
            }
        }
    };
}