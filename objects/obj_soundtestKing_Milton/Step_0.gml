if dancing
	x = lerp(x, xstart + wave(-96, 96, 3, 60), 0.1)
else {
	x = lerp(x, xstart, 0.1)
}
y = lerp(y, ystart, 0.1)
if obj_soundtestPlayer.isMilton
	xstart = 704
else
	xstart = 1440
dancing = obj_soundtestPlayer.playing
if dancing
{
	if animation_end()
		image_index = image_number - 1
}