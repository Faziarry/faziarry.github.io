#version 300 es
precision mediump float;

#define PI radians(180.0)

uniform vec3 strokeColor;

out vec4 oColor;

void main() {
    oColor = vec4(strokeColor, 1.0);
}