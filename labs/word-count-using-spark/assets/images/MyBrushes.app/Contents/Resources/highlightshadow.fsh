// http://www.cocos2d-iphone.org

#ifdef GL_ES
precision lowp float;
#endif

varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
uniform		vec4 u_color;
 
 //uniform float shadows;
 //uniform float highlights;
 const float shadows = 0.8;
 const float highlights = 10.0;

 const vec3 luminanceWeighting = vec3(0.3, 0.3, 0.3);
 
 void main()
 {
	vec4 source = texture2D(CC_Texture0, v_texCoord);
	float luminance = dot(source.rgb, luminanceWeighting);
    
	float shadow = clamp((pow(luminance, 1.0/(shadows+1.0)) + (-0.76)*pow(luminance, 2.0/(shadows+1.0))) - luminance, 0.0, 1.0);
	float highlight = clamp((1.0 - (pow(1.0-luminance, 1.0/(2.0-highlights)) + (-0.8)*pow(1.0-luminance, 2.0/(2.0-highlights)))) - luminance, -1.0, 0.0);
	vec3 result = vec3(0.0, 0.0, 0.0) + ((luminance + shadow + highlight) - 0.0) * ((source.rgb - vec3(0.0, 0.0, 0.0))/(luminance - 0.0));
    
	gl_FragColor = vec4(result.rgb, source.a);
 }