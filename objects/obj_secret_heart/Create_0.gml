image_speed = 0.35
depth = 50
cutscene = false
facing = sign(image_xscale)
image_xscale = 1
if ds_list_find_index(global.saveroom, id) != -1 && obj_player.door == "DOODLE"
{
	obj_player.x = x
	obj_player.y = y
	instance_destroy()
	if obj_player.state == -4
		instance_create(x, y, obj_secret_heart_enter)
}
soundtest = false
sprite_index = spr_loveportal_open
image_index = 0