draw_sprite_ext(sprite_index, image_index, x + xoffset, y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, image_alpha)

if escapeSpawned
{
	gpu_set_blendmode(bm_add)
	draw_sprite_ext(sprite_index, image_index, x + xoffset + 5, y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, image_alpha / 4)
	draw_sprite_ext(sprite_index, image_index, x + xoffset - 5, y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, image_alpha / 4)
	reset_blendmmode()
}

xscaleMulti = lerp(xscaleMulti, 1, 0.25)
yscaleMulti = lerp(yscaleMulti, 1, 0.25)