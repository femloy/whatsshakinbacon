function scr_compileIconText(_string)
{
	var _keyFunc = function(_isKey, _value, _sprite = spr_tutorialkeyspecial) constructor
	{
		isKey = _isKey
		value = _value
		sprite = _sprite
	}
	var _inputFind = ""
	var _prioritizeInput = global.gamepadConnected
	switch _string
	{
		case "U":
			_inputFind = "up"
			break
		case "D":
			_inputFind = "down"
			break
		case "L":
			_inputFind = "left"
			break
		case "R":
			_inputFind = "right"
			break
		case "Q":
			_inputFind = "attack"
			break
		case "J":
			_inputFind = "jump"
			break
		case "G":
			_inputFind = "slap"
			break
		case "T":
			_inputFind = "taunt"
			break
		case "S":
			_inputFind = "start"
			break
	}
	if array_length(global.inputMap[$ $"Inputs_Player1_{_inputFind}Key"]) <= 0
		return new _keyFunc(false, " ")
	var _inputKey = [global.inputMap[$ $"Inputs_Player1_{_inputFind}Key"][0], global.inputMap[$ $"Inputs_Player1_{_inputFind}Pad"][0]]
	var _inputKeystring = chr(_inputKey[_prioritizeInput])
	var _key = -4
	if _prioritizeInput == 0
	{
		switch _inputKey[0]
		{
			case vk_left:
				_key = new _keyFunc(true, 6)
				break
			case vk_down:
				_key = new _keyFunc(true, 4)
				break
			case vk_up:
				_key = new _keyFunc(true, 3)
				break
			case vk_right:
				_key = new _keyFunc(true, 5)
				break
			case vk_space:
				_key = new _keyFunc(true, 2)
				break
			case vk_control:
				_key = new _keyFunc(true, 1)
				break
			case vk_escape:
				_key = new _keyFunc(true, 7)
				break
			case vk_shift:
				_key = new _keyFunc(true, 0)
				break
			default:
				_key = new _keyFunc(false, _inputKeystring)
				break
		}
	}
	if _prioritizeInput == 1
	{
		switch _inputKey[1]
		{
			case gp_face1:
				_key = new _keyFunc(true, 0, global.buttonSpr)
				break
			case gp_face2:
				_key = new _keyFunc(true, 1, global.buttonSpr)
				break
			case gp_face3:
				_key = new _keyFunc(true, 2, global.buttonSpr)
				break
			case gp_face4:
				_key = new _keyFunc(true, 3, global.buttonSpr)
				break
			case gp_shoulderl:
				_key = new _keyFunc(true, 4, global.buttonSpr)
				break
			case gp_shoulderr:
				_key = new _keyFunc(true, 5, global.buttonSpr)
				break
			case gp_shoulderrb:
				_key = new _keyFunc(true, 6, global.buttonSpr)
				break
			case gp_shoulderlb:
				_key = new _keyFunc(true, 7, global.buttonSpr)
				break
			case gp_stickl:
				_key = new _keyFunc(true, 8, global.buttonSpr)
				break
			case gp_stickr:
				_key = new _keyFunc(true, 9, global.buttonSpr)
				break
			case gp_padu:
				_key = new _keyFunc(true, 10, global.buttonSpr)
				break
			case gp_padr:
				_key = new _keyFunc(true, 11, global.buttonSpr)
				break
			case gp_padd:
				_key = new _keyFunc(true, 12, global.buttonSpr)
				break
			case gp_padl:
				_key = new _keyFunc(true, 13, global.buttonSpr)
				break
			case gp_start:
				_key = new _keyFunc(true, 14, global.buttonSpr)
				break
			case gp_select:
				_key = new _keyFunc(true, 15, global.buttonSpr)
				break
			case "joyLL":
				_key = new _keyFunc(true, 0, global.joystickSpr)
				break
			case "joyLR":
				_key = new _keyFunc(true, 1, global.joystickSpr)
				break
			case "joyLU":
				_key = new _keyFunc(true, 2, global.joystickSpr)
				break
			case "joyLD":
				_key = new _keyFunc(true, 3, global.joystickSpr)
				break
			case "joyRL":
				_key = new _keyFunc(true, 4, global.joystickSpr)
				break
			case "joyRR":
				_key = new _keyFunc(true, 5, global.joystickSpr)
				break
			case "joyRU":
				_key = new _keyFunc(true, 6, global.joystickSpr)
				break
			case "joyRD":
				_key = new _keyFunc(true, 7, global.joystickSpr)
				break
		}
	}
	return _key
	
}

global.textCache = ds_map_create()
global.textFunc = ds_map_create()
global.textSize = 1

function scr_sleep(ms = 5)
{
	var t = current_time + ms;
	while current_time < t
		do {};
}

