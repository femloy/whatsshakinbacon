draw_set_alpha(backAlpha)
var blend = #5b0715
draw_rectangle_colour(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, blend, blend, blend, blend, false)
draw_set_alpha(1)
for (var i = 0; i < array_length(stickers); i++)
{
	var q = stickers[i]
	draw_sprite_ext(spr_secret_transition_balloons, q.index, q.x, q.y, q.scale, q.scale, 0, c_white, q.alpha)
	q.scale = approach(q.scale, 1, 0.1)
	if goaway
	{
		q.alpha -= q.fadeSpeed
		q.y += q.vspeed
		q.vspeed += q.targetSpeed / 15
	}
	if q.alpha <= 0
	{
		array_delete(stickers, i, 1)
		i--
	}
}
if goaway
{
	backAlpha -= 1 / 45
	if array_length(stickers) <= 0
		instance_destroy()
}
draw_set_alpha(1)