uniform vec3 uColor;
varying vec3 v_normal;
varying vec3 v_position;

#include ../includes/ambient_light.glsl
#include ../includes/directional_light.glsl

vec3 pointLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 light_position, vec3 frag_position, vec3 viewDirection, float specularPower, float light_decay){
    vec3 light_delt = light_position - frag_position;
    float light_distance = length(light_delt);
    vec3 light_direction = normalize(light_delt);
    vec3 light_reflection = reflect(-light_direction, normal);

    // you need to clamp it so it does not go bellow 0 otherwize it will hcnage collor
    float shading = max(dot(normal, light_direction),0.0);

    float specular = max(- dot(light_reflection, viewDirection),0.0);
    specular = pow(specular, specularPower);

    float decay = 1.0 - light_distance * light_decay;
    decay = max(0.0, decay);

    return lightColor*lightIntensity*(shading+specular)*decay;
}

void main()
{
    vec3 viewDirection = normalize(v_position-cameraPosition);
    vec3 color = uColor;

    vec3 normal = normalize(v_normal);

    // Light
    vec3 light = vec3(0.0);
    light += ambientLight(vec3(0.1, 0.1, 1.0), 0.05);
    light += directionalLight(
        vec3(0.1, 0.1, 1.0),
        1.0,
        v_normal,
        vec3(0.0, 2.5, 0.0),
        viewDirection,
        10.0
    );
    light += pointLight(
        vec3(0.1, 0.1, 1.0),
        1.0,
        v_normal,
        vec3(0.0, 2.5, 0.0),
        v_position,
        viewDirection,
        10.0,
        0.3
    );
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}