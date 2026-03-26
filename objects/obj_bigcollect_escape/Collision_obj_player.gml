if global.escape.active
{
	if !global.escape.party
		create_ghost_self_visual()
	var __val = super ? 200 : 100
	global.collect += __val
	global.combo.timer = 60
	create_smalltext(__val)
	create_collect(sprite_index, x, y)
	ds_list_add(global.escaperoom, id)
	instance_destroy()
	FMODevent_oneshot("event:/Sfx/General/Collects/escapecollectBig", x, y)
	tv_anim(spr_tv_happy, 60 * 3)
	with obj_player
	{
		if irandom(100) <= 25
			fmod_studio_event_instance_start(soundsLaugh)
	}
	var roomname = string_letters(room_get_name(room))
	var isSecret = string_pos("secret", roomname) > 0
	if isSecret
		create_ghost_self_visual()
	repeat(4)
		create_particleStatic(spr_sparkle, x + irandom_range(-16, 16), y + irandom_range(-16, 16), 1)
	obj_hud.lapbar.time += 60 * 10
	obj_hud.lapbar.freeze += 60
}