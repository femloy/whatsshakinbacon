enum option
{
	main,
	audio,
	video,
	videoWindowMode,
	controlsMain,
	controlsKeyMain,
	controlsKey,
	controlsPadMain,
	controlsPad,
	controlsPadDeadzones,
	game,
	
	//anchors
	center,
	left,
	keys,
	
	//types
	press,
	multi,
	slider,
	key,
}
buffer = 0
menus = []
currentmenu = 0
selected = 0
move = 0
backgrounds = []
changingBind = false
changingBindTimer = 60 * 3
keyscroll = 0
var addBackground = function(_menu = [], _index, _alpha = 0)
{
	var q = 
	{
		menu: _menu,
		index: _index,
		alpha: _alpha
	}
	array_push(backgrounds, q)
}
addBackground([0], 0, 1)
addBackground([1], 1)
addBackground([2, 10], 2)
addBackground([3], 3)
addBackground([4, 5, 6, 7, 8, 9], 4) // 6, 7
BGX = 0
BGY = 0
depth = obj_pause.depth - 1
screamSnd = FMODcreate_event("event:/Sfx/UI/Pause/slider")
fmod_studio_event_instance_start(screamSnd);
fmod_studio_event_instance_set_paused(screamSnd, true);

#region Functions

addPause_icon = function(_index) constructor
{
	index = _index
	alpha = 0
}

goto_menu = function(_id)
{
	for (var i = 0; i < array_length(menus); i++)
	{
		var m = menus[i]
		if m.menuid == _id
			currentmenu = i
	}
	show_debug_message(currentmenu)
	selected = 0
}

create_menu = function(_id, _anchor, _ypad, _func)
{
	var _opt = 
	{
		menuid: _id,
		anchor: _anchor,
		ypad: _ypad,
		options: [],
		backfunc: _func
	}
	return _opt;
}

add_option_press = function(_id, _name, _function, _icon = -4)
{
	var q = 
	{
		name: _name,
		func: _function,
		type: option.press,
		selecting: false,
		icon: _icon
	}
	array_push(_id.options, q)
	return q;
}

add_option_ext = function(_id, _type, _name, _function, _value, _max, _toggle = ["option_off", "option_on"])
{
	var q = 
	{
		specialNumber: 0,
		name: _name,
		func: _function,
		val: _value,
		toggle: _toggle,
		type: _type,
		max: _max,
		moving: false,
		selecting: false
	}
	array_push(_id.options, q)
	return q;
}

add_option_key = function(_id, _iconIndex, _function, _key = "left_key")
{
	var q = 
	{
		type: option.key,
		iconIndex: _iconIndex,
		key: _key,
		func: _function,
		selecting: false,
	}
	array_push(_id.options, q)
	return q;
}

#endregion

#region Main

	var category = create_menu(option.main, option.center, 48, function()
	{
		obj_pause.buffer = 2
		instance_destroy()
	})
	
	add_option_press(category, "option_audio", function()
	{
		goto_menu(option.audio)
	}, new addPause_icon(4))
	
	add_option_press(category, "option_video", function()
	{
		goto_menu(option.video)
	}, new addPause_icon(5))
	
	
	add_option_press(category, "option_game", function()
	{
		goto_menu(option.game)
	}, new addPause_icon(6))

	add_option_press(category, "option_controls", function()
	{
		goto_menu(option.controlsMain)
	}, new addPause_icon(7))

	array_push(menus, category)

#endregion

