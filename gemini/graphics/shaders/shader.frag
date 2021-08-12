#version 450

layout (location = 0) in vec3 fragPos;
layout (location = 1) in vec3 fragNormal;
layout (location = 2) in vec2 fragTexCoord;

layout (location = 0) out vec4 outColor;

layout (binding = 0) uniform sampler2D albedoSampler;
layout (binding = 1) uniform sampler2D roughnessSampler;
layout (binding = 2) uniform sampler2D metallicSampler;
layout (binding = 3) uniform sampler2D aoSampler;

struct Light
{
    vec3 position;
    vec3 color;
    float intensity;
};

layout (binding = 4) uniform UBO
{
    vec3 cameraPosition;
    Light light;
} ubo;

const float PI = 3.14159265359;

float N_trowBridgeReitzGGX(vec3 N, vec3 H, float roughness)
{
    float a = roughness * roughness;
    float a2 = a * a;

    float ndotH = max(dot(N, H), 0.0);
    float ndotH2 = pow(ndotH, 2.0);

    float num = a2;
    float denom = (ndotH2 * (a2 - 1.0) + 1.0);
    denom = PI * denom * denom;

    return num / denom;
}

float G_schlickGGX(float nDotV, float roughness)
{
    float num = nDotV;
    float r = roughness + 1.0;
    float k = r * r / 8.0;

    float denom = nDotV * (1 - k) + k;

    return num / denom;
}

float G_smith(vec3 N, vec3 V, vec3 L, float a)
{
    float nDotV = max(dot(N, V), 0.0);
    float nDotL = max(dot(N, L), 0.0);

    float ggx1 = G_schlickGGX(nDotV, a);
    float ggx2 = G_schlickGGX(nDotL, a);

    return ggx1 * ggx2;
}

vec3 F_schlick(float cosTheta, vec3 f0)
{
    return f0 + (1 - f0) * pow(max(1 - cosTheta, 0.0), 5);
}

void main()
{
    vec3 albedo = texture(albedoSampler, fragTexCoord).rgb;
    albedo.r = pow(albedo.r, 2.2);
    albedo.g = pow(albedo.g, 2.2);
    albedo.b = pow(albedo.b, 2.2);

    float roughness = texture(roughnessSampler, fragTexCoord).r; // Black and white image
    float metallic = texture(metallicSampler, fragTexCoord).r;
    float ao = texture(aoSampler, fragTexCoord).r;

    vec3 N = normalize(fragNormal);
    vec3 V = normalize(ubo.cameraPosition - fragPos);
    vec3 wi = normalize(ubo.light.position - fragPos);
    float cosTheta = dot(N, wi);

    vec3 L = normalize(ubo.light.position - fragPos);
    vec3 H = normalize(V + L);

    float dist = length(ubo.light.position - fragPos);

    float attenuation = 1.0 / (dist * dist);
    vec3 radiance = ubo.light.intensity * ubo.light.color * attenuation * cosTheta;

    vec3 f0 = vec3(0.04);
    f0 = mix(f0, albedo, metallic);
    vec3 F = F_schlick(clamp(dot(H, V), 0.0, 1.0), f0);

    float NDF = N_trowBridgeReitzGGX(N, H, roughness);
    float G = G_smith(N, V, L, roughness);

    vec3 numerator = NDF * G * F;
    float denominator = 4.0 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0);
    vec3 specular = numerator / max(denominator, 0.001);

    vec3 kS = F;
    vec3 kD = vec3(1.0) - kS;

    kD *= (1.0 - metallic);

    float nDotL = max(dot(N, L), 0.0);
    vec3 L0 = (kD * albedo / PI + specular) * radiance * nDotL;

    vec3 ambient = vec3(0.0001) * albedo * ao;
    vec3 color = ambient + L0;

    color = color / (color + vec3(1.0));
    color = pow(color, vec3(1.0 / 2.2));

    outColor = vec4(color, 1.0);
}