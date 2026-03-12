if buffer == 0
{
	getMenu_input()
	var m = menus[currentmenu]
	var opt = m.options
	var _length = array_length(opt) - 1
	var q = opt[selected]
	BGX--
	BGY--
	if q.type != option.slider
		move = key_left2 + key_right2
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
	var _move2 = key_down2 - key_up2
	if _move2 != 0 && changingBind == false
	{
		selected += _move2
		selected = clamp(selected, 0, _length)
		if selected != _oSelect
			FMODevent_oneshot("event:/Sfx/UI/Pause/step")
	}
	if key_slap2 && q.selecting == false && changingBind == false
	{
		m.backfunc()
		FMODevent_oneshot("event:/Sfx/UI/Pause/menuback")
	}
	if q.type != option.key && q.type != option.slider
	{
		if key_jump2
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
			reset_input()
		}
		if q.type == option.key
		{
			if !changingBind
			{
				if key_jump2 && array_length(global.inputMap[$ q.key]) < 5
				{
					changingBind = true
					changingBindTimer = 60 * 3
				}
				else if key_taunt2
				{
					array_delete(global.inputMap[$ q.key], array_length(global.inputMap[$ q.key]) - 1, 1)
				}
			}
			else if keyboard_check_pressed(vk_anykey)
			{
				draw_set_font(global.npcfont)
				var keyboardKey = global.inputMap[$ q.key]
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
						array_push(global.inputMap[$ q.key], keyboard_key)
						changingBind = false
					}
			}
		}
	}
	if currentmenu == 8
	{
		if keyboard_check_pressed(vk_f1) && changingBind == false
		{
			reset_input()
		}
		if q.type == option.key
		{
			if !changingBind
			{
				if key_jump2 && array_length(global.inputMap[$ q.key]) < 5
				{
					changingBind = true
					changingBindTimer = 60 * 3
				}
				else if key_taunt2
				{
					array_delete(global.inputMap[$ q.key], array_length(global.inputMap[$ q.key]) - 1, 1)
				}
			}
			else
			{
				if gamepad_button_check_pressed(global.gamepadCurrent, gp_face1)
				{
					array_push(global.inputMap[$ q.key], gp_face1)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_face2)
				{
					array_push(global.inputMap[$ q.key], gp_face2)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_face3)
				{
					array_push(global.inputMap[$ q.key], gp_face3)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderlb)
				{
					array_push(global.inputMap[$ q.key], gp_shoulderlb)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderrb)
				{
					array_push(global.inputMap[$ q.key], gp_shoulderrb)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderl)
				{
					array_push(global.inputMap[$ q.key], gp_shoulderl)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderr)
				{
					array_push(global.inputMap[$ q.key], gp_shoulderr)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_face4)
				{
					array_push(global.inputMap[$ q.key], gp_face4)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_padu)
				{
					array_push(global.inputMap[$ q.key], gp_padu)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_padd)
				{
					array_push(global.inputMap[$ q.key], gp_padd)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_padl)
				{
					array_push(global.inputMap[$ q.key], gp_padl)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_padr)
				{
					array_push(global.inputMap[$ q.key], gp_padr)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_stickl)
				{
					array_push(global.inputMap[$ q.key], gp_stickl)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_stickr)
				{
					array_push(global.inputMap[$ q.key], gp_stickr)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_start)
				{
					array_push(global.inputMap[$ q.key], gp_start)
					changingBind = false
					q.func()
				}
				else if gamepad_button_check_pressed(global.gamepadCurrent, gp_select)
				{
					array_push(global.inputMap[$ q.key], gp_select)
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axislh) < -(0.5)
				{
					array_push(global.inputMap[$ q.key], "joyLL")
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axislh) > (0.5)
				{
					array_push(global.inputMap[$ q.key], "joyLR")
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axislv) < -(0.5)
				{
					array_push(global.inputMap[$ q.key], "joyLU")
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axislv) > (0.5)
				{
					array_push(global.inputMap[$ q.key], "joyLD")
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axisrh) < -(0.5)
				{
					array_push(global.inputMap[$ q.key], "joyRL")
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axisrh) > (0.5)
				{
					array_push(global.inputMap[$ q.key], "joyRR")
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axisrv) < -(0.5)
				{
					array_push(global.inputMap[$ q.key], "joyRU")
					changingBind = false
					q.func()
				}
				else if gamepad_axis_value(global.gamepadCurrent, gp_axisrv) > (0.5)
				{
					array_push(global.inputMap[$ q.key], "joyRD")
					changingBind = false
					q.func()
				}
			}
		}
	}
}
buffer = approach(buffer, 0, 1)