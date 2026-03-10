function loadString(_fname) //quickly load the string from a file
{
	var _buff = buffer_load(_fname)
	var _str = buffer_read(_buff, buffer_string)
	
	buffer_delete(_buff)
	return _str
}
global.inputMap = {}

function gamepad_axis_check_pressed(_axis, _invert = false)
{
	if !global.gamepadConnected
		exit;
	var _s = string($"{_axis}{_invert ? "_invert" : ""}")
	if !ds_map_find_value(global.gamepad_pressed, _s)
	{
		if (!_invert && gamepad_axis_value(global.gamepadCurrent, _axis) >= global.gamepadDeadzones.press) || (_invert && gamepad_axis_value(global.gamepadCurrent, _axis) <= -global.gamepadDeadzones.press)
		{
			var _saved_axis = ds_map_find_value(global.gamepad_pressed, $"{_axis}_axis")
			if (!_invert && _saved_axis < global.gamepadDeadzones.press) || (_invert && _saved_axis > -global.gamepadDeadzones.press)
			{
				show_debug_message("Pressed!")
				ds_map_set(global.gamepad_pressed, _s, true)
				ds_map_set(global.gamepad_pressed, $"{_axis}_axis", gamepad_axis_value(global.gamepadCurrent, gamepad_axis_value(global.gamepadCurrent, _axis)))
			}
		}
	}
	
	return ds_map_find_value(global.gamepad_pressed, _s)
}

function init_input() // Of course, You have to grab/set your inputs, initialize.
{
	global.gamepad_pressed = ds_map_create()
	var _axis = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
	for (var i = 0; i < array_length(_axis); i++)
	{
		var _s = string($"{_axis[i]}")
		ds_map_add(global.gamepad_pressed, _s, false)
		_s = string($"{_axis[i]}_invert")
		ds_map_add(global.gamepad_pressed, _s, false)
		_s = string($"{_axis[i]}_axis")
		ds_map_add(global.gamepad_pressed, _s, false)
	}
	if !file_exists(working_directory + "input.dat")
	{
		
		/*
		 * But how? Well, first thing you should do is define WHAT inputs you're gonna have. 
		*/
		/*
		var Inputs = {}
		// Why a LAME struct? Well, Because we can do fun defining thing without having to rely on an array!
		Inputs.leftKey = vk_left
		Inputs.rightKey = vk_right
		Inputs.upKey = vk_up
		Inputs.downKey = vk_down
		Inputs.jumpKey = ord("Z")
		// A huge struct for our inputs, wow! Nobody likes unsorted structs, so why dont we separate them?
		 */
		 
		var InputsKey = {}
		InputsKey.left = [vk_left]
		InputsKey.right = [vk_right]
		InputsKey.up = [vk_up]
		InputsKey.down = [vk_down]
		InputsKey.jump = [ord("Z")]
		InputsKey.slap = [ord("X")]
		InputsKey.taunt = [ord("C")]
		InputsKey.attack = [vk_shift]
		InputsKey.start = [vk_escape]
		InputsKey.superjump = []
		InputsKey.groundpound = []
		InputsKey.menu_left = [vk_left]
		InputsKey.menu_right = [vk_right]
		InputsKey.menu_up = [vk_up]
		InputsKey.menu_down = [vk_down]
		InputsKey.menu_confirm = [ord("Z")]
		InputsKey.menu_back = [ord("X")]
		InputsKey.menu_clear = [ord("C")]
		
		var InputsPad = {}
		InputsPad.left = [gp_padl, "joyLL"]
		InputsPad.right = [gp_padr, "joyLR"]
		InputsPad.up = [gp_padu, "joyLU"]
		InputsPad.down = [gp_padd, "joyLD"]
		InputsPad.jump = [gp_face1]
		InputsPad.slap = [gp_face3]
		InputsPad.taunt = [gp_face4]
		InputsPad.attack = [gp_shoulderr, gp_shoulderrb]
		InputsPad.start = [gp_start]
		InputsPad.superjump = []
		InputsPad.groundpound = []
		InputsPad.menu_left = [gp_padl, "joyLL"]
		InputsPad.menu_right = [gp_padr, "joyLR"]
		InputsPad.menu_up = [gp_padu, "joyLU"]
		InputsPad.menu_down = [gp_padd, "joyLD"]
		InputsPad.menu_confirm = [gp_face1]
		InputsPad.menu_back = [gp_face3]
		InputsPad.menu_clear = [gp_face4]
		// Splendid! Default keys that we can read into a ini file (if you're into that sort of mumbo jumbo)
		// But now, as for actually reading them, I GUESS we have to rely on an array... Or....
		// Read all of the inputs individually YES! ITS GENIUS! You've outdone yourself again MZX.
			// But, support for multiple players kinda kills this, I'm not hard coding that shit brochacho (im hard as is ;3)
		// Wait.. But we do need a global to store these in, right?
		// Thats outside the script, silly!
		// Did you know that you can hold globals outside of a function in a script and they only get called in once in game?
		// Thats pretty useful.
		var players = 1 // 1 player. 1 is the lonelist but the strongest number.
		var inputs = [
		"left", 
		"right", 
		"down", 
		"up", 
		"jump", 
		"slap", 
		"taunt", 
		"attack", 
		"start", 
		"superjump", 
		"groundpound", 
		"menu_up",
		"menu_down",
		"menu_left", 
		"menu_right",
		"menu_confirm",
		"menu_back", 
		"menu_clear"] // All your inputs, so it can be read in an INI file.
		for (var i = 0; i < players; i++) // Loop through ALL the players, everyone gets a chance!
		{
			var p = $"Player{i + 1}" // You know- *chomps on a corndog* -write the player number.
			for (var q = 0; q < array_length(inputs); q++) // Loop through ALL the inputs, a loop within a loop.
			{
				var inp = inputs[q]
				var _inpKey = variable_instance_get(InputsKey, inp)
				var _inpPad = variable_instance_get(InputsPad, inp)
				
				variable_struct_set(global.inputMap, $"Inputs_{p}_{inp}Key", _inpKey)
				variable_struct_set(global.inputMap, $"Inputs_{p}_{inp}Pad", _inpPad)
				
				/* Sorry I went to go grab a coffee, where were we?
				 * Oh yeah, Adding all the keyboard keys to the input map, as you should of course
				 * Well, I dont think I need to explain what any of this bull!@#$ means, you could probably figure it out if youre not a toddler.
				 * But to give a rundown, It just reads.. uhh.. for an example
				 * > Reads "InputsPlayer1 - left from ini
				 * > Sets it to a default key we established in that struct earlier
				 * > Adds it to the input map under the key "Inputs_Player1_leftKey
				 * Ain't that neat? All neatly and nicely packed, and this is all only for 1 key!
				 * Now that we've read all our keys, its time to do the most... horrible.. and I mean HORRIBLE thing you have to make-
				 * -with an input system...
				*/
			}
		}
		var q = json_stringify(global.inputMap, true)
		var _file = file_text_open_write(working_directory + "input.dat");
		file_text_write_string(_file, q);
		file_text_close(_file);
		var p = loadString(working_directory + "input.dat")
		global.inputMap = json_parse(p);
	}
	else {
		var p = loadString(working_directory + "input.dat")
		global.inputMap = json_parse(p);
	}
	show_debug_message("Inputs initiallized!")
}

