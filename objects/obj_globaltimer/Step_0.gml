var s = 1 / 60
global.save_timer += s
if global.level != noone && !obj_pause.active && !instance_exists(obj_rank)
	global.level_timer += s