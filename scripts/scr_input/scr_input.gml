function loadString(_fname) //quickly load the string from a file
{
	var _buff = buffer_load(_fname)
	var _str = buffer_read(_buff, buffer_string)
	
	buffer_delete(_buff)
	return _str
}

function scr_button_pressed(_index)
{
	if gamepad_is_connected(_index)
	{
		if gamepad_button_check_pressed(_index, gp_face1) || gamepad_button_check_pressed(_index, gp_start)
			return _index
	}
	return -1
}

function gamepad_is_axis(_axis)
{
    var _axes = [gp_axisrh, gp_axisrv, gp_axislv, gp_axislh];
    
    if (array_contains(_axes, _axis))
        return true;
    
    return false;
}

function gamepad_find_axis_string(_str)
{
	switch _str
	{
		case "joystickL_left":
			return {stick: gp_axislh, invert: true}
		case "joystickL_right":
			return {stick: gp_axislh, invert: false}
		case "joystickL_up":
			return {stick: gp_axislv, invert: true}
		case "joystickL_down":
			return {stick: gp_axislv, invert: false}
		case "joystickR_left":
			return {stick: gp_axisrh, invert: true}
		case "joystickR_right":
			return {stick: gp_axisrh, invert: false}
		case "joystickR_up":
			return {stick: gp_axisrv, invert: true}
		case "joystickR_down":
			return {stick: gp_axisrv, invert: false}
		default:
			return -4
	}
}

function gamepad_find_axis_deadzone(_axis)
{
	switch _axis
	{
		case gp_axislh:
		case gp_axisrh:
			return global.gamepad_deadzones.horizontal
		case gp_axislv:
		case gp_axisrv:
			return global.gamepad_deadzones.vertical
	}
}

function gamepad_reset_axis_pressed()
{
	var _axes = [gp_axisrh, gp_axisrv, gp_axislv, gp_axislh];
	for (var i = 0; i < array_length(_axes); i++)
	{
		var _val = gamepad_axis_value(global.player_gamepad_current, _axes[i])
		if ds_map_find_value(global.gamepad_axis_pressed, _axes[i]) && _val < global.gamepad_deadzones.press && _val > -global.gamepad_deadzones.press
			ds_map_set(global.gamepad_axis_pressed, _axes[i], false)
	}
}