function reset_input() // Basically everything we just did, but now it resets your inputs to default.
{
	var start_time = get_timer(); 
	global.inputMap = {}
	
	var InputsKey = {}
		InputsKey.left = [vk_left]
		InputsKey.right = [vk_right]
		InputsKey.up = [vk_up]
		InputsKey.down = [vk_down]
		InputsKey.jump = [ord("Z")]
		InputsKey.slap = [ord("X")]
		InputsKey.taunt = [ord("C")]
		InputsKey.attack = [vk_shift]
		InputsKey.start = [vk_escape]
		InputsKey.superjump = []
		InputsKey.groundpound = []
		InputsKey.menu_left = [vk_left]
		InputsKey.menu_right = [vk_right]
		InputsKey.menu_up = [vk_up]
		InputsKey.menu_down = [vk_down]
		InputsKey.menu_confirm = [ord("Z")]
		InputsKey.menu_back = [ord("X")]
		InputsKey.menu_clear = [ord("C")]
		
		var InputsPad = {}
		InputsPad.left = [gp_padl, "joyLL"]
		InputsPad.right = [gp_padr, "joyLR"]
		InputsPad.up = [gp_padu, "joyLU"]
		InputsPad.down = [gp_padd, "joyLD"]
		InputsPad.jump = [gp_face1]
		InputsPad.slap = [gp_face3]
		InputsPad.taunt = [gp_face4]
		InputsPad.attack = [gp_shoulderr, gp_shoulderrb]
		InputsPad.start = [gp_start]
		InputsPad.superjump = []
		InputsPad.groundpound = []
		InputsPad.menu_left = [gp_padl, "joyLL"]
		InputsPad.menu_right = [gp_padr, "joyLR"]
		InputsPad.menu_up = [gp_padu, "joyLU"]
		InputsPad.menu_down = [gp_padd, "joyLD"]
		InputsPad.menu_confirm = [gp_face1]
		InputsPad.menu_back = [gp_face3]
		InputsPad.menu_clear = [gp_face4]
		var players = 1
		var inputs = [
		"left", 
		"right", 
		"down", 
		"up", 
		"jump", 
		"slap", 
		"taunt", 
		"attack", 
		"start", 
		"superjump", 
		"groundpound", 
		"menu_up",
		"menu_down",
		"menu_left", 
		"menu_right",
		"menu_confirm",
		"menu_back", 
		"menu_clear"]
	for (var i = 0; i < players; i++)
	{
		var p = $"Player{i + 1}"
		for (var q = 0; q < array_length(inputs); q++)
		{
			var inp = inputs[q]
			var _inpKey = variable_instance_get(InputsKey, inp)
			var _inpPad = variable_instance_get(InputsPad, inp)
			
			
			variable_struct_set(global.inputMap, $"Inputs_{p}_{inp}Key", _inpKey)
			variable_struct_set(global.inputMap, $"Inputs_{p}_{inp}Pad", _inpPad)
			
		}
	}
	
	var q = json_stringify(global.inputMap, true)
	var _file = file_text_open_write(working_directory + "input.dat");
	file_text_write_string(_file, q);
	file_text_close(_file);
	var p = loadString(working_directory + "input.dat")
	global.inputMap = json_parse(p);
	
	
	var end_time = get_timer(); 
	var timeFinal = end_time - start_time;
	show_debug_message("Inputs reset in {0}ms!", timeFinal)
}

