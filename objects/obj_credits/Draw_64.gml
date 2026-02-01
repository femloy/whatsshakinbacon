for (var i = 0; i < array_length(credits); i++)
{
	draw_set_font(global.creditsfont)
	draw_text(SCREEN_WIDTH / 2, y + (credits[i].y * string_height("A")), credits[i].text)
}
y--