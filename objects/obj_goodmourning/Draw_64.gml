draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)

gpu_set_blendmode(bm_add)
image_alpha = approach(image_alpha, wave(0.4, 1, 2, 0), 0.1)
draw_sprite_ext(sprite_index, 0, x + wave(5, -5, 1, 0), y, image_xscale, image_yscale, image_angle, image_blend, image_alpha / 4)
draw_sprite_ext(sprite_index, 0, x - wave(5, -5, 1, 0), y, image_xscale, image_yscale, image_angle, image_blend, image_alpha / 4)
reset_blendmmode()