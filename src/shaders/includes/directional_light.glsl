
vec3 directionalLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 light_position, vec3 viewDirection, float specularPower){
  vec3 light_direction = normalize(light_position);
  vec3 light_reflection = reflect(-light_direction, normal);

  // you need to clamp it so it does not go bellow 0 otherwize it will hcnage collor
  float shading = max(dot(normal, light_direction),0.0);

  float specular = max(- dot(light_reflection, viewDirection),0.0);
  specular = pow(specular, specularPower);

  return lightColor*lightIntensity*(shading+specular);
}