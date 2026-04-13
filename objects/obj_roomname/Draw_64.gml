if !global.option_hud
	exit;
var _xx = textX
var _yy = SCREEN_HEIGHT - 60
draw_sprite(spr_roomname, 0, _xx, _yy)
draw_set_font(global.smallfont)
draw_set_halign(fa_center)
draw_text(_xx + 28, _yy + 4, string_lower(text))