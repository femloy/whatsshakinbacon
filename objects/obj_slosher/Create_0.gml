// Inherit the parent event
event_inherited();
spr_move = spr_slosher
spr_turn = spr_slosher_turn
spr_stun = spr_slosher_stun
spr_scared = spr_slosher_scared
spr_dead = spr_slosher_dead
if plosher != true
	plosher = chance(1 / (global.fun / 2))
if plosher
{
	spr_move = spr_plosher
	spr_turn = spr_plosher_turn
	spr_stun = spr_plosher_stun
	spr_scared = spr_plosher_scared
	spr_dead = spr_plosher_dead
	alarm[1] = 10
}
hitbox = false
hitboxInst = noone