function input_start(_restart = false)
{
	if _restart
	{
		ds_map_clear(global.input_map)
		global.key_map = {}
		file_delete(working_directory + "input.dat")
	}
	var _exists = file_exists(working_directory + "input.dat")
	
	var _inputsKeyboard = {}
	struct_set(_inputsKeyboard, "left", [vk_left])
	struct_set(_inputsKeyboard, "down", [vk_down])
	struct_set(_inputsKeyboard, "up", [vk_up])
	struct_set(_inputsKeyboard, "right", [vk_right])
	struct_set(_inputsKeyboard, "jump", [ord("Z")])
	struct_set(_inputsKeyboard, "grab", [ord("X")])
	struct_set(_inputsKeyboard, "taunt", [ord("C")])
	struct_set(_inputsKeyboard, "attack", [vk_shift])
	struct_set(_inputsKeyboard, "start", [vk_escape, vk_enter])
	struct_set(_inputsKeyboard, "superjump", [])
	struct_set(_inputsKeyboard, "groundpound", [])
	struct_set(_inputsKeyboard, "menu_left", [vk_left])
	struct_set(_inputsKeyboard, "menu_down", [vk_down])
	struct_set(_inputsKeyboard, "menu_up", [vk_up])
	struct_set(_inputsKeyboard, "menu_right", [vk_right])
	struct_set(_inputsKeyboard, "menu_confirm", [ord("Z")])
	struct_set(_inputsKeyboard, "menu_back", [ord("X")])
	struct_set(_inputsKeyboard, "menu_clear", [ord("C")])
	
	var _inputsGamepad = {}
	struct_set(_inputsGamepad, "left", [gp_padl, "joystickL_left"])
	struct_set(_inputsGamepad, "down", [gp_padd, "joystickL_down"])
	struct_set(_inputsGamepad, "up", [gp_padu, "joystickL_up"])
	struct_set(_inputsGamepad, "right", [gp_padr, "joystickL_right"])
	struct_set(_inputsGamepad, "jump", [gp_face1])
	struct_set(_inputsGamepad, "grab", [gp_face3])
	struct_set(_inputsGamepad, "taunt", [gp_face4])
	struct_set(_inputsGamepad, "attack", [gp_shoulderr, gp_shoulderrb])
	struct_set(_inputsGamepad, "start", [gp_start])
	struct_set(_inputsGamepad, "superjump", [])
	struct_set(_inputsGamepad, "groundpound", [])
	struct_set(_inputsGamepad, "menu_left", [gp_padl, "joystickL_left"])
	struct_set(_inputsGamepad, "menu_down", [gp_padd, "joystickL_down"])
	struct_set(_inputsGamepad, "menu_up", [gp_padu, "joystickL_up"])
	struct_set(_inputsGamepad, "menu_right", [gp_padr, "joystickL_right"])
	struct_set(_inputsGamepad, "menu_confirm", [gp_face1])
	struct_set(_inputsGamepad, "menu_back", [gp_face3])
	struct_set(_inputsGamepad, "menu_clear", [gp_face4])
	
	var _struct_names = struct_get_names(_inputsKeyboard)
	var _struct_size = array_length(_struct_names) 
	
	
	for (var i = 0; i < _struct_size; i++)
	{
		var _struct = _struct_names[i]
		if !_exists
		{
			var _struct_value_key = struct_get(_inputsKeyboard, _struct)
			var _struct_value_pad = struct_get(_inputsGamepad, _struct)
			struct_set(global.key_map, $"{_struct}_key", _struct_value_key)
			struct_set(global.key_map, $"{_struct}_pad", _struct_value_pad)
			var q = json_stringify(global.key_map, true)
			var _file = file_text_open_write(working_directory + "input.dat");
			file_text_write_string(_file, q);
			file_text_close(_file);
			var p = loadString(working_directory + "input.dat")
		}
		else
		{
			var p = loadString(working_directory + "input.dat")
			global.key_map = json_parse(p);
			var _struct_value_key = struct_get(global.key_map, $"{_struct}_key")
			var _struct_value_pad = struct_get(global.key_map, $"{_struct}_pad")
		}
		
		var _input =
		{}
		with _input
		{
			key_input_array = _struct_value_key
			pad_input_array = _struct_value_pad
			is_pressed = false
			is_held = false
			
			update = function()
			{
				self.is_pressed = self.pressed()
				self.is_held = self.held()
			}
			
			pressed = function()
			{
				for (var i = 0; i < array_length(self.key_input_array); i++)
				{
					if keyboard_check_pressed(self.key_input_array[i])
						return true;
				}
				
				for (var i = 0; i < array_length(self.pad_input_array); i++)
				{
					var _bt = self.pad_input_array[i]
					if is_string(_bt)
					{
						var _gp = gamepad_find_axis_string(_bt)
						if _gp == -4
							return false
						else
						{
							if !_gp.invert
							{
								if gamepad_axis_value(global.player_gamepad_current, _gp.stick) >= global.gamepad_deadzones.press && ds_map_find_value(global.gamepad_axis_pressed, _gp.stick) == false
								{
									ds_map_set(global.gamepad_axis_pressed, _gp.stick, true)
									return true
								}
							}
								
							else if _gp.invert
							{
								if gamepad_axis_value(global.player_gamepad_current, _gp.stick) <= -global.gamepad_deadzones.press && ds_map_find_value(global.gamepad_axis_pressed, _gp.stick) == false
								{
									ds_map_set(global.gamepad_axis_pressed, _gp.stick, true)
									return true
								}
							}
						}
					}
					else
					{
						if gamepad_button_check_pressed(global.player_gamepad_current, _bt)
							return true
					}
				}
				return false;
			}
			held = function()
			{
				for (var i = 0; i < array_length(self.key_input_array); i++)
				{
					if keyboard_check(self.key_input_array[i])
						return true;
				}
				
				for (var i = 0; i < array_length(self.pad_input_array); i++)
				{
					var _bt = self.pad_input_array[i]
					if is_string(_bt)
					{
						var _gp = gamepad_find_axis_string(_bt)
						if _gp == -4
							return false
						else
						{
							if !_gp.invert
								return gamepad_axis_value(global.player_gamepad_current, _gp.stick) >= gamepad_find_axis_deadzone(_gp.stick)
							else if _gp.invert
								return gamepad_axis_value(global.player_gamepad_current, _gp.stick) <= -gamepad_find_axis_deadzone(_gp.stick)
						}
					}
					else
					{
						if gamepad_button_check(global.player_gamepad_current, _bt)
							return true
					}
				}
				return false;
			}
		}
		ds_map_add(global.input_map, $"{_struct}", _input)
	}
}

function read_input(_input, _press = false)
{
	var _return = false
	var _key_board = $"{_input}"
	var _map = ds_map_find_value(global.input_map, _key_board)
	if obj_shell.isOpen
	{
		return false;
	}
	if _press
		_return = _map.is_pressed
	else
		_return = _map.is_held
	return _return
	
}

function get_menu_input()
{
	key_left = -read_input("menu_left")
	key_left_pressed = -read_input("menu_left", true)
	
	key_right = read_input("menu_right")
	key_right_pressed = read_input("menu_right", true)
	
	key_up = read_input("menu_up")
	key_up_pressed = read_input("menu_up", true)
	
	key_down = read_input("menu_down")
	key_down_pressed = read_input("menu_down", true)
	
	key_jump = read_input("menu_confirm")
	key_jump_pressed = read_input("menu_confirm", true)
	
	key_grab = read_input("menu_back")
	key_grab_pressed = read_input("menu_back", true)
	
	key_taunt = read_input("menu_clear")
	key_taunt_pressed = read_input("menu_clear", true)
	
	key_start = read_input("start")
	key_start_pressed = read_input("start", true)
}

function get_input()
{
	key_left = -read_input("left")
	key_left_pressed = -read_input("left", true)
	
	key_up = read_input("up")
	key_up_pressed = read_input("up", true)
	
	key_down = read_input("down")
	key_down_pressed = read_input("down", true)
	
	key_right = read_input("right")
	key_right_pressed = read_input("right", true)
	
	key_jump = read_input("jump")
	key_jump_pressed = read_input("jump", true)
	
	key_grab = read_input("grab")
	key_grab_pressed = read_input("grab", true)
	
	key_taunt = read_input("taunt")
	key_taunt_pressed = read_input("taunt", true)
	
	key_attack = read_input("attack")
	key_attack_pressed = read_input("attack", true)
	
	key_start = read_input("start")
	key_start_pressed = read_input("start", true)
	
	key_superjump = read_input("superjump")
	key_superjump_pressed = read_input("superjump", true)
	
	key_groundpound = read_input("groundpound")
	key_groundpound_pressed = read_input("groundpound", true)
}