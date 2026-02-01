if buffer == 0
{
	getMenu_input()
	BGX--
	BGY--
	move = key_left2 + key_right2
	if move != 0
	{
		selected += move
		FMODevent_oneshot("event:/Sfx/UI/Pause/step")
		selected = clamp(selected, 0, array_length(achievement) - 1)
	}
	
	if key_slap2
	{
		instance_destroy()
		FMODevent_oneshot("event:/Sfx/UI/Pause/menuback")
	}
}