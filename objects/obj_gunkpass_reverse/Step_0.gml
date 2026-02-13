var _transfoPass = [
	states.gunkIntro,
	states.gunkMove,
	states.gunk
	]
if !array_contains(_transfoPass, obj_player.state)
{
	image_alpha = 0.3
	x = -100
	y = -100
}
else
{
	image_alpha = 1
	x = xstart
	y = ystart
}