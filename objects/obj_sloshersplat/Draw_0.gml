if !surface_exists(tileSurf)
	tileSurf = surface_create(sprite_width, sprite_height);
var _tile_count = array_length(tiles);
var p_x = sprite_width / 2
var p_y = sprite_height / 2

surface_set_target(tileSurf);
	draw_clear_alpha(c_black, 0)

	draw_set_alpha(1)
	for (var i = 0; i < _tile_count; i++) 
    	draw_tilemap(tiles[i], -x + p_x, -y + p_x);
	shader_reset()
	gpu_set_blendmode(bm_subtract)
	draw_sprite_ext(sprite_index, image_index, p_x, p_y, 1, 1, 0, c_white, 1)
	gpu_set_blendmode(bm_normal)

surface_reset_target();
draw_surface_ext(tileSurf, x - p_x, y - p_y, 1, 1, 0, blend, 1)