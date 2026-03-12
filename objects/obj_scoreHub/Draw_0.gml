draw_self()
draw_set_font(global.kettleFont)
draw_set_halign(fa_left)
var _xx = x + 16 - (string_width(collect) / 2) - 4
	if lastcollect != collect
	{
		colorarray = array_create(string_length(collect), 0)
		
		for (var i = 0; i < array_length(colorarray); i++)
		{
			colorarray[i] = random_range(0, 1)
		}
		lastcollect = collect
	}
	for (var i = 0; i < string_length(collect); i++)
	{
		var _yOffset = (i + 1) % 2 == 0 ? -5 : 0
		shader_set(shd_pal_swapper)
		pal_swap_set(pal_kettlefont, colorarray[i], false)
		draw_text(floor(_xx), floor(y + 12 + _yOffset), string_char_at(collect, i + 1))
		_xx += string_width(collect) / string_length(collect)
		shader_reset()
	}


if showRank
	draw_sprite_ext(spr_hudRanks, rankIndex, x - 15, y + 79, rankScale, rankScale, 0, c_white, 1)