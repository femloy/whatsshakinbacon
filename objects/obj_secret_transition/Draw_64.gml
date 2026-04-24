if fadeIn
{
	draw_sprite_ext(spr_transition_heart, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, heartScale, heartScale, 0, c_black, 1)
}
else
{
	if (!surface_exists(surf))
	{
	    surf = surface_create(SCREEN_WIDTH, SCREEN_HEIGHT);
	}

	// Draw to surface
	surface_set_target(surf);
    
	draw_rectangle_colour(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_black, c_black, c_black, c_black, false)
    
	gpu_set_blendequation(bm_eq_subtract);
	draw_sprite_ext(spr_transition_heart, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, heartScale, heartScale, 0, c_black, 1)
	gpu_set_blendequation(bm_add);
    
	surface_reset_target();
    
	// Draw surface to screen
	draw_surface(surf, 0, 0);
}