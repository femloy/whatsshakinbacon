if point_distance(x, 0, obj_player.x, 0) <= 32 * 6 && point_distance(0, y, 0, obj_player.y) <= 32 * 6
{
	if collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true) != -4
		exit;
	instance_create(x, y, obj_paintbuddy_follower)
	global.has_paint = true
	global.painting_count = 0
	global.painting_max = maxPaints
	instance_destroy()
	ds_list_add(global.saveroom, id)
}