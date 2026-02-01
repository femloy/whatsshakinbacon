x += hsp
y += vsp
vsp += 0.5
if !in_camera()
	instance_destroy()
if place_meeting(x, y, obj_player) && vsp >= 0
{
	hsp = random_range(10, 12) * sign(x - obj_player.x)
	vsp = random_range(-10, -14)
	create_particleStatic(spr_bangeffect, x, y, 1)
}