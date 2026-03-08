
global.patternColors = shader_get_sampler_index(shd_pattern, "tex_setColors")
global.patternUVs = shader_get_uniform(shd_pattern, "tex_colorsUV")
global.patternTexel = shader_get_uniform(shd_pattern, "tex_height") 
function pattern_draw(_sprite, _index, _x, _y, _xscale, _yscale, _rot, _col, _alpha, _pattern = global.patternSpr, _patternColors = spr_playerPatColors, _sprPalette = obj_player.spr_palette, _palIndex = obj_player.palIndex)
{
	if _pattern != -1
	{
		if _xscale == 0 || _yscale == 0
			exit;
		// fall back if theres really nothing to be drawn
		var _surf = surface_create(sprite_get_width(_sprite), sprite_get_height(_sprite))
		
		surface_set_target(_surf);
			draw_clear_alpha(c_black, 0);
			shader_reset()
			shader_set(shd_pattern) // shader so the only thing that gets outputted is the color u want the pattern to draw on
			var q = sprite_get_texture(_patternColors, 0)
			var p = sprite_get_uvs(_patternColors, 0)
			var s = texture_get_texel_height(q)
			texture_set_stage(global.patternColors, q)
			shader_set_uniform_f(global.patternUVs, p[0], p[1], p[2], p[3])
			shader_set_uniform_f(global.patternTexel, s)
			draw_sprite_ext(_sprite, _index, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite), 1, 1, _rot * _xscale, c_white, 1) // draws the sprite
			shader_reset()
		
			gpu_set_blendmode(bm_min)
			pal_swap_set(_sprPalette, _palIndex, false)
			draw_sprite_tiled_ext(_pattern, 0, 0, 0, _xscale, 1, c_white, 1) // pattern
			shader_reset()
			reset_blendmmode()
		surface_reset_target()
		
		draw_surface_ext(_surf, _x - sprite_get_xoffset(_sprite) * _xscale, _y - sprite_get_yoffset(_sprite) * _yscale, _xscale, _yscale, 0, _col, _alpha)
		surface_free(_surf)
	}
}