surface_set_target(surBase);
draw_clear(c_black);
with (objNeon) {
	draw_self();
}
surface_reset_target();

gpu_set_blendenable(false);
surface_set_target(surPass);
draw_clear_alpha(c_black, 0);
shader_set(shdBlurHorizontal);
shader_set_uniform_f(shader_get_uniform(shdBlurHorizontal, "u_glowProperties"), uOuterIntensity, uInnerIntensity, uInnerLengthMultiplier);
draw_surface(surBase, 0, 0);
shader_reset();
surface_reset_target();
gpu_set_blendenable(true);

gpu_set_blendmode(bm_add);
shader_set(shdBlurVertical);
shader_set_uniform_f(shader_get_uniform(shdBlurVertical, "u_glowProperties"), uOuterIntensity, uInnerIntensity, uInnerLengthMultiplier);
draw_surface(surPass, 0, 0);
shader_reset();
gpu_set_blendmode(bm_normal);

