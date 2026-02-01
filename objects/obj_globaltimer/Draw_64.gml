if !global.option_hud || !global.option_timer || instance_exists(obj_titlecard) || room == Mainmenu || room == rm_intro || room == credits_room
	exit;
draw_set_font(global.smallfont)
draw_set_color(c_white)
draw_set_halign(fa_left)
var _time = global.save_timer
var _str = [timeString(_time)]

if global.option_timer_type == 1
	_str = []

if (global.option_timer_type == 2 || global.option_timer_type == 1) && global.level != noone
	array_push(_str, timeString(global.level_timer))
var i = array_length(_str) - 1
var yy = 1

while (i >= 0)
{
	var b = _str[i]
	b = string_copy(b, 0, string_length(b) - 1)
	var _len =  string_length(b) - 1
	var _xx = _len * string_width("a")
	var _yy = (string_height("a") * yy)
	draw_text(SCREEN_WIDTH - _xx + 8, SCREEN_HEIGHT - _yy, b)
	yy++
	i--
}
//draw_text(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 100, string_format(global.save_timer, 0, 3))