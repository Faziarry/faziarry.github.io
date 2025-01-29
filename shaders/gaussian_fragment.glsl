#version 300 es
precision mediump float;

in vec2 fragmentUV;
out vec4 oColor;

uniform sampler2D image;

uniform bool horizontal;
float weight[5] = float[] (0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);

void main() {
    vec2 tex_offset = vec2(1.0) / vec2(textureSize(image, 0));
    vec3 result = texture(image, fragmentUV).rgb * weight[0];
    if (horizontal) {
        for (int i = 1; i < 5; ++i) {
            result += texture(image, fragmentUV + vec2(tex_offset.x * float(i), 0.0)).rgb * weight[i];
            result += texture(image, fragmentUV - vec2(tex_offset.x * float(i), 0.0)).rgb * weight[i];
        }
    } else {
        for (int i = 1; i < 5; ++i) {
            result += texture(image, fragmentUV + vec2(0.0, tex_offset.y * float(i))).rgb * weight[i];
            result += texture(image, fragmentUV - vec2(0.0, tex_offset.y * float(i))).rgb * weight[i];
        } 
    }
    oColor = vec4(result, 1.0);
}