#region Audio

	var AUDIO = create_menu(option.audio, option.left, 40, function()
	{
		goto_menu(option.main)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("General", "Music", global.MusicVolume)
		ini_write_real("General", "Sfx", global.SfxVolume)
		ini_write_real("General", "Master", global.MasterVolume)
		ini_write_real("General", "Ambiance", global.AmbianceVolume)
		ini_write_real("General", "UnfocusMute", global.unfocus_mute)
		
		ini_close()
	})

	add_option_press(AUDIO, "option_back", function()
	{
		goto_menu(option.main)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("General", "Music", global.MusicVolume)
		ini_write_real("General", "Sfx", global.SfxVolume)
		ini_write_real("General", "Master", global.MasterVolume)
		ini_write_real("General", "Ambiance", global.AmbianceVolume)
		ini_write_real("General", "UnfocusMute", global.unfocus_mute)
		
		ini_close()
	})
	
	add_option_ext(AUDIO, option.slider, "option_audio_master", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.MasterVolume = q.val / 100
		q.val = global.MasterVolume * 100
	}, global.MasterVolume * 100, 100)
	
	add_option_ext(AUDIO, option.slider, "option_audio_music", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.MusicVolume = q.val / 100
		q.val = global.MusicVolume * 100
	}, global.MusicVolume * 100, 100)
	
	add_option_ext(AUDIO, option.slider, "option_audio_ambiance", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.AmbianceVolume = q.val / 100
		q.val = global.AmbianceVolume * 100
	}, global.AmbianceVolume * 100, 100)
	
	add_option_ext(AUDIO, option.slider, "option_audio_sfx", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.SfxVolume = q.val / 100
		q.val = global.SfxVolume * 100
	}, global.SfxVolume * 100, 100)

	add_option_ext(AUDIO, option.multi, "option_audio_unfocus", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.unfocus_mute = q.val
		q.val = global.unfocus_mute
}, global.unfocus_mute, 1)


#endregion

#region Video

	var VIDEO = create_menu(option.video, option.left, 40, function()
	{
		goto_menu(option.main)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("Visual", "showHud", global.option_hud)
		ini_write_real("General", "Vsync", global.vsync)
		ini_write_real("General", "Windowsize", global.windowSize)
		ini_write_real("General", "texFilter", global.texFilter)
		
		ini_close()
	})

	add_option_press(VIDEO, "option_back", function()
	{
		goto_menu(option.main)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("Visual", "showHud", global.option_hud)
		ini_write_real("General", "Vsync", global.vsync)
		ini_write_real("General", "Windowsize", global.windowSize)
		ini_write_real("General", "texFilter", global.texFilter)
		
		ini_close()
	})

	add_option_press(VIDEO, "option_video_window_mode", function()
	{
		goto_menu(option.videoWindowMode)
	})

	add_option_ext(VIDEO, option.multi, "option_video_resolution", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		var res = [[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]]
		window_set_size(res[q.val][0], res[q.val][1])
		window_center()
		global.windowSize = q.val
		q.val = global.windowSize
	}, global.windowSize, 5, ["480 X 270", "960 X 540", "1024 X 576", "1280 X 720", "1600 X 900", "1920 X 1080"])
	
	add_option_ext(VIDEO, option.multi, "option_video_vsync", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.vsync = q.val
		display_reset(0, global.vsync)
		q.val = global.vsync
	}, global.vsync, 1)
	add_option_ext(VIDEO, option.multi, "option_video_filtering", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.texFilter = q.val
		gpu_set_texfilter(global.texFilter);
		q.val = global.texFilter
	}, global.texFilter, 1)

	add_option_ext(VIDEO, option.multi, "option_video_hide_hud", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.option_hud = q.val
		q.val = global.option_hud
	}, global.option_hud, 1)

	add_option_ext(VIDEO, option.multi, "option_video_screen_effects", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.option_screen_effects = q.val
		q.val = global.option_screen_effects
	}, global.option_screen_effects, 1)

#endregion

