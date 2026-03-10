var _Deadzone = global.gamepadDeadzones.press
	_Deadzone = clamp(_Deadzone, 0, 0.99)
	
	var _axis = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
	for (var i = 0; i < array_length(_axis); i++)
	{
		var _s = string(_axis[i])
		var _axis_value = gamepad_axis_value(global.gamepadCurrent, _axis[i])
		var _pressed = ds_map_find_value(global.gamepad_pressed, _s)
		
		var _saved_axis = ds_map_find_value(global.gamepad_pressed, $"{_axis}_axis")
		
		if _pressed && gamepad_axis_value(global.gamepadCurrent, _axis_value) < global.gamepadDeadzones.press
		{
			show_debug_message("Not Pressed!")
			ds_map_set(global.gamepad_pressed, $"{_axis}_axis", gamepad_axis_value(global.gamepadCurrent, _axis_value))
			ds_map_set(global.gamepad_pressed, _s, false)
		}
			
		_s = string($"{_axis[i]}_invert")
		 _pressed = ds_map_find_value(global.gamepad_pressed, _s)
		
		if _pressed && gamepad_axis_value(global.gamepadCurrent, _axis_value) > -global.gamepadDeadzones.press
		{
			show_debug_message("Not Pressed!")
			ds_map_set(global.gamepad_pressed, $"{_axis}_axis", gamepad_axis_value(global.gamepadCurrent, _axis_value))
			ds_map_set(global.gamepad_pressed, _s, false)
		}
	}