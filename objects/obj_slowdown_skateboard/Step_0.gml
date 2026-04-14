if obj_player.state != states.skateboard
{
	image_alpha = 0.25
}
else
{
	in_range = distance_to_object(obj_player) < 32 * 32 && !collision_line(x, y, obj_player.x ,obj_player.y, obj_solid, false, true)
	if in_range
	{
		image_alpha = 1
		obj_player.skatespeed = 12
	}
	else
	{
		image_alpha = 0
	}
}