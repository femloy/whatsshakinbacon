if menu == 0
{
var xx = SCREEN_WIDTH / 2
var opt = menus[currentmenu]
var yy = SCREEN_HEIGHT / 2 - (48 * (array_length(opt) - 2));
	for (var i = 0; i < array_length(opt); i++)
	{
		var q = opt[i]
		var _col = selected == i ? c_white : c_grey
		draw_set_font(global.bigfont)
		draw_set_color(_col)
		draw_set_halign(fa_center)
		draw_text_oyh(xx, yy, q[1])
		yy += 48;
	}
}
draw_set_font(global.creditsfont);
draw_set_halign(fa_center)
if menu == 1
{
	draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, "[wave]Enter the IP");
	draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 32, $"[wave]{textInput}");
}
if menu == 2
{
	draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, "[wave]Enter the Port");
	draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 32, $"[wave]{textInput}");
}
draw_set_color(c_white)