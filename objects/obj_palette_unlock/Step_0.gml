if !finish
{
	var ty = SCREEN_HEIGHT - 140
	y = approach(y, ty, movespeed)
	if y == ty && alarm[0] <= 0
		alarm[0] = 200
}
else {
	y = approach(y, SCREEN_HEIGHT + 200, movespeed)
	movespeed = approach(movespeed, 8, 0.1)
	if y >= SCREEN_HEIGHT + 200
		instance_destroy()
}