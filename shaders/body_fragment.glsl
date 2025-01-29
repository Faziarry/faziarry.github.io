#version 300 es
precision mediump float;

uniform sampler2D sphere_texture;
uniform sampler2D unlit_texture;

in vec2 fragmentUV;
in vec3 fragmentNormal;
layout (location = 0) out vec4 oColor;
layout (location = 1) out vec4 bloomColor;
layout (location = 2) out vec4 pickColor;

uniform vec4 pickingColor;

uniform mat4 modelMat;
uniform mat4 projViewMat;

uniform vec3 camera;

uniform bool star;

void main() {
    mat3 normalMatrix = mat3(modelMat);
    normalMatrix = inverse(normalMatrix);
    normalMatrix = transpose(normalMatrix);
    vec3 new_normal = normalize(normalMatrix * fragmentNormal);
    // if (fragmentNormal != vec3(0.0)) { // Planet
    if (!star) { // Planet
        
        vec3 light_direction = normalize(-modelMat[3].xyz);
        
        vec3 light_color = vec3(1.0, 1.0, 1.0);
        vec3 light = max(
            dot(light_direction, (new_normal).xyz), 
            0.0) * light_color;
        light = pow(light, vec3(2.2));
        
        vec3 night_light = max(
            dot(-light_direction, (new_normal).xyz ), 
            0.0) * vec3(1.0);
        night_light = pow(night_light, vec3(2.2));

        vec3 surface = texture(sphere_texture, fragmentUV).rgb;
        // THIS TEXTURE SHOULDN'T BE GAMMA CORRECTED HERE BUT SRGB8_ALPHA8 DOESN'T SEEM TO DO SHIT
        vec3 night_surface = pow(texture(unlit_texture, fragmentUV).rgb, vec3(2.2));

        oColor = vec4((surface * light) + (night_surface * night_light), 1.0);
        bloomColor = vec4(night_surface * night_light, 1.0);
    } else {
        vec3 suntex = texture(sphere_texture, fragmentUV).rgb;
        float progress = max(dot(new_normal, normalize(camera)), 0.0);
        vec3 sun = vec3(mix(vec3(1.0,0.5,0.1), vec3(1.0, 1.0,0.4), pow(progress,2.2)));
        float p1 = 2.0;
        float p2 = 1.0;
        oColor = vec4(((sun * p1) + (suntex * p2)) / (p1+p2), 1.0);
        bloomColor = oColor;
    }
    pickColor = pickingColor;
}