with obj_player
	visible = false
x += 2
if x > (960 / 3)
{
	whiteAlpha += 1 / (60 * 4)
	y += vsp
	vsp = approach(vsp, -1, 1 / 60)
}
if whiteAlpha >= 1.1
	event_user(0)