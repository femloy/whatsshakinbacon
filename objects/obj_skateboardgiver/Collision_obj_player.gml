if canGive
{
	with other
	{
		vsp = -12
		movespeed = 12
		sprite_index = spr_player_skate_rampjump
		image_index = 0
		state = states.skateboardramp
		FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/ramp", x, y)
		exit;
	}
}