function parse_textEX(_text, _w)
{
	var _stringArr = []
	var _lines = []
	var _line = 0
	var _lX = 0
	var _lY = 0
	var _effect = noone
	var newWord = false
	for (var i = 1; i <= string_length(_text); i++)
	{
		var _letter = string_char_at(_text, i)
		var _word = ""
		
		if _letter == " "
			newWord = true
		else if newWord == true && _letter != " "
		{
			var c = i
			while (true)
			{
				var _lt = string_char_at(_text, c)
				if _lt == " " || c >= string_length(_text)
				{
					newWord = false
					break
				}
				_word += _lt
				c++
			}
		}
		if _lX + string_width(_word)  >= _w
		{
			_line += 1
			_lX = 0
			_lY += string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
			array_push(_lines, { w: _lX })
		}
		
		var _str = {specialType: noone, letter: _letter, ogx: _lX, ogy: _lY, x: _lX, y: _lY, effect: _effect, line: _line}
		switch (_letter) {
			case "#":
				array_push(_lines, { w: _lX })
				_line += 1
				_lX = 0
				_lY += string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
			break
			case "[":
				var containedStr = ""
				var c = i + 1
				while (true)
				{
					var _lt = string_char_at(_text, c)
					if _lt == "]"
					{
						i = c
						break
					}
					containedStr += _lt
					c++
				}
				if string_pos("global.", containedStr) > 0
				{
					var _gl = string_split(containedStr, "global.", true, 1)
					_str.letter = variable_global_get(_gl[0])
					_lX += string_width(_str.letter) + 1
					array_push(_stringArr, _str)
				}
				else {
					switch containedStr
					{
						case "L": 
						case "R": 
						case "U": 
						case "D": 
						case "G": 
						case "Q": 
						case "J":
						case "T":
						case "S":
							_str.specialType = "controlKey" 
							var q = scr_compileIconText(containedStr)
							_str.keyDet = q
							_lX += sprite_get_width(q.sprite)
							array_push(_stringArr, _str)
							break
						case "wave":
						case "shake":
							_effect = containedStr
							break
						case "clear":
							_effect = noone
							break
						case "Bacontu":
							_str.specialType = "Bacontu"
							_lX += sprite_get_width(spr_ico)
							array_push(_stringArr, _str)
							break
					}
				}
				break
			default:
				if !(_lX == 0 && _letter == " ")
					_lX += string_width(_letter)
				array_push(_stringArr, _str)
			break
		}
	}
	array_push(_lines, { w: _lX })
	return [_stringArr, _lines, _lY]
}

function draw_text_oyh(_x, _y, _text, _w = string_width(_text), _typewriter = undefined)
{
	var exists = ds_map_exists(global.textFunc, _text)
	if !ds_map_exists(global.textCache, _text)
	{
		ds_map_add(global.textCache, _text, parse_textEX(_text, _w))
		show_debug_message($"Added {_text} to cache")
	}
	
	var func = function(_x, _y, _text, w = string_width(_text), _typewriter)
	{
		var _stringArr = ds_map_find_value(global.textCache, _text)[0]
		var _stringArrLength = array_length(_stringArr)
		if is_undefined(_typewriter)
			_typewriter = _stringArrLength
		var _size = global.textSize
		
		var _lines = ds_map_find_value(global.textCache, _text)[1]
		var _pHAlign = draw_get_halign()
		var _pVAlign = draw_get_valign()
		var _pFont = draw_get_font()
		var _pColor = draw_get_color()
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	
		for (var i = 0; i < _typewriter; i++)
		{
			var _lDat = _stringArr[i]
			var _lType = _lDat.specialType
			var _XX = _x + (_lDat.x * _size)
			var _YY = _y + (_lDat.y * _size)
			switch _pHAlign
			{
				case fa_center:
					_lDat.x = _lDat.ogx - _lines[_lDat.line].w / 2
				break
				case fa_right:
					_lDat.x = _lDat.ogx - _lines[_lDat.line].w 
				break
			}
			switch _pVAlign
			{
				case fa_middle:
					_lDat.y = _lDat.ogy / 2 * _size
				break
				case fa_bottom:
					_lDat.y = _lDat.ogy - _lDat.ogy * _size
				break
			}
			switch _lDat.effect
			{
				default:
					_XX = _x + _lDat.x * _size
					_YY = _y + _lDat.y * _size
				break
				case "shake":
					_XX = _x + _lDat.x * _size + irandom_range(-1, 1)
					_YY = _y + _lDat.y * _size + irandom_range(-1, 1)
				break
				case "wave":
					_XX = _x + _lDat.x * _size
					_YY = _y + _lDat.y * _size + irandom_range(-1, 1)
				break
			}
			_XX = floor(_XX)
			_YY = floor(_YY)
			switch _lType
			{
				case noone:
					draw_text_transformed(_XX, _YY, _lDat.letter, _size, _size, 0)
				break
				case "Bacontu":
					draw_sprite(spr_ico, 0, _XX - 2, _YY - 7)
					break
				case "controlKey":
					if _lDat.keyDet.isKey
					{
						draw_sprite(_lDat.keyDet.sprite, _lDat.keyDet.value, _XX - 8, _YY + 2)
					}
					else
					{
						draw_sprite_ext(spr_tutorialkey, 0, _XX - 8, _YY + 2, _size, _size, 0, c_white, draw_get_alpha())
						draw_set_font(global.npcfont)
						draw_set_colour(c_black)
						draw_text_transformed_colour(_XX, _YY - 6, _lDat.keyDet.value, _size, _size, 0, c_black, c_black, c_black, c_black, draw_get_alpha())
						draw_set_font(_pFont)
						draw_set_colour(_pColor)
					}
				break
			}
		}
		draw_set_halign(_pHAlign)
		draw_set_valign(_pVAlign)
	}
	
	if !exists
	{
		func(_x, _y, _text, _w = string_width(_text), _typewriter)
		ds_map_add(global.textFunc, _text, func)
	}
	else
	{
		var draw  = ds_map_find_value(global.textFunc, _text)
		draw(_x, _y, _text, _w = string_width(_text), _typewriter)
	}
	
	return false
}

function text_clear(text = "") //Leave blank to clear the whole cache
{
	if text != ""
		ds_map_delete(global.textCache, text)
	else
		ds_map_clear(global.textCache)
}