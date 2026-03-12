draw_set_alpha(backAlpha)
draw_rectangle_colour(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, blend, blend, blend, blend, false)
draw_set_alpha(backAlpha)
for (var i = 0; i < array_length(stickers); i++)
{
	var q = stickers[i]
	draw_sprite_ext(spr_rank_transition_stickers, q.index, q.x, q.y, q.scale, q.scale, 0, blend, 1)
	q.scale = approach(q.scale, 1, 0.1)
}