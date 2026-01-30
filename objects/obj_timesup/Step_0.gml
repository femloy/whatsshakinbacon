with obj_player
{
	if sprite_index == sprites.gateslam
	{
		hsp = 0
		vsp = 0
		
		if animation_end()
			image_index = image_number - 1
			
		if place_meeting(x, y, obj_timesup)
		{
			hsp = 4
			vsp = -10
			sprite_index = spr_player_gameover
		}
	}
	if sprite_index == spr_player_gameover
	{
		
	}
}

if falling
{
	y = approach(y, SCREEN_HEIGHT / 2, vsp)
	vsp += 1
}