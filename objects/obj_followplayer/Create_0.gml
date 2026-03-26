ds_list_add(global.followers, id)
position_in_line = ds_list_find_index(global.followers, id) + 1
followqueue = ds_queue_create()
queue_lag = 20
target_x = x
target_y = y
xscale = 1
space = 1
interp = 0
canmove = true