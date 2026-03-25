surface_reset_target()
draw_clear(c_black)
gpu_set_blendenable(false);
draw_sprite_tiled(spr_letterbox, 0, 0, 0)
draw_rectangle_color(-1, -1, SCREEN_WIDTH + 1, SCREEN_HEIGHT + 1, c_black, c_black, c_black, c_black, false)
draw_surface_stretched(gameSurface, 0 + (SCREEN_WIDTH / 2 * (1 - screenSize)), 0 + (SCREEN_HEIGHT / 2 * (1 - screenSize)), SCREEN_WIDTH * screenSize, SCREEN_HEIGHT * screenSize)
gpu_set_blendenable(true);
draw_set_colour(c_white)
gameframe_draw()
draw_set_alpha(1)
draw_set_color(c_white)
if instance_exists(obj_shell)
{
	with obj_shell
		event_perform(ev_draw, ev_gui);
}