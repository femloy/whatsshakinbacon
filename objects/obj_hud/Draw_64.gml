if !global.option_hud
	exit;

if (!ds_list_empty(collectVis))
{
	for (var i = 0; i < ds_list_size(collectVis); i++)
	{
		var q = ds_list_find_value(collectVis, i)
		with q
		{
			draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, 1)
		}
	}
}

with kettle
{
	var cmb = 0
	if global.combo.amt >= 25
		cmb = 1
	if global.combo.amt >= 50
		cmb = 2
	
	index += (0.25 * cmb)
	if cmb == 0
		index = 0
	draw_sprite(spr_kettleScore, index, kx, ky - offset)
	draw_set_font(global.kettleFont)
	draw_set_halign(fa_left)
	
	var _xx = kx + 16 - (string_width(global.collect) / 2) - 4
	if lastcollect != global.collect
	{
		colorarray = array_create(string_length(global.collect), 0)
		
		for (var i = 0; i < array_length(colorarray); i++)
		{
			colorarray[i] = irandom_range(0, 1)
		}
		lastcollect = global.collect
	}
	for (var i = 0; i < string_length(global.collect); i++)
	{
		var _yOffset = (i + 1) % 2 == 0 ? -7 : 0
		shader_set(shd_pal_swapper)
		pal_swap_set(pal_kettlefont, colorarray[i], false)
		draw_text(floor(_xx), floor(ky + 12 - offset + _yOffset), string_char_at(global.collect, i + 1))
		_xx += string_width(global.collect) / string_length(global.collect)
		shader_reset()
	}
	//draw_text(kx + 16, ky + 12 - offset, global.collect)
	var rankindex = 0;
	if scr_Prank()
		rankindex = 5
	else if global.collect >= global.Srank
		rankindex = 4
	else if global.collect >= global.Arank
		rankindex = 3
	else if global.collect >= global.Brank
		rankindex = 2
	else if global.collect >= global.Crank
		rankindex = 1
	if previousRank != rankindex
	{
		previousRank = rankindex
		rankScale = 2
	}
	var rankX = x + sin(current_time * 0.001) * 2
	var rankY = y + cos(current_time * 0.001) * 2 - offset
	draw_sprite_ext(spr_hudRanks, rankindex, rankX + 160, rankY, rankScale, rankScale, 0, c_white, 1)
	var perc = 0
	switch rankindex
	{
		case 5:
			perc = 1
		break
		case 4:
			perc = 0
		break
		case 3:
			perc = (global.collect - global.Arank) / (global.Srank - global.Arank)
		break
		case 2:
			perc = (global.collect - global.Brank) / (global.Arank - global.Brank)
		break
		case 1:
			perc = (global.collect - global.Crank) / (global.Brank - global.Crank)
		break
		default:
			perc = global.collect / global.Crank
		break
	}
	var amt = sprite_get_height(spr_hudRanksFill) * perc
	var top = sprite_get_height(spr_hudRanksFill) - amt
	var xo = sprite_get_xoffset(spr_hudRanksFill)
	var yo = sprite_get_yoffset(spr_hudRanksFill)
	draw_sprite_part_ext(spr_hudRanksFill, rankindex, 0, top, sprite_get_width(spr_hudRanksFill), sprite_get_height(spr_hudRanksFill) - top,  rankX + 160 - xo, rankY - yo + top, rankScale, rankScale, c_white, 1)
	if obj_player.x < 295 && obj_player.y < 170
		offset = approach(offset, 300, 50)
	else {
		offset = approach(offset, 0, 50)
	}
}
with combometer
{
	var _perc = global.combo.timer / 60
	if state = -1
	{
		x = SCREEN_WIDTH - 149 + wave(-5, 5, 2, 0)
		y = approach(y, -128, 5)
		if global.combo.amt > 0
		{
			state = 0
			vsp = 15
		}
	}
	else if state == 0
	{
		x = SCREEN_WIDTH - 149 + wave(-5, 5, 2, 0)
		vsp += 0.5
		y += vsp
		if y > 210
			state = 1
	}
	else if state == 1
	{
		if _perc <= 0.5 && _perc > 0.2
		{
			x = SCREEN_WIDTH - 149 + wave(-5, 5, 2, 0) + irandom_range(-2, 2)
			vsp += 0.3
			y += vsp
			if y > 200
			{
				y = 200
				vsp = -2
			}
		}
		else if _perc <= 0.2
		{
			x = SCREEN_WIDTH - 149 + wave(-5, 5, 1, 0) + irandom_range(-5, 5)
			vsp += 0.3
			y += vsp
			if y > 200
			{
				y = 200
				vsp = -4
			}
		}
		else {
			x = SCREEN_WIDTH - 149 + wave(-5, 5, 2, 0)
			y = lerp(y, 200, 0.1)
		}
		if global.combo.amt == 0
			state = -1
	}
	draw_sprite(spr_combo_meter, 1, x, y - other.tv.offset)
	// Lights
	for (var i = 0; i < array_length(lights); i++)
	{
		var _yOffset = (i + 1) % 2 == 0 ? -5 : 5
		var q = lights[i]
		var _lights = array_length(lights) * _perc
		
		if arrowx < q.x && q.sprite == spr_comboLights
		{
			q.sprite = spr_comboLightsOff
			
			if state != -1
				FMODevent_oneshot("event:/Sfx/UI/Combo/flick", x, y)
		}
		else if arrowx >= q.x && q.sprite == spr_comboLightsOff
			q.sprite = spr_comboLights
			
		if q.sprite == spr_comboLights
		{
			q.x = x - 72 + (45 * i)
			q.y = y - 5 + wave(_yOffset, -_yOffset, 5, 0)
		}
		if q.sprite == spr_comboLightsOff
		{
			q.x = x - 72 + (45 * i) + irandom_range(-1, 1)
			q.y = y - 5 + irandom_range(-1, 1) + wave(_yOffset, -_yOffset, 5, 0)
		}
		q.index += 0.1
		pal_swap_set(spr_comboPalette, global.combo.dropped, false)
		draw_sprite(q.sprite, q.index, q.x, q.y - other.tv.offset)
		shader_reset()
	}
	var _startPos = lights[3].x + 15
	var _endPos = lights[0].x - 5
	var _lights = (array_length(lights) * _perc) / array_length(lights)
	arrowx = lerp(arrowx, _endPos + ((_startPos - _endPos) * _lights), 0.1)
	draw_sprite(spr_combo_arrow, 0, arrowx, y - 34 - other.tv.offset)
	
	draw_sprite(spr_combo_meter, 0, x, y - other.tv.offset)
	draw_set_font(global.comboFont)
	draw_set_halign(fa_right)
	draw_text(x - 4, y + 32 - other.tv.offset, global.combo.amt)
} 