#region Game

	var GAME = create_menu(option.game, option.left, 40, function()
	{
		goto_menu(option.main)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("General", "speedrunTimer", global.option_speedrun_timer)
		ini_write_real("General", "timerType", global.option_timer_type)
		ini_write_real("General", "timer", global.option_timer)
		ini_write_real("General", "screenshake", global.option_screenshake)
		ini_write_real("General", "rumble", global.option_rumble)
		
		ini_close()
	})

	add_option_press(GAME, "option_back", function()
	{
		goto_menu(option.main)
		
		ini_open(working_directory + "options.ini")
		
		ini_write_real("General", "speedrunTimer", global.option_speedrun_timer)
		ini_write_real("General", "timerType", global.option_timer_type)
		ini_write_real("General", "timer", global.option_timer)
		ini_write_real("General", "screenshake", global.option_screenshake)
		ini_write_real("General", "rumble", global.option_rumble)
		
		ini_close()
		
	})

	add_option_ext(GAME, option.multi, "option_rumble", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.option_rumble = q.val
		q.val = global.option_rumble
	}, global.option_rumble, 1)

	add_option_ext(GAME, option.multi, "option_screen_shake", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.option_screenshake = q.val
		q.val = global.option_screenshake
	}, global.option_screenshake, 1)

	add_option_ext(GAME, option.multi, "option_timer", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.option_timer = q.val
		q.val = global.option_timer
	}, global.option_timer, 1)

	add_option_ext(GAME, option.multi, "option_timer_type", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.option_timer_type = q.val
		q.val = global.option_timer_type
	}, global.option_timer_type, 2, [lang_get_phrase("option_timer_type_per_save"), lang_get_phrase("option_timer_type_per_level"), lang_get_phrase("option_timer_type_both")])

	add_option_ext(GAME, option.multi, "option_speedrun_timer", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.option_speedrun_timer = q.val
		q.val = global.option_speedrun_timer
	}, global.option_speedrun_timer, 1)


#endregion

var controlsMain = create_menu(option.controlsMain, option.left, 40, function()
	{
		goto_menu(option.main)
	})

	add_option_press(controlsMain, "option_back", function()
	{
		goto_menu(option.main)
	})
	add_option_press(controlsMain, "option_controls_keyboard", function()
	{
		goto_menu(option.controlsKeyMain)
	})
	add_option_press(controlsMain, "option_controls_controller", function()
	{
		goto_menu(option.controlsPadMain)
	})
	add_option_press(controlsMain, "option_controls_reset_config", function()
	{
		input_start(true)
		var _s = scr_transfotip(lang_get_phrase("option_controls_config_reset_tip"))
		_s.depth = depth - 1
	})

var controlsKeyMain = create_menu(option.controlsKeyMain, option.left, 40, function()
	{
		goto_menu(option.controlsMain)
		
		ini_open(working_directory + "options.ini")
		
		ini_write_real("General", "dirSuper", global.dirSuper)
		ini_write_real("General", "dirGround", global.dirGround)
		
		ini_close()
	})

	add_option_press(controlsKeyMain, "option_back", function()
	{
		goto_menu(option.controlsMain)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("General", "dirSuper", global.dirSuper)
		ini_write_real("General", "dirGround", global.dirGround)
		
		ini_close()
	})
	add_option_press(controlsKeyMain, "option_controls_bindings", function()
	{
		goto_menu(option.controlsKey)
	})
	add_option_ext(controlsKeyMain, option.multi, "option_controls_controller_dir_superjump", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.dirSuper = q.val
		q.val = global.dirSuper
	}, global.dirSuper, 1)
	add_option_ext(controlsKeyMain, option.multi, "option_controls_controller_dir_groundpound", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.dirGround = q.val
		q.val = global.dirGround
	}, global.dirGround, 1)

var controlsPadMain = create_menu(option.controlsPadMain, option.left, 40, function()
	{
		goto_menu(option.controlsMain)
	})

	add_option_press(controlsPadMain, "option_back", function()
	{
		goto_menu(option.controlsMain)
	})
	add_option_press(controlsPadMain, "option_controls_bindings", function()
	{
		goto_menu(option.controlsPad)
	})
	add_option_press(controlsPadMain, "option_controls_deadzones", function()
	{
		goto_menu(option.controlsPadDeadzones)
	})

