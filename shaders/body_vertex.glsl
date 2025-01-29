#version 300 es
precision mediump float;

in vec3 vertexPos;
in vec2 vertexUV;
in vec3 vertexNormal;
out vec2 fragmentUV;
out vec3 fragmentNormal;

uniform mat4 modelMat;
uniform mat4 projViewMat;

void main() {
    fragmentUV = vertexUV;
    fragmentNormal = vertexNormal;

    gl_Position = projViewMat * modelMat * vec4(vertexPos, 1.0);
}