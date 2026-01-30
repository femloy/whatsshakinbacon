with obj_player 
{
	state = states.parry
	sprite_index = choose(spr_player_parry1, spr_player_parry2)
	create_particleStatic(spr_parryeffect, x, y, 1)
	FMODevent_oneshot("event:/Sfx/Player/parry", x, y)
	image_index = 0
	movespeed = -8
	flash = true
}
	