if canGive
{
	shake_camera(3, 3)
	with instance_create(x, y, obj_baddiedead)
	{
		sprite_index = spr_pizzacar_debris
	}
	create_particleStatic(spr_genericpoofeffect, x, y, 1, -2)
	create_particleStatic(spr_bangeffect, x, y, 1)
	with other
	{
		movespeed = 5
		sprite_index = spr_player_pizzacar
		image_index = 0
		state = states.skateboard
		FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/ramp", x, y)
		exit;
	}
}