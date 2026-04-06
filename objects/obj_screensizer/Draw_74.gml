if !surface_exists(gameSurface)
	gameSurface = surface_create(SCREEN_WIDTH, SCREEN_HEIGHT)
surface_set_target(gameSurface)
draw_clear_alpha(c_black, 0);

gpu_set_blendenable(false);
draw_clear_alpha(c_black, 0);
gpu_set_blendenable(false);
if variable_global_exists("escape") && global.escape.active
{
	// Apply shader
	shader_set(shd_escape);
			
	// Set uniforms
	shader_set_uniform_f(shaderUniforms.time, current_time / 1000.0);
	bleedIntensity = lerp(bleedIntensity, 0.07, 0.01)
	shader_set_uniform_f(shaderUniforms.intensity, bleedIntensity);
	shader_set_uniform_f_array(shaderUniforms.resolution, [display_get_gui_width(), display_get_gui_height()]);
	shader_set_uniform_f(shaderUniforms.wave.amplitude, 0.02);
	shader_set_uniform_f(shaderUniforms.wave.frequency, 10.0);
	draw_surface(application_surface, 0, 0);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_add)
	draw_surface_ext(application_surface, wave(-15, 15, 3, 0), 0, 1, 1, 0, c_white, 0.08);
	draw_surface_ext(application_surface, -wave(-15, 15, 3, 0), 0, 1, 1, 0, c_white, 0.08);
	gpu_set_blendmode(bm_normal)
	gpu_set_blendenable(false);
	
	shader_reset();
}
else
{
	draw_surface(application_surface, 0, 0)
}
gpu_set_blendenable(true);