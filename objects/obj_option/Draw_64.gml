draw_set_color(c_white)
draw_sprite_tiled_ext(spr_optionsBG, 0, BGX, BGY, 1, 1, c_white, 1)
for (var i = 0; i < array_length(backgrounds); i++)
{
	draw_sprite_tiled_ext(spr_optionsBG, backgrounds[i].index, BGX, BGY, 1, 1, c_white, backgrounds[i].alpha)
	if backgrounds[i].menu != [option.main]
	{
		var _alpha = 0
		for (var q = 0; q < array_length(backgrounds[i].menu); q++)
		{
			if currentmenu == backgrounds[i].menu[q]
				_alpha = 1
		}
		backgrounds[i].alpha = approach(backgrounds[i].alpha, _alpha, 0.1)
	}
	else {
		backgrounds[i].alpha = 1
	}
}
var m = menus[currentmenu]
var opt = m.options
var _length = array_length(opt)
switch m.anchor
{
	case option.center:
		var xx = SCREEN_WIDTH / 2
		var yy = SCREEN_HEIGHT / 2 - (m.ypad * _length) / 2
		for (var i = 0; i < _length; i++)
		{
			var q = opt[i]
			var _col = selected == i ? c_white : c_grey
			draw_set_font(global.bigfont)
			draw_set_color(_col)
			draw_set_halign(fa_center)
			draw_text_oyh(xx, yy + m.ypad * i, lang_get_phrase(q.name))
			if is_struct(q.icon)
			{
				draw_set_alpha(q.icon.alpha)
				draw_sprite(spr_pauseicons, q.icon.index, floor(xx + irandom_range(-1, 1) + (string_width(lang_get_phrase(q.name)) / 2) + 50), floor(yy + m.ypad * i + irandom_range(-1, 1)))
				draw_set_alpha(1)
				q.icon.alpha = approach(q.icon.alpha, selected == i, 0.1)
			}
		}
	break
	case option.left:
		var xx = SCREEN_WIDTH / 6
		var yy = SCREEN_HEIGHT / 2 - (m.ypad * _length) / 2
		for (var i = 0; i < _length; i++)
		{
			draw_set_font(global.bigfont)
			var _col = selected == i ? c_white : c_grey
			draw_set_color(_col)
			var q = opt[i]
			switch q.type
			{
				case option.press:
					draw_set_halign(fa_left)
					draw_text_oyh(xx, yy + m.ypad * i, lang_get_phrase(q.name))
					break
				case option.multi:
					draw_set_halign(fa_left)
					draw_text_oyh(xx, yy + m.ypad * i, lang_get_phrase(q.name))
					draw_set_halign(fa_right)
					draw_text_oyh(SCREEN_WIDTH - xx, yy + m.ypad * i, lang_get_phrase(q.toggle[q.val]))
					break
				case option.slider:
					if selected != i && q.moving
						q.moving = false
					draw_set_halign(fa_left)
					draw_text_oyh(xx, yy + m.ypad * i, lang_get_phrase(q.name))
					draw_set_halign(fa_right)
					draw_sprite_ext(spr_slider, 0, SCREEN_WIDTH - xx - 150, yy + m.ypad * i, 1, 1, 0, _col, 1)
					draw_sprite(currentmenu != 1 ? spr_slidericon2 : spr_slidericon, q.moving, SCREEN_WIDTH - xx - 150 + (200 * (q.val / 100)), yy + m.ypad * i + 12)
					break
			}
		}
	break
	case option.keys:
			draw_set_halign(fa_left)
			draw_sprite(spr_tutorialkey, 0, 64 - 8, SCREEN_HEIGHT - (64 * 3) + 2)
			draw_set_color(c_black)
			draw_set_font(global.npcfont)
			draw_set_halign(fa_left)
			draw_text(64 - 5, SCREEN_HEIGHT - (64 * 3) - 6, "F1")
			draw_set_color(c_white)
			draw_set_font(global.creditsfont)
			draw_text_oyh(128 - 64, SCREEN_HEIGHT - (64 * 2), lang_get_phrase("option_add_bind"))
			draw_text(128, SCREEN_HEIGHT - (64 * 3), lang_get_phrase("option_reset_binds"))
			draw_text_oyh(128 - 64, SCREEN_HEIGHT - (64), lang_get_phrase("option_clear_binds"))
			for (var i = 0; i < _length; i++)
			{
				draw_set_font(global.bigfont)
				var _col = selected == i ? c_white : c_grey
				draw_set_color(_col)
				var q = opt[i]
				switch q.type
				{
					case option.press:
						var xx = SCREEN_WIDTH / 5
						var yy = 16 + (m.ypad)
						draw_set_halign(fa_left)
						draw_text_oyh(xx, yy + m.ypad * i, lang_get_phrase(q.name))
						break
					case option.key:
						var xx = SCREEN_WIDTH / 2 - 16
						var yy = 16 + (m.ypad) - keyscroll 
						draw_set_color(_col)
						var _sel = max(selected, 1)
						keyscroll = lerp(keyscroll, (_sel - 1) * 50, 0.01) 
						if !is_string(q.iconIndex)
							draw_sprite_ext(spr_controlicons, q.iconIndex, xx, yy + m.ypad * i - 16, 1, 1, 0, _col, 1)
						else {
							draw_set_font(global.bigfont)
							draw_set_halign(fa_left)
							draw_text_oyh(xx - 16, yy + m.ypad * i, q.iconIndex)
						} 
						draw_set_halign(fa_right)
						for (var p = 0; p < array_length(global.key_map[$ q.key]); p++)
						{
							if currentmenu == 6
							{
								switch global.key_map[$ q.key][p]
								{
									case vk_left:
										draw_sprite(spr_tutorialkeyspecial, 6, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case vk_down:
										draw_sprite(spr_tutorialkeyspecial, 4, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case vk_up:
										draw_sprite(spr_tutorialkeyspecial, 3, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case vk_right:
										draw_sprite(spr_tutorialkeyspecial, 5, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case vk_space:
										draw_sprite(spr_tutorialkeyspecial, 2, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case vk_control:
										draw_sprite(spr_tutorialkeyspecial, 1, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case vk_escape:
										draw_sprite(spr_tutorialkeyspecial, 7, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case vk_shift:
										draw_sprite(spr_tutorialkeyspecial, 0, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16) break
									default:
										draw_sprite(spr_tutorialkey, 0, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										draw_set_color(c_black)
										draw_set_font(global.npcfont)
										draw_set_halign(fa_left)
										draw_text(SCREEN_WIDTH - 64 - (42 * p), yy + m.ypad * i - 6 - 16, chr(global.key_map[$ q.key][p]))
									break
								}
							}
							if currentmenu == 8
							{
								switch global.key_map[$ q.key][p]
								{
									case gp_face1:
										draw_sprite(global.buttonSpr, 0, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_face2:
										draw_sprite(global.buttonSpr, 1, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_face3:
										draw_sprite(global.buttonSpr, 2, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_face4:
										draw_sprite(global.buttonSpr, 3, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_shoulderl:
										draw_sprite(global.buttonSpr, 4, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_shoulderr:
										draw_sprite(global.buttonSpr, 5, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_shoulderrb:
										draw_sprite(global.buttonSpr, 6, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_shoulderlb:
										draw_sprite(global.buttonSpr, 7, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_stickl:
										draw_sprite(global.buttonSpr, 8, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_stickr:
										draw_sprite(global.buttonSpr, 9, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_padu:
										draw_sprite(global.buttonSpr, 10, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_padr:
										draw_sprite(global.buttonSpr, 11, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_padd:
										draw_sprite(global.buttonSpr, 12, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_padl:
										draw_sprite(global.buttonSpr, 13, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_start:
										draw_sprite(global.buttonSpr, 14, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case gp_select:
										draw_sprite(global.buttonSpr, 15, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickL_left":
										draw_sprite(global.joystickSpr, 0, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickL_right":
										draw_sprite(global.joystickSpr, 1, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickL_up":
										draw_sprite(global.joystickSpr, 2, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickL_down":
										draw_sprite(global.joystickSpr, 3, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickR_left":
										draw_sprite(global.joystickSpr, 4, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickR_right":
										draw_sprite(global.joystickSpr, 5, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickR_up":
										draw_sprite(global.joystickSpr, 6, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
									case "joystickR_down":
										draw_sprite(global.joystickSpr, 7, SCREEN_WIDTH - 64 - (42 * p) - 8, yy + m.ypad * i + 2 - 16)
										break
								}
							}
						}
						break
				}
			}
	break
}
draw_set_color(c_white)
if changingBind
{
	draw_set_alpha(0.5)
	draw_set_color(c_black)
	draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_set_font(global.bigfont)
	draw_set_halign(fa_center)
	draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, "PRESS ANY KEY")
	draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + string_height("ABCDEFG"), $"GOING BACK IN... {ceil(changingBindTimer / 60)}")
	changingBindTimer--
	if changingBindTimer <= 0 {
		FMODevent_oneshot("event:/Sfx/UI/Pause/Controls/notset")
		changingBind = false
		exit;
	}
}