with tv
{
	if sprite_index != spr_tv_turnon
		draw_sprite(spr_tv_bg, backindex, x, y - offset)
	pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false)
	draw_sprite(sprite_index, image_index, x, y - offset)
	shader_reset()
	pattern_draw(sprite_index, image_index, x, y - offset, 1, 1, 0, c_white, 1, global.patternSpr, global.PlayerCharacters[obj_player.character].patColors)
	if state == states.move
		draw_sprite(spr_tv_switch, switchindex, x, y - offset)
	if sprite_index != spr_tv_turnon
	{
		pal_swap_set(spr_tv_palette, obj_player.character + 1, false)
		draw_sprite(spr_tv_empty, 0, x, y - offset)
		shader_reset()
	}
	if sprite_index == spr_tv_turnon
	{
		pal_swap_set(spr_tv_palette, obj_player.character + 1, false)
		draw_sprite(spr_tv_turnon, image_index, x, y - offset)
		shader_reset()
	}
	if obj_player.x > room_width - 270 && obj_player.y < 320
		offset = approach(offset, 400, 100)
	else {
		offset = approach(offset, 0, 100)
	}
}


with bar
{
	var _escape = global.escape.active == true
	
	var roomname = string_letters(room_get_name(room))
	var _secret = string_pos("secret", roomname) > 0
	
	var _sec = wrap(global.escape.timer / 60, 0, 59)
	var _seconds = _sec
	
	if _sec < 10
		_seconds = string("0{0}", _sec)
		
	var _minutes = wrap(global.escape.timer / (60 * 60), 0, 59)
	var _timer = string("{1}:{0}", _seconds, _minutes)
	
	draw_set_font(global.bigfont)
	draw_set_halign(fa_center)
	
	if _escape
	{
		if ended
			y = approach(y, SCREEN_HEIGHT + 100, 1)
		else {
			y = approach(y, _secret ? SCREEN_HEIGHT + 100 : SCREEN_HEIGHT - 80, _secret ? 15 : 1)
		}
		var _width = sprite_get_width(spr_timerBar)
		var _height = sprite_get_height(spr_timerBar)
		var _cigarOffset = 42
		var _chunkFill = (1 - (global.escape.timer / chunkMax))
		var _fill = _width * _chunkFill
		if !ending
		{
			draw_sprite_part(spr_timerBar, 1, 0, 0, _fill, _height, x - _width / 2 - _cigarOffset, y - _height / 2)
			draw_sprite_part(spr_timerBar, 0, _fill, 0, _width, _height, x - _width / 2 + _fill - _cigarOffset, y - _height / 2)
			sparkIndex += 0.35
			draw_sprite(spr_timerMoon, sparkIndex, x + (_width / 2) + 10, y)
			draw_sprite(spr_timerBar_flame, sparkIndex, (x - _width / 2 - _cigarOffset) + (_width * _chunkFill), y)
			draw_text(x, y - 24, _timer)
		}
		else if ending
		{
			draw_sprite(spr_timerBar_end, endIndex, x - _cigarOffset, y)
			endIndex += 0.35
			if endIndex > sprite_get_number(spr_timerBar_end)
			{
				endIndex = sprite_get_number(spr_timerBar_end) - 2
				ended = true
			}
		}
		if ending && global.escape.timer != 0
		{
			ending = false
			ended = false
		}
		if global.escape.timer == 0
		{
			if ending == false
			{
				ended = false
				endIndex = 0
				ending = true
			}
		}
	}
	else
	{
		y = SCREEN_HEIGHT + 100
	}
}




