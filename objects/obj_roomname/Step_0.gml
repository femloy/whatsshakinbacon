if show = false
{
	textX = approach(textX, -192, textXspd)
	textXspd += 0.35
}
else
{
	textX = lerp(textX, 192, 0.15)
	textXspd = 0
}
