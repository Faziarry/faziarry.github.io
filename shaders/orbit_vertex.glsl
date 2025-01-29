#version 300 es
precision mediump float;

#define PI radians(180.0)

uniform int nPoints;

uniform mat4 projViewMat;
uniform mat4 modelMat;

uniform float major;
uniform float eccentricity;
uniform float raan;
uniform float inclination;
uniform float periapsis;

out float orbitAngle;

void main() {
    float u = float(gl_VertexID) / float(nPoints-1);
    float angle = u * 2.0 * PI;

    float minor = major * sqrt(1.0 - (eccentricity * eccentricity));
    float c = sqrt((major + minor) * (major - minor)); // a^2 - b^2 = (a+b)(a-b)

    vec3 pos = vec3(major * cos(angle) -c, 0.0, minor * sin(angle));
    
    orbitAngle = -atan(pos.z,pos.x);
    if (orbitAngle < 0.0) {
        orbitAngle += radians(360.0);
    }
    

    // rotate periapsis
    vec3 A = vec3(
        pos.x * cos(periapsis) + pos.z * sin(periapsis), 
        0.0, 
        pos.z * cos(periapsis) - pos.x * sin(periapsis)
    );

    // rotate inclination
    vec3 B = vec3(
        A.x,
        A.z * -sin(inclination),
        A.z * cos(inclination)
    );

    // rotate raan
    vec3 C = vec3(
        B.x * cos(raan) + B.z * sin(raan), 
        B.y, 
        B.z * cos(raan) - B.x * sin(raan)
    );

    // if (gl_VertexID == nPoints-1) {
    if (gl_VertexID == 0) {
        orbitAngle = radians(360.0);
        // C = vec3(1.0,0.0,0.0);
    };

    gl_Position = projViewMat * modelMat * vec4(C, 1.0);
    gl_PointSize = 5.0;
}