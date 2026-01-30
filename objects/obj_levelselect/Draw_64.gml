ini_open(global.saveFile)
var _level = levels[selectedWorld][selectedLevel][1]
var _score = ini_read_real(_level, "Highscore", 0)
var _rank = ini_read_string(_level, "Rank", "D")
var _rankIndex = 0
if _rank == "D"
	_rankIndex = 0
if _rank == "C"
	_rankIndex = 1
if _rank == "B"
	_rankIndex = 2
if _rank == "A"
	_rankIndex = 3
if _rank == "S"
	_rankIndex = 4
if _rank == "P"
	_rankIndex = 5
ini_close()

draw_set_font(global.bigfont)
draw_set_halign(fa_center)
draw_text(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 50 - 128, string_upper(worldNames[selectedWorld]))
draw_text(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 50, string_upper(levels[selectedWorld][selectedLevel][3]))
for (var i = 0; i < 5; i++)
{
	var _toppinSprites = [spr_potablebean_idle, spr_potablecup_idle, spr_potablelime_idle, spr_potablebag_idle, spr_potableorange_idle]
	ini_open(global.saveFile)
	var _hasToppin = ini_read_real(_level, $"Toppin{i + 1}", 0) != 0
	draw_sprite_ext(_toppinSprites[i], potableIndex, (SCREEN_WIDTH / 2 - (64 * 2)) + (64 * i), SCREEN_HEIGHT / 2 - 50 + 64, 1, 1, 0, _hasToppin ? c_white : c_black, 1)
	ini_close()
}
draw_sprite(spr_hudRanks, _rankIndex, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 50 + 128 + 16)
draw_text(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 50 + 128 + 64, _score)