if active == false
{
	sprite_index = asset_get_index($"spr_lover{lover}_idle")
	
	if place_meeting(x, y, obj_player)
	{
		image_index = 0
		sprite_index = asset_get_index($"spr_lover{lover}_shoot")
		ds_list_add(global.saveroom, id)
		FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y)
		var _proj = instance_create(x + irandom_range(-50, 50), y + irandom_range(-50, 50), obj_loverproj)
		with _proj 
		{
			sprite_index = asset_get_index($"spr_lover{other.lover}_proj")
		}
		show_debug_message("disgusting little thing created")
		alarm[0] = 100
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
						global.textSize = 0.5
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
	{
		
		if animation_end()
			image_index = image_number - 1
		if fly
		{
			vspeed = approach(vspeed, -14, 0.1)
			hspeed = approach(hspeed, -4, 0.1)
		}
		else
		{
			hspeed = approach(hspeed, 0, 0.5)
			x = lerp(x, obj_player.x - 100, 0.1)
			y = lerp(y, obj_player.y - 100, 0.15)
		}
	}
}