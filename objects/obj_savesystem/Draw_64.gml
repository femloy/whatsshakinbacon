if show_icon
{
	var _a = clamp(icon_alpha, 0, 1)
	draw_sprite_ext(spr_littlesaltdance, icon_index, SCREEN_WIDTH - 74, SCREEN_HEIGHT - 74, 1, 1, 0, c_white, _a)
}