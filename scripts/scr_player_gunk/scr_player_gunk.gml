function scr_player_gunk()
{
	get_input()
	hsp = movespeed * xscale
	var move = key_left + key_right
	var moveV = key_down_pressed - key_up_pressed
	if jumpstop == false && !key_jump && vsp < 0.5
	{
		jumpstop = true
		vsp /= 10
	}
	var _accel = 0.5
	if move != 0
	{
		movespeed = approach(movespeed, 6, _accel)
		xscale = move
	}
	else {
		movespeed = 0
	}
	
	if jumpBuffer && coyote_time && grounded
	{
		jumpBuffer = false
		create_particleStatic(spr_jumpeffect, x, y, 1, 1)
		vsp = -11
		jumpstop = false
	}
	if key_grab_pressed
	{
		movespeed = 8
		state = states.gunkMove
		sprite_index = spr_player_grab
		image_index = 0
	}
}

function scr_player_gunkMove()
{
	get_input()
	hsp = movespeed * xscale
	var move = key_left + key_right
	if move != 0
	{
		movespeed = approach(movespeed, 12, 0.5)
	}
	else {
	}
	if animation_end()
	{
		sprite_index = spr_slosher
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
		sprite_index = spr_slosher
		state = states.gunk
		vsp = -12
		jumpstop = true
		movespeed = 0
		verticalMovespeed = 0
	}
}