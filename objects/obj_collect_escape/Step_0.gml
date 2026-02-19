if global.escape.active
{
	if (distance_to_object(obj_player) < 25)
		gotoplayer = true
	if gotoplayer && canmove
	{
		move_towards_point(obj_player.x, obj_player.y, movespeed)
		movespeed += 0.5
	}
	canmove = place_empty(xstart, ystart, obj_solid)
	visible = canmove
}
image_alpha = global.escape.active ? 1 : 0.5