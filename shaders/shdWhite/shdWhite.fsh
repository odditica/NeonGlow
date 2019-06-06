//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float luma(vec3 c){
	return 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b;
}


void main()
{
	vec3 tex = texture2D( gm_BaseTexture, v_vTexcoord ).rgb;
    gl_FragColor = vec4(vec3(smoothstep(.0, .5, luma(tex))), 1.);
}
