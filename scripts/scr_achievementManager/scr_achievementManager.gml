function push_achievement(_achievement)
{
	show_debug_message($"pushed {_achievement}")
	with obj_achievementController
	{
		switch _achievement
		{
			case achievements.waybackFodder:
				waybackyard.fodder--
				break
			case achievements.waybackTourist:
				if global.level_timer < 60 + 15
					unlock_achievemnt(_achievement)
				break
		}
	}
}

function unlock_achievemnt(_achievement)
{
	var q = ds_map_find_value(global.achievements, _achievement)
	
	var _unlocked = false
	ini_open(global.saveFile)
	_unlocked = ini_read_real("Achievements", q.name, false)
	ini_close()
	if !instance_exists(obj_achievementController)
		instance_create(x, y, obj_achievementController)
	if !_unlocked
	{
		array_push(obj_achievementController.achievementBuffer, [_achievement, function(_achievement)
		{
			var q = ds_map_find_value(global.achievements, _achievement)
			ini_open(global.saveFile)
			ini_write_real("Achievements", q.name, true)
			ini_close()
			repeat (10)
			{
				instance_create(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 50, obj_confettieffect_gui)
			}
			with instance_create(SCREEN_WIDTH - 120, SCREEN_HEIGHT + 200, obj_feat)
			{
				achievementSpr = q.achievementSprite
				achievementIndex = q.achievementIndex
			}
		}])
	}
}

function unlock_palette(_saveName, _index = 0, _pattern = spr_playerPat_threads)
{
	var _unlocked = false
	ini_open(global.saveFile)
	_unlocked = ini_read_real("Palette", _saveName, false)
	ini_close()
	if !instance_exists(obj_achievementController)
		instance_create(x, y, obj_achievementController)
	if !_unlocked
	{
		array_push(obj_achievementController.achievementBuffer, [[_saveName, _pattern, _index], function(_palStuff)
		{
			ini_open(global.saveFile)
			ini_write_real("Palette", _palStuff[0], true)
			ini_close()
			repeat (10)
			{
				instance_create(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 50, obj_confettieffect_gui)
			}
			with instance_create(SCREEN_WIDTH - 120, SCREEN_HEIGHT + 200, obj_palette_unlock)
			{
				spr_palette = spr_playerPal
				patColors = spr_playerPatColors
				spr_pattern = _palStuff[1]
				paletteIndex = _palStuff[2]
			}
		}])
	}
}