/*
 * ########################
 * THE ACTUAL INPUT STUFF
 * ########################
 * 
 * You thought the hard part was over? (Well if you thought that was hard, you might wanna take off your pants.)
 * Yup, actually READING your input (as in, like, actually inputting yo input n- shiz) is WAAAY harder than that baby stuff we just did
 * Infact, I'm pretty sure I put SeeJ into Cardiac Arrest, call 911!
 * 
 * Anyway, How the hell do we go about this?
 * Well, we could do it the LAME way and hardcode each input to read from, but thats fucking stupid, never hardcode anything.
*/

function read_input(_key /*Like, the map name*/, _press = false)
{
	// Time to read the inputs! (not get them yet but thats coming close too)
	var canRead = true // just incase you ever want to disable inputs for a cutscene or something
	var _returnKey = false
	var _returnPad = false
	// Keyboard Input
	var keyboardKey = global.inputMap[$ $"Inputs_Player{key_player}_{_key}Key"]
	var gamepadButton = global.inputMap[$ $"Inputs_Player{key_player}_{_key}Pad"]
	if obj_shell.isOpen
		canRead = false
	var _axLH = gamepad_axis_value(global.gamepadCurrent, gp_axislh)
	var _axLV = gamepad_axis_value(global.gamepadCurrent, gp_axislv)
	var _axRH = gamepad_axis_value(global.gamepadCurrent, gp_axisrh)
	var _axRV = gamepad_axis_value(global.gamepadCurrent, gp_axisrv)
	var _pDeadzone = global.gamepadDeadzones.press
	_pDeadzone = clamp(_pDeadzone, 0, 0.99)
	var _horizDeadzone = global.gamepadDeadzones.horizontal
	_horizDeadzone = clamp(_horizDeadzone, 0, 0.99)
	var _vertDeadzone = global.gamepadDeadzones.vertical
	_vertDeadzone = clamp(_vertDeadzone, 0, 0.99)
	switch _press
	{
		case true:
			if array_length(keyboardKey) != 0
			{
				for (var i = 0; i < array_length(keyboardKey); i++)
				{
					if keyboard_check_pressed(keyboardKey[i])
						_returnKey = true
				}
			}
			if array_length(gamepadButton) != 0
			{
				for (var i = 0; i < array_length(gamepadButton); i++)
				{
					if is_string(gamepadButton[i])
					{
						switch gamepadButton[i]
						{
							case "joyLL":
								if gamepad_axis_check_pressed(gp_axislh, true)
									_returnPad = true
							break
							case "joyLR":
								if gamepad_axis_check_pressed(gp_axislh)
									_returnPad = true
							break
							case "joyLU":
								if gamepad_axis_check_pressed(gp_axislv, true)
									_returnPad = true
							break
							case "joyLD":
								if gamepad_axis_check_pressed(gp_axislv)
									_returnPad = true
							break
							case "joyRL":
								if _axRH > -0.1
									obj_inputController.horizontalStickPressedR = false
								if _axRH < -(_pDeadzone) && 
								obj_inputController.horizontalStickPressedR == false 
								{
									_returnPad = true
									obj_inputController.horizontalStickPressedR = true
								}
							break
							case "joyRR":
								if _axRH < 0.1
									obj_inputController.horizontalStickPressedR = false
								if _axRH > (_pDeadzone) && 
								obj_inputController.horizontalStickPressedR == false 
								{
									_returnPad = true
									obj_inputController.horizontalStickPressedR = true
								}
							break
							case "joyRU":
								if _axRV < -(_pDeadzone) && 
								obj_inputController.verticalStickPressedR == false 
								{
									_returnPad = true
									obj_inputController.verticalStickPressedR = true
								}
								else if _axRV < 0.1
									obj_inputController.verticalStickPressedR = false
							break
							case "joyRD":
								if _axRV > (_pDeadzone) && 
								obj_inputController.verticalStickPressedR == false 
								{
									_returnPad = true
									obj_inputController.verticalStickPressedR = true
								}
								else if _axRV > -0.1
									obj_inputController.verticalStickPressedR = false
							break
						}
					}
					else if gamepad_button_check_pressed(global.gamepadCurrent, gamepadButton[i])
						_returnPad = true
				}
			}
			break
		case false:
			if array_length(keyboardKey) != 0
			{
				for (var i = 0; i < array_length(keyboardKey); i++)
				{
					if keyboard_check(keyboardKey[i])
						_returnKey = true
				}
			}
			if array_length(gamepadButton) != 0
			{
				for (var i = 0; i < array_length(gamepadButton); i++)
				{
					if is_string(gamepadButton[i])
					{
						switch gamepadButton[i]
						{
							case "joyLL":
								if _axLH < -(_horizDeadzone)
									_returnPad = true
							break
							case "joyLR":
								if _axLH > (_horizDeadzone)
									_returnPad = true
							break
							case "joyLU":
								if _axLV < -(_vertDeadzone)
									_returnPad = true
							break
							case "joyLD":
								if _axLV > (_vertDeadzone)
									_returnPad = true
							break
							case "joyRL":
								if _axRH < -(_horizDeadzone)
									_returnPad = true
							break
							case "joyRR":
								if _axRH > (_horizDeadzone)
									_returnPad = true
							break
							case "joyRU":
								if _axRV < -(_vertDeadzone)
									_returnPad = true
							break
							case "joyRD":
								if _axRV > (_vertDeadzone)
									_returnPad = true
							break
						}
					}
					else if gamepad_button_check(global.gamepadCurrent, gamepadButton[i])
						_returnPad = true
				}
			}
			break
	}
	
	if canRead
		return _returnKey || _returnPad
	else
		return false
	
}

