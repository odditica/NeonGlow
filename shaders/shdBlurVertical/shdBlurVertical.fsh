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

void main()
{	
    vec4 blur = vec4(0);    
    vec2 offset = vec2(0., dFdy(v_vTexcoord.y));
    	
    for (float i = -RADIUS; i < RADIUS; i += 1.) {                
		vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord + offset * i);
		vec2 gaussV = vec2(gauss(i), gauss(i * u_glowProperties.b));
    	blur += vec4(vec3(tex.rgb * gaussV.x), tex.a * u_glowProperties.g * gaussV.y);		
    }	
	
    gl_FragColor = v_vColour * vec4(blur.rgb * u_glowProperties.r + blur.aaa, 1.0);	
}
