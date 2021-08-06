#version 450

layout (location = 0) in vec3 i_position;
layout (location = 1) in vec3 i_normal;
layout (location = 2) in vec2 i_texCoord;

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
    gl_Position = pushConstant.projectionView * pushConstant.model * vec4(i_position, 1.0);
    fragTexCoord = i_texCoord;
    fragPos = (pushConstant.model * vec4(i_position, 1.0)).rgb;
    fragNormal = (pushConstant.model * vec4(i_normal, 1.0)).rgb;
}