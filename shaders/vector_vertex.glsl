#version 300 es
precision mediump float;

uniform vec3 start;
uniform vec3 end;

uniform mat4 projViewMat;
uniform mat4 modelMat;

void main() {
    gl_PointSize = 10.0;
    gl_Position = projViewMat * modelMat * vec4(0.0, 0.0, 0.0, 1.0);
    if (gl_VertexID == 1) {
        gl_Position = projViewMat * modelMat * vec4(start, 1.0);
    } else {
        gl_Position = projViewMat * modelMat * vec4(end, 1.0);
    }
}