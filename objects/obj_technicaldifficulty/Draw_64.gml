if showTechnical
{
	draw_sprite(lang_get_asset("spr_pleasestandbyBackground"), 0, 0, 0)
	draw_sprite(spr_pleasestandby, technicalIndex, 0, 0)
	pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false)
	draw_sprite_ext(spr_pleasestandby, technicalIndex, 0, 0, 1, 1, image_angle, image_blend, image_alpha)
	shader_reset()
	pattern_draw(spr_pleasestandby, technicalIndex, 0, 0, 1, 1, image_angle, image_blend, image_alpha, global.patternSpr, global.PlayerCharacters[obj_player.character].patColors)

}
if showStatic
	draw_sprite(spr_tvstatic, staticIndex, 0, 0)