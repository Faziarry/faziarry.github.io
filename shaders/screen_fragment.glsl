#version 300 es
precision mediump float;

uniform sampler2D screen_texture;
uniform sampler2D bright_texture;

in vec2 fragmentUV;
out vec4 oColor;

const float offset = 1.0 / 500.0;

const float exposure = 1.0;
const float gamma = 2.2;

void main() {

    vec3 textColor = texture(screen_texture, fragmentUV).rgb;    
    vec3 bloomColor = texture(bright_texture, fragmentUV).rgb;

    // color + blur
    vec3 hdr = textColor / 1.0 + bloomColor / 1.0;
    // tone mapping
    vec3 result = vec3(1.0) - exp(-hdr * exposure);
    // gamma correction
    result = pow(hdr, vec3(1.0 / gamma));

    oColor = vec4(result, 1.0);
}