/* Let's run down the pasta I just made;
 * Firstly, it reads the key stored in the input map and stores that in a local variable
 * 	Local variables are like variables that dont really last and are just a substitute for whatever you put in for easy reference later
 * Then, a SWITCH CASE gets shoved in, now checking for that little '_press' variable that the function contains
 * If that _press variable is true, then it only has to check if a key is pressed
 *# [But first (and I went back just to add this as of writing this comment 10:19 6/19/25) it loops through all the possible inputs stored in an array.
 *#	Because multiple inputs are FUN! YAY!]
 * If its not, then it checks for if its held, pretty simple.
 * Now, for the actual get input part*/
 
function getMenu_input()
{
	key_player = 1
	key_left = -read_input("menu_left")
	key_left2 = -read_input("menu_left", true)
	
	key_right = read_input("menu_right")
	key_right2 = read_input("menu_right", true)
	
	key_up = read_input("menu_up")
	key_up2 = read_input("menu_up", true)
	
	key_down = read_input("menu_down")
	key_down2 = read_input("menu_down", true)
	
	key_jump = read_input("menu_confirm")
	key_jump2 = read_input("menu_confirm", true)
	
	key_slap = read_input("menu_back")
	key_slap2 = read_input("menu_back", true)
	
	key_taunt = read_input("menu_clear")
	key_taunt2 = read_input("menu_clear", true)
	key_start2 = read_input("start", true)
}
function get_input()
{
	key_player = 1
	
	key_left = -read_input("left")
	key_left2 = -read_input("left", true)
	
	key_right = read_input("right")
	key_right2 = read_input("right", true)
	
	key_up = read_input("up")
	key_up2 = read_input("up", true)
	
	key_down = read_input("down")
	key_down2 = read_input("down", true)
	
	key_jump = read_input("jump")
	key_jump2 = read_input("jump", true)
	
	key_slap = read_input("slap")
	key_slap2 = read_input("slap", true)
	
	key_taunt = read_input("taunt")
	key_taunt2 = read_input("taunt", true)
	
	key_attack = read_input("attack")
	key_attack2 = read_input("attack", true)
	
	key_start = read_input("start")
	key_start2 = read_input("start", true)
	
	key_superjump = read_input("superjump")
	key_superjump2 = read_input("superjump", true)
	
	key_groundpound = read_input("groundpound")
	key_groundpound2 = read_input("groundpound", true)
}