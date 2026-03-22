
if place_meeting(x, y, obj_player) && cutscene == false
{
	FMODevent_oneshot("event:/Sfx/General/Enemy/balloonsplat", x, y)
	instance_create(x, y, obj_sloshersplat).blend = #ffcccc
	ds_list_add(global.saveroom, id)
	cutscene = true
	with obj_player
	{
		FMODevent_oneshot("event:/Sfx/General/Level/Progression/enterpage", x, y)
		targetRoom = other.targetRoom
		door = "DOODLE"
		state = -4
		sprite_index = spr_player_hurt
		image_speed = 0.35
	}
	sprite_index = spr_loveportal_close
	image_index = 0
}
visible = !place_meeting(x, y, obj_secretmetalblock) && !place_meeting(x, y, obj_destroyable_secret1) && !place_meeting(x, y, obj_destroyable_secret2)
if !visible
{
	sprite_index = spr_loveportal_open
	image_index = 0
}
if animation_end() && sprite_index == spr_loveportal_open 
{
	sprite_index = spr_loveportal_idle
	image_index = 0
}
if cutscene = true
{
	with obj_player
	{
		vsp = 0
		hsp = 0
		x = other.x
		y = other.y
		xscaleMulti = approach(xscaleMulti, 0, 0.05)
		yscaleMulti = approach(yscaleMulti, 0, 0.05)
		movespeed = 0
	}
	if animation_end() && sprite_index == spr_loveportal_close
	{
		image_alpha = 0
		if !instance_exists(obj_secret_transition)
			instance_create(x, y, obj_secret_transition)
	}
	
}