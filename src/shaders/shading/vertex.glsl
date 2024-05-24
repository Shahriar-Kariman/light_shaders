varying vec3 v_normal;
varying vec3 v_position;

void main()
{
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * viewMatrix * modelPosition;
    // to change the normal with movement
    vec4 modelNormal = modelMatrix * vec4(normal, 0.0); // 0.0 is to keep the direction
    v_normal = modelNormal.xyz;
    v_position = modelPosition.xyz;
}