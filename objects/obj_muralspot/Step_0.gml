if active
	image_blend = c_white
else {
	image_blend = c_dkgray
}

if place_meeting(x, y, obj_player)
	{
		if obj_player.state == states.gunkMove
		{
			if !active
			{
				active = true
				FMODevent_oneshot("event:/Sfx/General/Shell City/spray", x, y)
				create_particleStatic(spr_sprayeffect, x, y, 1, -100)
				ds_list_add(global.saveroom, id)
			}
			with obj_player
			{
				movespeed = 0
				vsp = -16
				jumpstop = true
				state = states.gunk
				sprite_index = spr_slosher
			}
		}
	}