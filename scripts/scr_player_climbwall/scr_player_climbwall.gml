function scr_player_climbwall()
{
	get_input()
	hsp = 0
	image_speed = 0.6
	vsp = -verticalMovespeed
	var move = key_right + key_left
	
	if character != characters.milton
	{
		
			verticalMovespeed = approach(verticalMovespeed, 20, 0.15)
	}
	else
	{
		
		if sprite_index == spr_player_wallclimb
			sprite_index = spr_milton_wallslide
	}
	
	buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1)
	if buffers.afterimageBlur == 0
	{
		buffers.afterimageBlur = 4
		create_blur_effect(sprite_index, image_index, x, y, xscale)
	}
	
	buffers.step--
	if buffers.step <= 0
	{
		buffers.step = 10
		create_particleStatic(spr_cloudeffect, x, y, 1, 1)
	}
	
	if !key_attack && wallgrab <= 0 || (verticalMovespeed <= 0 && character != characters.milton)
	{
		vsp = 0
		state = states.jump
		freefalling = 0
		movespeed = -5
		sprite_index = spr_player_fall
	}
	wallgrab--
	
	if !place_meeting(x + (32 * xscale), y, obj_solid)
	{
		wallgrab = 0
		if character == characters.mildred
		{
			state = states.buzzsaw
			image_index = 0
			sprite_index = spr_player_buzzsawBump
			if verticalMovespeed < 13
				verticalMovespeed = 13
			movespeed = verticalMovespeed
			vsp = -8
			fmod_studio_event_instance_start(soundsBuzzsaw)
			FMODSet3dPos(soundsBuzzsaw, x, y)
		}
		else
		{
			if verticalMovespeed >= 12
			{
				state = states.mach3
				movespeed = verticalMovespeed
				flash = true
				sprite_index = sprites.mach3
				vsp = 0
			}
			else
			{
				state = states.mach2
				movespeed = verticalMovespeed
				sprite_index = spr_player_mach2
				vsp = 0
			}
		}
		var o_y = y
		var rep = 0
		while !place_meeting(x + xscale, y + 1, obj_solid)
		{
			y++
			rep++
			if rep > 32
			{
				y = o_y
				break
			}
		}
	}
	
	if jumpBuffer > 8
	{
		if isMilton
		{
			jumpBuffer = false
			vsp = -16
			xscale *= -1
			movespeed = verticalMovespeed * xscale
			state = states.hammertwirl
			sprite_index = spr_milton_hammertwirl
			image_index = 0
			FMODevent_oneshot("event:/Sfx/Player/jump", x, y)
			exit;	
		}
		
		jumpBuffer = false
		FMODevent_oneshot("event:/Sfx/Player/jump", x, y)
		vsp = -11
		xscale *= -1
		movespeed = 10
		state = states.mach2
		jumpstop = false
		sprite_index = spr_player_walljumpstart
		image_index = 0
	}
	
	if downBuffer > 0 && character == characters.mildred
	{
		downBuffer = 0
		vsp = -6
		sprite_index = spr_player_groundpoundstart
		image_index = 0
		state = states.groundpound
		movespeed = hsp
		freefalling = 0
	}
	
	if (place_meeting(x, y - 1, obj_solid) || (place_meeting(x, y - 1, obj_platform) && sign(instance_place(x, y - 1, obj_platform).image_yscale) < 0)) && !place_meeting(x, y - 1, obj_destructibles)
	{
		shake_camera(10, 30)
		sprite_index = spr_player_hitceiling
		image_index = 0
		state = states.freefallland
		FMODevent_oneshot("event:/Sfx/Player/slam", x, y)
	}
}