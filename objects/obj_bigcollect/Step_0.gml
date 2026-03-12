if (distance_to_object(obj_player) < 25)
	gotoplayer = true
if gotoplayer && canmove
{
	move_towards_point(obj_player.x, obj_player.y, movespeed)
	movespeed++
}
canmove = place_empty(xstart, ystart, obj_solid)
visible = canmove