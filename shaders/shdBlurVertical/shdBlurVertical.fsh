#extension GL_OES_standard_derivatives : enable

#define RADIUS 25.0
#define E 0.5772156649
#define PI 3.1415926535897932384626433832795
#define SIGMA (RADIUS / 3.)
#define TSQR_SIGMA (2. * SIGMA * SIGMA)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_glowProperties; //r - master int, g - inner int, b - inner len

float gauss(float v) {
	return (1.0 / sqrt(TSQR_SIGMA * PI)) * pow(E, (v * v) / TSQR_SIGMA);   
}

void main()
{	
    vec4 blur = vec4(0);    
    vec2 offset = vec2(0., dFdy(v_vTexcoord.y));
    	
    for (float i = -RADIUS; i < RADIUS; i += 1.) {                
		vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord + offset * i);
    	blur.rgb += tex.rgb * gauss(abs(i));
		blur.a += tex.a * gauss(abs(i * u_glowProperties.b)) * u_glowProperties.g; 
    }	
    gl_FragColor = v_vColour * vec4(blur.rgb * u_glowProperties.r + blur.aaa, 1.0);	
}
