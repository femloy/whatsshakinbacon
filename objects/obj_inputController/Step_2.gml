if !active
	exit;
if device_found
{
	if global.player_gamepad_current == -4
	{
		for (var i = 0; i < 8; i++)
		{
			var _pad = scr_button_pressed(i)
			if _pad != -1
			{
				global.player_gamepad_current = _pad
				show_debug_message($"Gamepad {_pad} - {gamepad_get_description(_pad)} - is now Player")
				exit;
			}
		}
	}
	if gamepad_is_connected(global.player_gamepad_current)
		gamepad_set_vibration(global.player_gamepad_current, vibration, vibration)
}
gamepad_reset_axis_pressed()