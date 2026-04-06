draw_sprite_ext(sprite_index, image_index, x + xoffset, y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, image_alpha)

if escapeSpawned
{
	image_alpha = approach(image_alpha, wave(0.4, 1, 2, 0), 0.1)
	gpu_set_blendmode(bm_add)
	draw_sprite_ext(sprite_index, image_index, x + xoffset + wave(5, -5, 1, 0), y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, image_alpha / 4)
	draw_sprite_ext(sprite_index, image_index, x + xoffset - wave(5, -5, 1, 0), y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, image_alpha / 4)
	reset_blendmmode()
}

xscaleMulti = lerp(xscaleMulti, 1, 0.25)
yscaleMulti = lerp(yscaleMulti, 1, 0.25)