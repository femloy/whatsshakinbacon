
if hitstun.is == false
{
	event_inherited();
	switch state
	{
		case states.stun:
			scr_enemy_stun()
			break
		case states.hit:
			scr_enemy_hit()
			break
		case states.turn:
			scr_enemy_turn()
			break
		case states.move:
			scr_enemy_move()
			attackTimer--
			break
		case states.grab:
			scr_enemy_grabbed()
		break
		case states.thrown:
			scr_enemy_thrown()
		break 
		case states.uppercut:
			image_speed = 0.35
			if animation_end() && sprite_index == spr_cocoant_shootprep
			{
				if obj_player.x != x
					xscale = sign(obj_player.x - x)
				sprite_index = spr_cocoant_shoot
				image_index = 0
				vsp = -4
				hsp = -4 * xscale
				with instance_create(x, y, obj_dart)
				{
					image_xscale = other.xscale
				}
				FMODevent_oneshot("event:/Sfx/General/Enemy/Ant/dart", x, y)
			}
			if animation_end() && sprite_index == spr_cocoant_shoot
			{
				image_index = 0
				sprite_index = spr_move
				state = states.move
			}
			movespeed = 0
		
		break
	}
	if attackTimer <= 0 && point_distance(x, 0, obj_player.x, 0) <= 32 * 10 && point_distance(0, y, 0, obj_player.y) <= 42 && state == states.move
	{
		attackTimer = 60 * 2
		state = states.uppercut
		sprite_index = spr_cocoant_shootprep
		image_index = 0
		if obj_player.x != x
			xscale = sign(obj_player.x - x)
	}
}
else {
	if hitstun.time >= 0
	{
		image_speed = 0
		x = hitstun.x + irandom_range(-5, 5)
		y = hitstun.y + irandom_range(-5, 5)
		hitstun.time--
	}
	else {
		x = hitstun.x
		y = hitstun.y
		hitstun.is = false
	}
}