var controlsKey = create_menu(option.controlsKey, option.keys, 48, function()
	{
		var q = json_stringify(global.key_map, true)
		var _file = file_text_open_write(working_directory + "input.dat");
		file_text_write_string(_file, q);
		file_text_close(_file);
		var p = loadString(working_directory + "input.dat")
		goto_menu(option.controlsKeyMain)
	})

	add_option_press(controlsKey, "option_back", function()
	{
		goto_menu(option.controlsKeyMain)
		var q = json_stringify(global.key_map, true)
		var _file = file_text_open_write(working_directory + "input.dat");
		file_text_write_string(_file, q);
		file_text_close(_file);
		var p = loadString(working_directory + "input.dat")
		var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"))
		_s.depth = depth - 1
	})
	add_option_key(controlsKey, 0, function(){
		}, "up_key")
	add_option_key(controlsKey, 1, function(){
		}, "down_key")
	add_option_key(controlsKey, 3, function(){
		}, "left_key")
	add_option_key(controlsKey, 2, function(){
		}, "right_key")
	add_option_key(controlsKey, 4, function(){
		}, "jump_key")
	add_option_key(controlsKey, 5, function(){
		}, "grab_key")
	add_option_key(controlsKey, 6, function(){
		}, "attack_key")
	add_option_key(controlsKey, 7, function(){
		}, "taunt_key")
	add_option_key(controlsKey, 8, function(){
		}, "start_key")
	add_option_key(controlsKey, 9, function(){
		}, "superjump_key")
	add_option_key(controlsKey, 10, function(){
		}, "groundpound_key")
	add_option_key(controlsKey, "MENU LEFT", function(){
		}, "menu_left_key")
	add_option_key(controlsKey, "MENU RIGHT", function(){
		}, "menu_right_key")
	add_option_key(controlsKey, "MENU UP", function(){
		}, "menu_up_key")
	add_option_key(controlsKey, "MENU DOWN", function(){
		}, "menu_down_key")
	add_option_key(controlsKey, "MENU CONFIRM", function(){
		}, "menu_confirm_key")
	add_option_key(controlsKey, "MENU BACK", function(){
		}, "menu_back_key")
	add_option_key(controlsKey, "MENU CLEAR", function(){
		}, "menu_clear_key")


var controlsPad = create_menu(option.controlsPad, option.keys, 48, function()
	{
		var q = json_stringify(global.key_map, true)
		var _file = file_text_open_write(working_directory + "input.dat");
		file_text_write_string(_file, q);
		file_text_close(_file);
		var p = loadString(working_directory + "input.dat")
		goto_menu(option.controlsPadMain)
	})

	add_option_press(controlsPad, "option_back", function()
	{
		goto_menu(option.controlsPadMain)
		var q = json_stringify(global.key_map, true)
		var _file = file_text_open_write(working_directory + "input.dat");
		file_text_write_string(_file, q);
		file_text_close(_file);
		var p = loadString(working_directory + "input.dat")
		var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"))
		_s.depth = depth - 1
	})
	add_option_key(controlsPad, 0, function(){
		}, "up_pad")
	add_option_key(controlsPad, 1, function(){
		}, "down_pad")
	add_option_key(controlsPad, 3, function(){
		}, "left_pad")
	add_option_key(controlsPad, 2, function(){
		}, "right_pad")
	add_option_key(controlsPad, 4, function(){
		}, "jump_pad")
	add_option_key(controlsPad, 5, function(){
		}, "grab_pad")
	add_option_key(controlsPad, 6, function(){
		}, "attack_pad")
	add_option_key(controlsPad, 7, function(){
		}, "taunt_pad")
	add_option_key(controlsPad, 8, function(){
		}, "start_pad")
	add_option_key(controlsPad, 9, function(){
		}, "superjump_pad")
	add_option_key(controlsPad, 10, function(){
		}, "groundpound_pad")
	add_option_key(controlsPad, "MENU LEFT", function(){
		}, "menu_left_pad")
	add_option_key(controlsPad, "MENU RIGHT", function(){
		}, "menu_right_pad")
	add_option_key(controlsPad, "MENU UP", function(){
		}, "menu_up_pad")
	add_option_key(controlsPad, "MENU DOWN", function(){
		}, "menu_down_pad")
	add_option_key(controlsPad, "MENU CONFIRM", function(){
		}, "menu_confirm_pad")
	add_option_key(controlsPad, "MENU BACK", function(){
		}, "menu_back_pad")
	add_option_key(controlsPad, "MENU CLEAR", function(){
		}, "menu_clear_pad")

