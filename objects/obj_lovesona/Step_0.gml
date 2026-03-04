if active == false
{
	sprite_index = asset_get_index($"spr_lover{lover}_idle")
	
	if place_meeting(x, y, obj_player)
	{
		create_ghost_self_visual()
		create_ghost_self_visual(spr_lover_platform)
		image_index = 0
		sprite_index = asset_get_index($"spr_lover{lover}_shoot")
		ds_list_add(global.saveroom, id)
		FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y)
		alarm[1] = 15
		active = true
		with obj_player
		{
			flash = true
			repeat(3)
				instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_notes).sprite_index = spr_heart_part
			switch room
			{
				case mangrove_secret1:
					var _dialog = instance_create(x, y - 32, obj_smallDialog)
					with _dialog
					{
						target = obj_player
						addDialog(dialogChars.mildred, "The worst she can say is no.. right?")
						draw_set_font(global.npcfont)
						draw_set_halign(fa_center)
						global.textSize = 0.8
						draw_text_oyh(x, y, dialogStuff[currentDialog].text, 800)
						global.textSize = 1
						var _stringArr = ds_map_find_value(global.textCache, dialogStuff[currentDialog].text)[0]
						var _stringArrLength = array_length(_stringArr)
						textLength = _stringArrLength
						textLetter = 0
						active = true
						alarm[0] = 45
					}
					break
			}
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
		interp = approach(interp, 0.1, 0.1 / 39)
	}
}