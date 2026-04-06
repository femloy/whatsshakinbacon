for (var i = 0; i < image_number; i++)
{
	draw_sprite(sprite_index, i, x, y + wave(15, -15, 2, i * 80))
	gpu_set_blendmode(bm_add)
	draw_set_alpha(wave(0, 0.2, 1, i * 40))
	draw_sprite(sprite_index, i, x - 16, y + wave(15, -15, 2, i * 80))
	draw_sprite(sprite_index, i, x + 16, y + wave(15, -15, 2, i * 80))
	draw_set_alpha(1)
	gpu_set_blendmode(bm_normal)
}
draw_set_alpha(whiteAlpha)
draw_rectangle_colour(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_white, c_white, c_white, c_white, false)
draw_set_alpha(1)
if whiteAlpha > 1
{
	draw_set_color(c_black)
	draw_set_font(font_caption)
	draw_set_halign(fa_center)
	draw_text(SCREEN_WIDTH / 2 + irandom_range(-1, 1), SCREEN_HEIGHT / 2 + irandom_range(-1, 1), "wake up")
	draw_set_colour(c_white)
}