if global.escape.active
{
	var __val = super ? 20 : 10
	global.collect += __val
	global.combo.timer += 10
	global.combo.timer = clamp(global.combo.timer, 0, 60)
	create_smalltext(__val)
	create_collect(sprite_index, x, y)
	ds_list_add(global.escaperoom, id)
	instance_destroy()
	FMODevent_oneshot("event:/Sfx/General/Collects/escapecollect", x, y)
	var roomname = string_letters(room_get_name(room))
	var isSecret = string_pos("secret", roomname) > 0
	if isSecret
		create_ghost_self_visual()
	create_particleStatic(spr_sparkle, x, y, 1)
	add_party_time(1 / 5, 10)
}