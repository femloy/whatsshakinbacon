if active == false
{
	sprite_index = asset_get_index($"spr_lover{lover}_idle")
	
	if place_meeting(x, y, obj_player)
	{
		image_index = 0
		sprite_index = asset_get_index($"spr_lover{lover}_shoot")
		active = true
		ds_list_add(global.saveroom, id)
		FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y)
	}
	
	/*
	if place_meeting(x, y, obj_player)
	{
		global.secretCount++
		ds_list_add(global.saveroom, id)
		active = true
		sprite_index = asset_get_index($"spr_lover{lover}_trans")
		alarm[0] = 1
		create_smalltext(100)
		ds_list_add(global.saveroom, id)
		FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y)
		FMODevent_oneshot("event:/Sfx/General/Level/Doodles/iloveyou", x, y)
		tv_anim(spr_tv_happy, 60 * 3)
		with obj_player 
		{
			if irandom(100) <= 25
				fmod_studio_event_instance_start(soundsLaugh)
		}
		scr_transfotip(lang_get_phrase("secret_get"))
	}
	*/
}
else
{
	if sprite_index == asset_get_index($"spr_lover{lover}_shoot")
	{
		if !fly
		{
			var _proj = instance_create(x + irandom_range(-50, 50), y + irandom_range(-50, 50), obj_loverproj)
			with _proj
			{
				sprite_index = asset_get_index($"spr_lover{other.lover}_proj")
			}
			show_debug_message("disgusting little thing created")
			
			fly = true
		}
		
		if animation_end()
			image_index = image_number - 1
			
		if fly
		{
			vspeed = approach(vspeed, -14, 0.1)
			hspeed = approach(hspeed, -4, 0.1)
		}
		else
			hspeed = approach(hspeed, 0, 0.5)
	}
}