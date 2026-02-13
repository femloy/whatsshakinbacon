function scr_player_gunk()
{
	get_input()
	hsp = 0
	vsp = 0
	var move = key_left2 + key_right2
	var moveV = key_down2 - key_up2
	if move != 0
	{
		state = states.gunkMove
		xscale = move
		movespeed = 16
		verticalMovespeed = 0
		gunkHard = 0
		create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1).image_speed = 0.5
		exit;
	}
	else if moveV != 0
	{
		state = states.gunkMove
		movespeed = 0
		verticalMovespeed = 16 * moveV
		gunkHard = 0
		if moveV < 0
		{
			with create_particleStatic(spr_crazyrunothereffect, x, y, 1, 1)
			{
				image_angle = 90 
				image_speed = 0.5
			}
		}
		else {
			with create_particleStatic(spr_crazyrunothereffect, x, y, 1, 1)
			{
				image_angle = -90 
				image_speed = 0.5
			}
		}
		exit;
	}
}

function scr_player_gunkMove()
{
	gunkHard += 5
	if gunkHard >= 60
	{
		if !instance_exists(chargeeffect)
			chargeeffect = instance_create(x, y, obj_chargeeffect)
	}
	get_input()
	hsp = movespeed * xscale
	vsp = verticalMovespeed
	buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1)
	if buffers.afterimageBlur == 0
	{
		buffers.afterimageBlur = 3
		create_blur_effect(sprite_index, image_index, x, y, xscale)
	}
	buffers.step--
	if buffers.step <= 0
	{
		buffers.step = 5
		create_particleStatic(spr_cloudeffect, x + irandom_range(42, -42), y + irandom_range(42, -42), 1, 1)
	}
	
	if scr_solid(x + hsp, y + vsp) && 
		!place_meeting(x + hsp, y + vsp, obj_stupidcabbit) && 
	!place_meeting(x + hsp, y + vsp, obj_secretmetalblock) && 
	!place_meeting(x + hsp, y + vsp, obj_metalblock) && 
	!place_meeting(x + hsp, y + vsp, obj_destructibles)
	{
		state = states.gunk
	}
}

function scr_player_gunkIntro()
{
	hsp = 0
	vsp = 0
	image_speed = 0.35
	if animation_end()
	{
		sprite_index = spr_player_skate_idle
		state = states.gunk
		movespeed = 0
		verticalMovespeed = 0
	}
}