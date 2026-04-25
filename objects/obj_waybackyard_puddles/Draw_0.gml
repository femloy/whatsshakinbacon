draw_self()

if !in_camera()
	exit;

if !surface_exists(surf)
	surf = surface_create(sprite_width, sprite_height)
if !surface_exists(clip)
	clip = surface_create(sprite_width, sprite_height)

surface_set_target(clip);
draw_clear_alpha(c_black, 0)
draw_rectangle_colour(0, 0, sprite_width, sprite_height, c_white, c_white, c_white, c_white, false)
gpu_set_blendmode(bm_subtract)
draw_sprite_ext(spr_wayback_puddle, image_index, 0, 0, image_xscale, image_yscale, 0, c_white, 1)
reset_blendmmode()
surface_reset_target()

surface_set_target(surf);
draw_clear_alpha(c_black, 0)
if instance_exists(obj_player)
{
	with obj_player
	{
		draw_sprite_ext(sprite_index, image_index, x - other.x, y - other.y + 92, xscale, -1, 0, c_white, 1)
	}
}
if instance_exists(obj_baddie)
{
	with obj_baddie
	{
		draw_sprite_ext(sprite_index, image_index, x - other.x, y - other.y + 92, xscale, -1, 0, c_white, 1)
	}
}
if instance_exists(par_potable)
{
	with par_potable
	{
		draw_sprite_ext(sprite_index, image_index, x - other.x, y - other.y + 92, image_xscale, -1, image_alpha, image_blend, image_alpha)
	}
}

gpu_set_blendmode(bm_subtract)
draw_surface(clip, 0, 0)
reset_blendmmode()
surface_reset_target()

draw_surface(surf, x, y)
