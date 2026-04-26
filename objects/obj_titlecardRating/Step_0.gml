if scene == 0
{
	circleSize = approach(circleSize, 9, circleSizeSpeed)
	circleSizeSpeed += 1 / 45
	if circleSize == 9
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