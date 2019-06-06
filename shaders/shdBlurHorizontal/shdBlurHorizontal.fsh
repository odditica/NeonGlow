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

float luma(vec3 c){
	return 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b;
}

void main()
{	
    vec2 offset = vec2(dFdx(v_vTexcoord.x), 0.);   	
	vec4 blur = vec4(0);    
	
    for (float i = -RADIUS; i < RADIUS; i += 1.) {                
		vec3 tex = texture2D(gm_BaseTexture, v_vTexcoord + offset * i).rgb;
    	blur.rgb += tex * gauss(abs(i));
		blur.a += luma(tex) * gauss(abs(i * u_glowProperties.b)) * u_glowProperties.g;   
    }

    gl_FragColor = vec4(blur.rgb * u_glowProperties.r, blur.a);
}
