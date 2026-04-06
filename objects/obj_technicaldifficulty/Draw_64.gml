if showTechnical
{
	draw_sprite(lang_get_asset("spr_pleasestandbyBackground"), 0, 0, 0)
	draw_sprite(spr_pleasestandby, technicalIndex, 0, 0)
	pal_swap_set(obj_player.sprites.player_pal, obj_player.palette_index, false)
	draw_sprite_ext(spr_pleasestandby, technicalIndex, 0, 0, 1, 1, image_angle, image_blend, image_alpha)
	shader_reset()
	pattern_draw(spr_pleasestandby, technicalIndex, 0, 0, 1, 1, image_angle, image_blend, image_alpha, global.patternSpr, obj_player.sprites.palette_colors)

}
if showStatic
	draw_sprite(spr_tvstatic, staticIndex, 0, 0)