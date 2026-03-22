function scr_enemy_move()
{
	image_speed = 0.35
	hsp = movespeed * xscale
	movespeed = 1
	if buffers.step <= 0
	{
		buffers.step = 45
		create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1)
	}
	buffers.step--
	sprite_index = spr_move
	if place_meeting(x + xscale, y, obj_solid) ||
	place_meeting(x + xscale, y, obj_hallway) ||
	!(place_meeting(x + xscale * 18, y + 31, obj_solid) ||
	place_meeting(x + xscale * 18, y + 31, obj_slope) ||
	place_meeting(x + xscale * 18, y + 31, obj_platform)) &&
	grounded
	{
		switch object_index
		{
			case obj_cocoant:
				xscale *= -1
				image_index = 0
			break
			case obj_dougknight:
			case obj_slosher:
				image_speed = 0.35
				state = states.turn
				sprite_index = spr_turn
				image_index = 0
			break
		}
	}
	if point_distance(x, 0, obj_player.x, 0) <= 32 * 10 && 
	point_distance(0, y, 0, obj_player.y) <= 32 * 5 && 
		(obj_player.state == states.mach3 || obj_player.state == states.buzzsaw || (obj_player.state == states.hammerattack && obj_player.movespeed >= 16))
		{
			if collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true) != -4
				exit;
			vsp = -5
			if obj_player.x != x
				xscale = sign(obj_player.x - x)
			sprite_index = spr_scared
			scared = 120
			state = states.stun
			if chance(1 / 100)
				FMODevent_oneshot("event:/Sfx/General/Enemy/scream", x, y)
		}
}