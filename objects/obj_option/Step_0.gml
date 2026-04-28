if buffer == 0
{
	get_menu_input()
	var m = menus[currentmenu]
	var opt = m.options
	var _length = array_length(opt) - 1
	var q = opt[selected]
	BGX--
	BGY--
	if q.type != option.slider
		move = key_left_pressed + key_right_pressed
	else
		move = key_left + key_right
	if move != 0 && q.type != option.press && q.type != option.key
	{
		q.val += move
		q.val = clamp(q.val, 0, q.max)
		q.func()
		if q.type != option.slider
			FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect")
	}
	var _oSelect = selected
	var _move2 = key_down_pressed - key_up_pressed
	if _move2 != 0 && changingBind == false
	{
		selected += _move2
		selected = clamp(selected, 0, _length)
		if selected != _oSelect
			FMODevent_oneshot("event:/Sfx/UI/Pause/step")
	}
	if key_grab_pressed && q.selecting == false && changingBind == false
	{
		m.backfunc()
		FMODevent_oneshot("event:/Sfx/UI/Pause/menuback")
	}
	if q.type != option.key && q.type != option.slider
	{
		if key_jump_pressed
		{
			FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect")
			if q.type != option.press
			{
				q.val += 1
				q.val = wrap(q.val, 0, q.max)
			}
			q.func()
		}
	}
	if q.type == option.slider
	{
		if move != 0
		{
			q.moving = true
			if currentmenu == 1
				fmod_studio_event_instance_set_paused(screamSnd, false);
			if !FMODevent_isplaying(screamSnd)
				fmod_studio_event_instance_start(screamSnd);
			fmod_studio_event_instance_set_volume(screamSnd, (q.val / 100) * global.MasterVolume) 
		}
		else
		{
			q.moving = false
			fmod_studio_event_instance_set_paused(screamSnd, true);
		}
	}
	if q.type != option.slider
		fmod_studio_event_instance_set_paused(screamSnd, true);
	if currentmenu == 6
	{
		if keyboard_check_pressed(vk_f1) && changingBind == false
		{
			input_start(true)
			FMODevent_oneshot("event:/Sfx/UI/Pause/Controls/reset")
		}
		if q.type == option.key
		{
			if !changingBind
			{
				if key_jump_pressed && array_length(global.key_map[$ q.key]) < 5
				{
					changingBind = true
					changingBindTimer = 60 * 3
					FMODevent_oneshot("event:/Sfx/UI/Pause/Controls/select")
				}
				else if key_taunt_pressed
				{
					array_delete(global.key_map[$ q.key], array_length(global.key_map[$ q.key]) - 1, 1)
					FMODevent_oneshot("event:/Sfx/UI/Pause/Controls/clearbind")
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).key_input_array = global.key_map[$ q.key]
				}
			}
			else if keyboard_check_pressed(vk_anykey)
			{
				draw_set_font(global.npcfont)
				var keyboardKey = global.key_map[$ q.key]
					if !array_contains(keyboardKey, keyboard_key) && 
						(string_width(string_upper(chr(keyboard_key))) > 0 ||
						keyboard_key == vk_up ||
						keyboard_key == vk_down ||
						keyboard_key == vk_left ||
						keyboard_key == vk_right ||
						keyboard_key == vk_escape ||
						keyboard_key == vk_shift ||
						keyboard_key == vk_space ||
						keyboard_key == vk_control)
					{
						array_push(global.key_map[$ q.key], keyboard_key)
						FMODevent_oneshot("event:/Sfx/UI/Pause/Controls/set")
						var _str = string_delete(q.key, string_length(q.key) - 3, 4)
						ds_map_find_value(global.input_map, _str).key_input_array = global.key_map[$ q.key]
						changingBind = false
						changeDetec = true
					}
			}
		}
	}
	if currentmenu == 8
	{
		if keyboard_check_pressed(vk_f1) && changingBind == false
		{
			input_start(true)
			FMODevent_oneshot("event:/Sfx/UI/Pause/Controls/reset")
		}
		if q.type == option.key
		{
			if !changingBind
			{
				if key_jump_pressed && array_length(global.key_map[$ q.key]) < 5
				{
					changingBind = true
					changingBindTimer = 60 * 3
				}
				else if key_taunt_pressed
				{
					array_delete(global.key_map[$ q.key], array_length(global.key_map[$ q.key]) - 1, 1)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
				}
			}
			else
			{
				if gamepad_button_check_pressed(global.player_gamepad_current, gp_face1)
				{
					array_push(global.key_map[$ q.key], gp_face1)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_face2)
				{
					array_push(global.key_map[$ q.key], gp_face2)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_face3)
				{
					array_push(global.key_map[$ q.key], gp_face3)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_shoulderlb)
				{
					array_push(global.key_map[$ q.key], gp_shoulderlb)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_shoulderrb)
				{
					array_push(global.key_map[$ q.key], gp_shoulderrb)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_shoulderl)
				{
					array_push(global.key_map[$ q.key], gp_shoulderl)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_shoulderr)
				{
					array_push(global.key_map[$ q.key], gp_shoulderr)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_face4)
				{
					array_push(global.key_map[$ q.key], gp_face4)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_padu)
				{
					array_push(global.key_map[$ q.key], gp_padu)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_padd)
				{
					array_push(global.key_map[$ q.key], gp_padd)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_padl)
				{
					array_push(global.key_map[$ q.key], gp_padl)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_padr)
				{
					array_push(global.key_map[$ q.key], gp_padr)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_stickl)
				{
					array_push(global.key_map[$ q.key], gp_stickl)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_stickr)
				{
					array_push(global.key_map[$ q.key], gp_stickr)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_start)
				{
					array_push(global.key_map[$ q.key], gp_start)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_button_check_pressed(global.player_gamepad_current, gp_select)
				{
					array_push(global.key_map[$ q.key], gp_select)
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axislh) < -0.5
				{
					array_push(global.key_map[$ q.key], "joystickL_left")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axislh) > (0.5)
				{
					array_push(global.key_map[$ q.key], "joystickL_right")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axislv) < -0.5
				{
					array_push(global.key_map[$ q.key], "joystickL_up")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axislv) > (0.5)
				{
					array_push(global.key_map[$ q.key], "joystickL_down")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axisrh) < -0.5
				{
					array_push(global.key_map[$ q.key], "joystickR_left")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axisrh) > (0.5)
				{
					array_push(global.key_map[$ q.key], "joystickR_right")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axisrv) < -0.5
				{
					array_push(global.key_map[$ q.key], "joystickR_up")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					changingBind = false
					changeDetec = true
					q.func()
				}
				else if gamepad_axis_value(global.player_gamepad_current, gp_axisrv) > (0.5)
				{
					array_push(global.key_map[$ q.key], "joystickR_down")
					
					var _str = string_delete(q.key, string_length(q.key) - 3, 4)
					ds_map_find_value(global.input_map, _str).pad_input_array = global.key_map[$ q.key]
					
					changingBind = false
					changeDetec = true
					q.func()
				}
			}
		}
	}
}
buffer = approach(buffer, 0, 1)