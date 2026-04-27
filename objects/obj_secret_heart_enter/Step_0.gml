if animation_end() && sprite_index == spr_loveportal_close_broken
	{
		instance_destroy()
	}
if cutscene = true
{
	with obj_player
	{
		x = other.x
		y = other.y
		vsp = 0
		hsp = 0
		if other.sprite_index == spr_loveportal_idle_broken
		{
			xscaleMulti = approach(xscaleMulti, 1, 0.05)
			yscaleMulti = approach(yscaleMulti, 1, 0.05)
		}
		if xscaleMulti == 1 && yscaleMulti == 1
		{
			other.cutscene = false
			other.sprite_index = spr_loveportal_close_broken
			other.image_index = 0
			jumpstop = true
			vsp = 10
			state = states.groundpound
			movespeed = hsp
			sprite_index = spr_player_groundpound
			xscaleMulti = 1
			yscaleMulti = 1
			roomstartX = x 
			roomstartY = y
		}
	}
	if animation_end() && sprite_index == spr_loveportal_open_broken
	{
		sprite_index = spr_loveportal_idle_broken
		alarm[0] = 120
		image_index = 0
		FMODevent_oneshot("event:/Sfx/General/Enemy/balloonsplat", x, y)
		instance_create(x, y, obj_sloshersplat).blend = #b4bcc0
	}
	
}