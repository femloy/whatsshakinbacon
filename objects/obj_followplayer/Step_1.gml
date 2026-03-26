if obj_player.hitstun.is
	exit;
	
ds_queue_enqueue(followqueue, obj_player.x)
ds_queue_enqueue(followqueue, obj_player.y)
ds_queue_enqueue(followqueue, obj_player.xscale)
	
if ds_queue_size(followqueue) > (queue_lag * position_in_line)
{
	target_x = ds_queue_dequeue(followqueue)
	target_y = ds_queue_dequeue(followqueue)
	xscale = ds_queue_dequeue(followqueue)
}

if obj_player.x != x
	image_xscale = sign(obj_player.x - x)
	
image_alpha = obj_player.image_alpha
space = approach(space, xscale, 0.1 / (position_in_line / 4))
interp = min(interp + 0.01, 1)
if canmove
{
	if interp < 1
	{
		x = lerp(x, target_x - (32 * space) * max(position_in_line, 1), max(interp, 0.01))
		y = lerp(y, target_y, max(interp, 0.01))
	}
	else
	{
		x = target_x - (32 * space) * max(position_in_line, 1)
		y = target_y
	}
}
if ds_list_find_index(global.followers, id) == -1
	instance_destroy()