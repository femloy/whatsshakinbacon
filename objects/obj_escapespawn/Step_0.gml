if point_distance(x, 0, obj_player.x, 0) <= 550 && 
	point_distance(0, y, 0, obj_player.y) <= 256 && visible == false && global.escape.active && activated == false
{
	active = true
	image_index = 0
}
if active == false
	instance_deactivate_object(content)
if active == true
{
	if activated == false
	{
		activated = true
		FMODevent_oneshot("event:/Sfx/General/Enemy/spawnenemy", x, y)
		instance_activate_object(content)
		with content
		{
			x = other.x
			y = other.y - 15
			create_particleStatic(spr_genericpoofeffect, x, y, 1, -1)
			sprite_index = spr_stun
			scared = 30
			state = states.stun
			escapeSpawned = true
		}
	}
	if animation_end()
		instance_destroy()
}
