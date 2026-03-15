if point_distance(x, 0, obj_player.x, 0) <= 550 && 
	point_distance(0, y, 0, obj_player.y) <= 128 && visible == false && global.escape.active && activated == false
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
		instance_activate_object(content)
		with content
		{
			repeat(4)
				create_particleStatic(spr_escapespawner, x + irandom_range(-32, 32), y + irandom_range(-32, 32), 1, -5)
			image_alpha = 0
			x = other.x
			y = other.y - 15
			sprite_index = spr_stun
			scared = 50
			state = states.stun
			escapeSpawned = true
		}
	}
	if animation_end()
		instance_destroy()
}
