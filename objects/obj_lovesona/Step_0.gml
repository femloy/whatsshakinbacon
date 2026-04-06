if active == false
{
	sprite_index = asset_get_index($"spr_lover{lover}_idle")
	
	if place_meeting(x, y, obj_player)
	{
		create_ghost_self_visual()
		create_ghost_self_visual(spr_lover_platform)
		create_smalltext(points, x, y)
		image_index = 0
		sprite_index = asset_get_index($"spr_lover{lover}_shoot")
		FMODevent_oneshot("event:/Sfx/General/Level/Doodles/iloveyou", x, y)
		alarm[1] = 50
		active = true
		global.combo.timer = 60
		with obj_player
		{
			flash = true
			repeat(8)
				instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_notes).sprite_index = spr_heart_part
		}
	}
}
else
{
	if sprite_index == asset_get_index($"spr_lover{lover}_shoot")
		if animation_end()
			image_index = image_number - 1
	if fly 
	{
		vspeed = approach(vspeed, -14, 1)
		hspeed = approach(hspeed, -4, 1)
	}
	else 
	{
		hspeed = approach(hspeed, 0, 0.5)
		x = lerp(x, obj_player.x - 100, interp)
		y = lerp(y, obj_player.y - 100, interp)
		interp = approach(interp, 0.15, 0.15 / 39)
	}
}