gameframe_update()
if gameframe_mouse_in_window()
{
	if mouse_in_window == false
	{
		mouse_in_window = true
		gameframe_visible_time = 60 * 3
		mouseX = window_mouse_get_x()
		mouseY = window_mouse_get_y()
	}
	if window_mouse_get_x() != mouseX || window_mouse_get_y() != mouseY
	{
		mouse_in_window = false
	}
}
else
{
	if mouse_in_window == true
		mouse_in_window = false
}
if gameframe_alpha > 0
	gameframe_default_cursor = cr_arrow
else {
	gameframe_default_cursor = cr_none
}

if gameframe_visible_time > 0
{
	gameframe_visible_time--
	gameframe_alpha = approach(gameframe_alpha, 1, 0.1)
}
else
	gameframe_alpha = approach(gameframe_alpha, 0, 0.1)
display_set_gui_size(displayWidth, displayHeight)
surface_resize(application_surface, displayWidth, displayHeight)