var DEADZONES = create_menu(option.controlsPadDeadzones, option.left, 40, function()
	{
		goto_menu(option.controlsPadMain)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("Deadzones", "horiz", global.gamepad_deadzones.horizontal)
		ini_write_real("Deadzones", "verti", global.gamepad_deadzones.vertical)
		ini_write_real("Deadzones", "press", global.gamepad_deadzones.press)
		
		ini_close()
	})

	add_option_press(DEADZONES, "option_back", function()
	{
		goto_menu(option.controlsPadMain)
		ini_open(working_directory + "options.ini")
		
		ini_write_real("Deadzones", "horiz", global.gamepad_deadzones.horizontal)
		ini_write_real("Deadzones", "verti", global.gamepad_deadzones.vertical)
		ini_write_real("Deadzones", "press", global.gamepad_deadzones.press)
		
		ini_close()
	})

	add_option_ext(DEADZONES, option.slider, "option_controls_controller_deadzone_horiz", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.gamepad_deadzones.horizontal = q.val / 100
		q.val = global.gamepad_deadzones.horizontal * 100
	}, global.gamepad_deadzones.horizontal * 100, 100)
	add_option_ext(DEADZONES, option.slider, "option_controls_controller_deadzone_vert", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.gamepad_deadzones.vertical = q.val / 100
		q.val = global.gamepad_deadzones.vertical * 100
	}, global.gamepad_deadzones.vertical * 100, 100)
	add_option_ext(DEADZONES, option.slider, "option_controls_controller_deadzone_press", function()
	{
		var m = menus[currentmenu]
		var opt = m.options
		var q = opt[selected]
		global.gamepad_deadzones.press = q.val / 100
		q.val = global.gamepad_deadzones.press * 100
	}, global.gamepad_deadzones.press * 100, 100)

	var windowMode = create_menu(option.videoWindowMode, option.left, 40, function()
	{
		goto_menu(option.video)
	})

	add_option_press(windowMode, "option_back", function()
	{
		goto_menu(option.video)
		
		ini_open(working_directory + "options.ini")
		ini_write_real("General", "Fullscreen", global.Fullscreen)
		ini_close()
	})
	add_option_press(windowMode, "option_video_window_mode_windowed", function()
	{
		goto_menu(option.video)
		
		window_set_fullscreen(false)
		window_enable_borderless_fullscreen(false);
		
		global.Fullscreen = 0
		var res = [[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]]
		window_set_size(res[global.windowSize][0], res[global.windowSize][1])
		window_center()
		
		ini_open(working_directory + "options.ini")
		ini_write_real("General", "Fullscreen", global.Fullscreen)
		ini_close()
	})
	add_option_press(windowMode, "option_video_window_mode_fullscreen", function()
	{
		goto_menu(option.video)
		
		window_enable_borderless_fullscreen(false);
		window_set_fullscreen(true)
		
		global.Fullscreen = 1
		
		ini_open(working_directory + "options.ini")
		ini_write_real("General", "Fullscreen", global.Fullscreen)
		ini_close()
	})
	add_option_press(windowMode, "option_video_window_mode_borderless", function()
	{
		goto_menu(option.video)
		
		if window_get_fullscreen()
			window_set_fullscreen(false)
		window_enable_borderless_fullscreen(true);
		window_set_fullscreen(true);
		
		global.Fullscreen = 2
		
		ini_open(working_directory + "options.ini")
		ini_write_real("General", "Fullscreen", global.Fullscreen)
		ini_close()
	})

array_push(menus, AUDIO) // 1
array_push(menus, VIDEO) // 2
array_push(menus, GAME) // 3
array_push(menus, controlsMain) // 4
array_push(menus, controlsKeyMain) // 5
array_push(menus, controlsKey) // 6
array_push(menus, controlsPadMain) // 7
array_push(menus, controlsPad) // 8
array_push(menus, DEADZONES) // 9
array_push(menus, windowMode) // 10