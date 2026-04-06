pal_swap_set(obj_player.sprites.player_pal, obj_player.palette_index, false)
draw_self()
shader_reset()
pattern_draw(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha, global.patternSpr, spr_playerPatColors)