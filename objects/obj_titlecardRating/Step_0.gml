if scene == 0
{
	circleSize = approach(circleSize, SCREEN_WIDTH, circleSizeSpeed)
	circleSizeSpeed += 1
	if circleSize == SCREEN_WIDTH
	{
		scene = 1
		alarm[0] = 25
	}
	
}
if scene == 2
{
	ratingAlpha = approach(ratingAlpha, 1, 0.1)
	if ratingAlpha == 1 && alarm[0] <= 0
	{
		alarm[0] = 60 * 4
	}
}
if scene == 3
{
	ratingAlpha = approach(ratingAlpha, 0, 0.01)
	if ratingAlpha == 0
	{
		instance_destroy()
	}
}