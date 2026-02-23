function scr_player_buzzsaw()
{
	FMODSet3dPos(soundsBuzzsaw, x, y)
	get_input()
	image_speed = 0.7
	hsp = movespeed * xscale
	if movespeed > 14
		movespeed = 14
	var move = key_right + key_left
	buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1)
	if buffers.afterimageBlur == 0
	{
		buffers.afterimageBlur = 3
		create_buzzsawAfterimage(sprite_index, image_index, x, y, xscale)
	}
	if key_down2
	{
		if vsp < 10
			vsp = 10
		sprite_index = spr_player_buzzsawFastFall
	}
	if vsp >= -grav && vsp < 10
		vsp += 0.15
	if !grounded && key_jump2 && key_down
	{
		fmod_studio_event_instance_stop(soundsBuzzsaw, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
		vsp = -6
		sprite_index = sprites.divebomb
		image_index = 0
		state = states.groundpoundstart
		squashX = 1.3
		squashY = 0.8
	}
	if place_meeting(x + sign(hsp), y, obj_solid) && !grounded && !place_meeting(x + sign(hsp), y, obj_metalblock) && !place_meeting(x + sign(hsp), y, obj_secretmetalblock) && !place_meeting(x + hsp, y, obj_destructibles)
	{
		if vsp < 10
			vsp = 10
		movespeed = 9	
		xscale *= -1
		create_particleStatic(spr_buzzsaw_bump, x, y, 1, 1)
		FMODevent_oneshot("event:/Sfx/Player/airbump", x, y)
		image_index = 0
		sprite_index = spr_player_buzzsawBump
	}
	if animation_end() && sprite_index == spr_player_buzzsawBump
		sprite_index = spr_player_buzzsaw
	if grounded
	{
		fmod_studio_event_instance_stop(soundsBuzzsaw, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
		if move != 0
			xscale = move
		
		if movespeed < 12
			movespeed = 12
		flash = true
		state = states.mach3
		sprite_index = spr_player_rollgetup
		image_index = 0
		FMODevent_oneshot("event:/Sfx/Player/sawland", x, y)
	}
	doTaunt()
	if slapBuffer > 8
	{
		fmod_studio_event_instance_stop(soundsBuzzsaw, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
		slapBuffer = false
		if move != 0
			xscale = move
		create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1)
		create_particleStatic(spr_grabcloud, x, y, xscale, 1)
		if movespeed < 13
			movespeed = 13
		state = states.mach3
		jumpstop = true
		vsp = -8
		sprite_index = spr_player_buzzsawCancel
		image_index = 0
		FMODevent_oneshot("event:/Sfx/Player/minijohnpunch", x, y)
		FMODevent_oneshot("event:/Sfx/Player/sawland", x, y)
	}
}