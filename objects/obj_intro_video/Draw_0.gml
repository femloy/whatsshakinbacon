var _data = video_draw();
var _status = _data[0];

if (_status == 0)
{
	var _surface = _data[1];
	draw_surface_stretched(_surface, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
if prompSkip
{
	draw_set_font(global.creditsfont)
	draw_set_halign(fa_left)
	draw_text_oyh(32, SCREEN_HEIGHT - 64, "[J] Skip")
}