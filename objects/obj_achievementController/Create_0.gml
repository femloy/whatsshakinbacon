enum achievements
{
	waybackFodder,
	waybackTourist
}

waybackyard = {
	fodder: 32
}

achievementBuffer = []
canExecute = true

reset_level_stats = function()
{
	waybackyard = {
		fodder: 32
	}
}

global.achievements = ds_map_create()

add_achievement = function(_achievement, _name, _description, _sprite, _index, _savePath)
{ 
	var q =
	{
		name: _name,
		description: _description,
		achievementSprite: _sprite,
		achievementIndex: _index,
		savePath: _savePath,
	}
	ds_map_add(global.achievements, _achievement, q)
}


add_achievement(achievements.waybackFodder, "Community Service", "Clean up all the garbage in Waybackyard", spr_achievement_wayback, 0, "waybackFodder")
add_achievement(achievements.waybackTourist, "Extreme Tourism", "Reach the temple in under 1:15 in Waybackyard", spr_achievement_wayback, 2, "waybackTourist")