if buffer == 0
{
	get_menu_input()
	BGX--
	BGY--
	move = key_left_pressed + key_right_pressed
	if move != 0
	{
		selected += move
		FMODevent_oneshot("event:/Sfx/UI/Pause/step")
		selected = clamp(selected, 0, array_length(achievement) - 1)
	}
	
	if key_grab_pressed
	{
		instance_destroy()
		FMODevent_oneshot("event:/Sfx/UI/Pause/menuback")
	}
}