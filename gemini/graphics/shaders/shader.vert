#version 450

layout (location = 0) in vec3 inPosition;
layout (location = 1) in vec3 inNormal;
layout (location = 2) in vec2 inTexCoord;

layout (location = 0) out vec3 fragPos;
layout (location = 1) out vec3 fragNormal;
layout (location = 2) out vec2 fragTexCoord;

layout (push_constant) uniform PushConstant
{
    mat4 model;
    mat4 projectionView;
} pushConstant;

void main()
{
    gl_Position = pushConstant.projectionView * pushConstant.model * vec4(inPosition, 1.0);
    fragTexCoord = inTexCoord;
    fragPos = mat3(pushConstant.model) * inPosition;
    fragNormal = mat3(pushConstant.model) * inNormal;
}