#version 300 es
precision mediump float;

in vec2 vertexPos;
out vec2 fragmentUV;

void main() {
    fragmentUV = (vertexPos + vec2(1.0)) / 2.0;

    gl_Position = vec4(vertexPos, 0.0, 1.0);
}