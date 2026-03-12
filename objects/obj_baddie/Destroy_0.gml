var _saveroom = escape ? global.escaperoom : global.saveroom
if ds_list_find_index(_saveroom, id) == -1
{
	FMODevent_oneshot("event:/Sfx/General/Enemy/killenemy", x, y)
	if object_index != obj_sunny
		ds_list_add(_saveroom, id)
	global.combo.timer = 60
	if object_index != obj_sunny && !spawned
	{
		global.combo.amt += 1
		if !supertauntKill
			obj_player.supertaunt++
	}
	shake_camera(3, 3)
	with instance_create(x, y, obj_baddiedead)
	{
		sprite_index = other.spr_dead
	}
	repeat (3)
	{
		create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5)
		create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5)
	}
	create_particleStatic(spr_genericpoofeffect, x, y, 1, -2)
	create_particleStatic(spr_bangeffect, x, y, 1)
	if object_index == obj_slosher
	{
		create_particleStatic(plosher ? spr_plosher_splat : spr_slosher_splat, x, y, 1)
	}
	if prank && global.prankenemy_cankill
	{
		global.prankenemy_killed = true
		show_debug_message("P Rank Started")
	}
}
if object_index == obj_slosher 
{
	FMODevent_oneshot("event:/Sfx/General/Enemy/balloonsplat", x, y)
	instance_create(x, y, obj_sloshersplat).blend = !plosher ? #ffad5a : #c59fff
}