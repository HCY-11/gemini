#version 450

layout (location = 0) in vec3 fragPos;
layout (location = 1) in vec3 fragNormal;
layout (location = 2) in vec2 fragTexCoord;

layout (location = 0) out vec4 outColor;

layout (binding = 0) uniform sampler2D albedoSampler;
layout (binding = 1) uniform sampler2D roughnessSampler;
layout (binding = 2) uniform sampler2D metallicSampler;
layout (binding = 3) uniform sampler2D aoSampler;

const float PI = 3.14159265359;

const vec3 LIGHT_POS = vec3(0.0, 7.0, 0.0);
const vec3 CAM_POS = vec3(0.0, 0.0, 20.0);

float N_trowBridgeReitzGGX(vec3 n, vec3 h, float a)
{
    float a2 = a * a;
    float nom = a2 * a2;

    float ndotH = max(dot(n, h), 0.0);
    float ndotH2 = pow(ndotH, 2.0);

    float denom = (ndotH2 * (nom - 1.0) + 1.0);
    denom = PI * denom * denom;

    return nom / denom;
}

float G_schlickGGX(float nDotV, float a)
{
    float nom = nDotV;
    float r = a * a + 1.0;
    float k = r * r / 8.0;

    float denom = nDotV * (1 - k) + k;

    return nom / denom;
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
    vec3 lightColor = vec3(23.47, 21.31, 20.79);
    vec3 albedo = texture(albedoSampler, fragTexCoord).rgb;
    float roughness = texture(roughnessSampler, fragTexCoord).r; // Black and white image
    float metallic = texture(metallicSampler, fragTexCoord).r;
    float ao = texture(aoSampler, fragTexCoord).r;

    vec3 N = normalize(fragNormal);
    vec3 V = normalize(CAM_POS - fragNormal);
    vec3 wi = normalize(LIGHT_POS - fragPos);
    float cosTheta = dot(N, wi);

    vec3 L = normalize(LIGHT_POS - fragPos);
    vec3 H = normalize(V + L);

    float dist = length(LIGHT_POS - fragPos);
    float attenuation = 1 / (dist * dist);
    vec3 radiance = lightColor * attenuation * cosTheta;

    vec3 f0 = vec3(0.04);
    f0 = mix(f0, albedo, metallic);
    vec3 F = F_schlick(max(dot(H, V), 0.0), f0);

    float NDF = N_trowBridgeReitzGGX(N, H, roughness);
    float G = G_smith(N, V, L, roughness);

    vec3 numerator = NDF * G * F;
    float denominator = 4.0 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0);
    vec3 specular = numerator / max(denominator, 0.01);

    vec3 kS = F;
    vec3 kD = vec3(1.0) - kS;

    kD *= (1.0 - metallic);

    float nDotL = max(dot(N, L), 0.0);
    vec3 L0 = (kD * albedo / PI + specular) * radiance * nDotL;

    vec3 ambient = vec3(0.03) * albedo * ao;
    vec3 color = ambient + L0;

    color = color / (color + vec3(1.0));
    color = pow(color, vec3(1.0 / 2.2));

    outColor = vec4(color, 1.0);
}