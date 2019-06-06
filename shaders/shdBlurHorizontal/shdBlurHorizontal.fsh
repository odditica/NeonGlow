// @blokatt

#extension GL_OES_standard_derivatives : enable

#define RADIUS 25.0
#define PI 3.1415926535897932384626433832795
#define SIGMA (RADIUS / 3.)
#define TSQR_SIGMA (2. * SIGMA * SIGMA)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_glowProperties;

// The compiler should optimise this.
float gauss(float v) {
	return (1.0 / sqrt(TSQR_SIGMA * PI)) * exp(-(v * v) / TSQR_SIGMA);   
}

// Doesn't have to be necessarily intensity, smoothstep wouldn't be a bad idea 
float luma(vec3 c){
	return 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b;
}

void main()
{	
    vec2 offset = vec2(dFdx(v_vTexcoord.x), 0.);   	
	vec4 blur = vec4(0);    
		
    for (float i = -RADIUS; i <= RADIUS; i += 1.) {  
		if (v_vTexcoord.x < 0. || v_vTexcoord.y < 0. || v_vTexcoord.x > 1. || v_vTexcoord.y > 1.) {
			continue;
		}
		vec3 tex = texture2D(gm_BaseTexture, v_vTexcoord + offset * i).rgb;
		vec2 gaussV = vec2(gauss(i), gauss(i * u_glowProperties.b));    	
		blur += vec4(vec3(tex.rgb * gaussV.x), luma(tex) * u_glowProperties.g * gaussV.y);	
    }

    gl_FragColor = vec4(blur.rgb * u_glowProperties.r, blur.a);
}
