if ds_list_find_index(global.saveroom, id) != -1
	image_index = 0
if global.escape.active
	image_index = 1
if !place_meeting(x, y, obj_player)
{
	global.prankenemy_cankill = false
}