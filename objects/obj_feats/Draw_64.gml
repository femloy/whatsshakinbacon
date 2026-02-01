draw_sprite_tiled_ext(spr_optionsBG, 5, BGX, BGY, 1, 1, c_white, 1)
var _xx = SCREEN_WIDTH / 2
var _yy = SCREEN_HEIGHT / 2
var _padding = 100
_xx -= _padding / array_length(achievement)
for (var i = 0; i < array_length(achievement); i++)
{
	var q = achievement[i]
	var a = ds_map_find_value(global.achievements, q)
	ini_open(global.saveFile)
	var _unlocked = ini_read_real("Achievements", a.name, false) == true
	ini_close()
	var _index = a.achievementIndex
	if !_unlocked
		_index++
	draw_set_alpha(selected == i ? 1 : 0.5)
	draw_sprite(a.achievementSprite, _index, _xx + (_padding * i), _yy)
	draw_set_alpha(1)
	if selected == i
	{
		draw_set_font(global.creditsfont)
		draw_set_halign(fa_center)
		draw_text(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 150, a.name)
		draw_text(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 150 + (string_height("A") * 2), a.description)
	}
}
draw_set_halign(fa_left)
draw_text_oyh(64, 64, "[G] Back")