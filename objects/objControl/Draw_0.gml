//// Horizontal pass

surface_set_target(surBase);
draw_clear(c_black);

// Draw everything that glows
with (objNeon) {
	draw_self();
}
surface_reset_target();

// Make it glow horizontally
surface_set_target(surPass);
draw_clear_alpha(c_black, 0);

shader_set(shdBlurHorizontal);
shader_set_uniform_f(shader_get_uniform(shdBlurHorizontal, "u_glowProperties"), uOuterIntensity, uInnerIntensity, uInnerLengthMultiplier);

gpu_set_blendenable(false); //necessary!
draw_surface(surBase, 0, 0);
gpu_set_blendenable(true);

shader_reset();

surface_reset_target();

//// Vertical pass + final adjustments, add on top
gpu_set_blendmode(bm_add);

shader_set(shdBlurVertical);
shader_set_uniform_f(shader_get_uniform(shdBlurVertical, "u_glowProperties"), uOuterIntensity, uInnerIntensity, uInnerLengthMultiplier);
draw_surface(surPass, 0, 0);
shader_reset();

gpu_set_blendmode(bm_normal);

