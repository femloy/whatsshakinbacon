if global.escape.active && active == false && distance_to_pos(xstart, ystart, obj_player.x, obj_player.y, 350, 400)
{
	active = true
	y = camera_get_view_y(view_camera[0]) - 100
	visible = true
	sprite_index = lenny ? spr_lenny_pointer_fall : spr_naomi_fall
	vsp = 20
}

if !global.escape.active
{
	active = false
	visible = false
	y = ystart
	sprite_index = lenny ? spr_lenny_pointer : spr_naomi_pointer
	vsp = 0
}

if active
{
	if y >= ystart
	{
		y = ystart
		sprite_index = lenny ? spr_lenny_pointer : spr_naomi_pointer
	}
	else {
		y += vsp
		if vsp < 20
			vsp += 0.5
		if place_meeting(x, y, obj_baddie)
		{
			with instance_place(x, y, obj_baddie)
				instance_destroy()
		}
	}
}