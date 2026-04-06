if (!ds_list_empty(afterimages))
{
	for (var i = 0; i < ds_list_size(afterimages); i++)
	{
		var q = ds_list_find_value(afterimages, i)
		with q
		{
			var _shd = false
			var _blend = c_white
			var _drawPattern = false
			switch type
			{
				case afterimagetype.normal:
					_blend = image_blend
					break
				case afterimagetype.fade:
					pal_swap_set(obj_player.sprites.player_pal, obj_player.palette_index, false)
					_blend = image_blend
					_shd = true
					_drawPattern = true
					break
				case afterimagetype.buzzsaw:
					var _col = global.characters[obj_player.character].mainColors.main
					var _col2 = global.characters[obj_player.character].mainColors.secon
					var col = [ color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255 ]
					var col2 = [ color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255 ]
					shader_set(shd_fullshade)
					shader_set_uniform_f_array(other.uniformLight, col)
					shader_set_uniform_f_array(other.uniformDark, col2)
					_shd = true
					break
				case afterimagetype.mach:
					var _col = image_blend
					col = [ color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255 ]
					var _col2 = c_black
					col2 = [ color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255 ]
					shader_set(shd_fullshade)
					shader_set_uniform_f_array(other.uniformLight, col)
					shader_set_uniform_f_array(other.uniformDark, col2)
					_shd = true
					break	
				case afterimagetype.selectcolor:
					var _col = selectcolor
					var _col2 = selectcolor2
					col = [ color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255 ]
					col2 = [ color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255 ]
					shader_set(shd_fullshade)
					shader_set_uniform_f_array(other.uniformLight, col)
					shader_set_uniform_f_array(other.uniformDark, col2)
					_shd = true
					break
				case afterimagetype.milton:
					var _col = #6060FF
					var _col2 = #2E3192
					var col = [ color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255 ]
					var col2 = [ color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255 ]
					shader_set(shd_fullshade)
					shader_set_uniform_f_array(other.uniformLight, col)
					shader_set_uniform_f_array(other.uniformDark, col2)
					_shd = true
					break
				case afterimagetype.attack:
					break
				case afterimagetype.blue:
				break
			}
			if visible == true
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, _blend, image_alpha * alpha * fadeoutAlpha)
			if _shd
				shader_reset()
			if _drawPattern
			{
				pattern_draw(sprite_index, image_index, x, y, image_xscale, 1, 0, _blend, image_alpha * alpha, global.patternSpr, obj_player.sprites.palette_colors, obj_player.sprites.player_pal, obj_player.palette_index)
			}
			reset_blendmmode()
		}
	}
}
