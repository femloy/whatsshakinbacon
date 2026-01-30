if fadein == true
{
	image_alpha = approach(image_alpha, 1, 0.1)
	if image_alpha == 1 && !instance_exists(obj_loadingMini)
	{
		room_goto(targetRoom)
		fadein = false
	}
}
else if fadein == false {
	image_alpha = approach(image_alpha, 0, 0.1)
	if image_alpha == 0
		instance_destroy()
}