function scr_player_uppercut(){
	get_input()
	var move = key_right + key_left
	hsp = approach(hsp, movespeed * move, 0.4)
	if sprite_index != spr_player_mach_uppercut
	{
		if move != 0
		{
			if abs(hsp) < 4
				movespeed = 4
		}
	}
	image_speed = 0.4
	if vsp < 0
	{
		buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1)
		if buffers.afterimageMach == 0
		{
			buffers.afterimageMach = 4
			if sprite_index == spr_player_mach_uppercut
				create_buzzsawAfterimage(sprite_index, image_index, x, y, xscale)
			else
				create_machEffect(sprite_index, image_index, x, y, xscale, 1)
		}
	}
	
	if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destructibles) && sprite_index == spr_player_mach_uppercut
	{
		FMODevent_oneshot("event:/Sfx/Player/bump", x, y)
		state = states.hitwall
		sprite_index = spr_player_wallsplat
		image_index = 0
		exit
	}
	
	if buffers.step <= 0
	{
		buffers.step = 5
		create_particleStatic(spr_shineeffect, x, y, 1, 1)
	}
	buffers.step--
	if animation_end()
		image_index = image_number - 1
	if grounded && vsp > 0
	{
		create_particleStatic(spr_landeffect, x, y, 1, 1)
		image_index = 0
		sprite_index = move != 0 ? spr_player_land2 : spr_player_land
		state = states.normal
		FMODevent_oneshot("event:/Sfx/Player/step", x, y)
		movespeed = abs(hsp)
		if move != 0
			xscale = move
		hsp = movespeed * xscale
	}
}