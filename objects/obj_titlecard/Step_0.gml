if isMilton
	titlecardMiltonIndex = approach(titlecardMiltonIndex, sprite_get_number(titlecardMilton) - 1, 0.4)
if scene == 0 || scene == 1
{
	if fadeIn = true
	{
		fadeAlpha = approach(fadeAlpha, 1, 0.05)
		if fadeAlpha == 1
		{
			FMODevent_oneshot(jingle)
			fadeIn = false
			scene = 1
			alarm[1] = 60 * 3.5
		}
	}
	else if fadeIn == false
	{
		fadeAlpha = approach(fadeAlpha, 0, 0.1)
	}
	
	if titlecardName.fadeIn == false
	{
		titlecardName.alpha = approach(titlecardName.alpha, 1, 0.1)
	}
}
if scene == 2
{
	circleSize = approach(circleSize, 0, circleSizeSpeed)
	circleSizeSpeed += 1
	if circleSize == 0
	{
		if !instance_exists(obj_loadingMini)
		{
			unload_textures(global.level_loaded_pages)
			load_textures([group])
		}
		else {
			scene = 3
			alarm[2] = 45
		}
	}
}
if scene == 4
{
	circleSize = approach(circleSize, SCREEN_WIDTH, circleSizeSpeed)
	circleSizeSpeed += 1
	if circleSize == SCREEN_WIDTH
	{
		scene = 5
		alarm[3] = 25
	}
	
}
if scene == 6
{
	ratingAlpha = approach(ratingAlpha, 1, 0.1)
	if ratingAlpha == 1 && alarm[3] <= 0
	{
		alarm[3] = 60 * 3
	}
}
if scene == 7
{
	ratingAlpha = approach(ratingAlpha, 0, 0.01)
	if ratingAlpha == 0
	{
		instance_destroy()
	}
}