#version 300 es
precision mediump float;

#define PI radians(180.0)

uniform vec3 strokeColor;
uniform float planetAngle;
uniform vec4 pickingColor;

in float orbitAngle;

layout (location = 0) out vec4 oColor;
layout (location = 2) out vec4 pickColor;

void main() {
    float a = 0.0001;
    float progress = mod(orbitAngle - planetAngle, radians(360.0)) / (PI * 2.0);
    progress = a * progress - a + 1.0;
    progress = pow(progress, 2.2);
    oColor = vec4(strokeColor * progress, 1.0);
    pickColor = pickingColor;
}