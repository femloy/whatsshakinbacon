function scr_player_taunt()
{
	hsp = 0
	vsp = 0
	get_input()
	if sprite_index == sprites.taunt
	{
		image_speed = 0
		tauntTimer--
		if tauntTimer <= 0
		{
			state = tauntVars.state
			sprite_index = tauntVars.sprite_index
			image_index = tauntVars.image_index
			vsp = tauntVars.vsp
			hsp = tauntVars.hsp
			movespeed = tauntVars.movespeed
			image_speed = tauntVars.image_speed
		}
		var _isSupertaunt = canSupertaunt && key_up_pressed
		if _isSupertaunt
		{
			state = states.taunt
			image_speed = 0.35
			sprite_index = choose(spr_player_supertaunt1, spr_player_supertaunt2, spr_player_supertaunt3, spr_player_supertaunt4)
			image_index = 0
			FMODevent_oneshot("event:/Sfx/Player/supertaunt", x, y)
			supertaunt = 0
			canSupertaunt = false
			var _speed = [[-20, 0], [-20, -20], [0, -20], [20, -20], [20, 0], [20, 20], [0, 20], [-20, 20]]
			var i = 0
			repeat(array_length(_speed))
			{
				with instance_create(x, y, obj_tauntafterimage)
				{
					hspeed = _speed[i][0]
					vspeed = _speed[i][1]
				}
				i++
			}
			with obj_baddie
			{
				if in_camera()
				{
					supertauntKill = true
					instance_destroy()
				}
			}
		}
	}
	else {
		image_speed = 0.35
		if animation_end()
		{
			state = tauntVars.state
			sprite_index = tauntVars.sprite_index
			image_index = tauntVars.image_index
			vsp = tauntVars.vsp
			hsp = tauntVars.hsp
			movespeed = tauntVars.movespeed
			image_speed = tauntVars.image_speed
		}
	}
}