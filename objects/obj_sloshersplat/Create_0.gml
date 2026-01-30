tiles = [];
layers = layer_get_all();

for (var i = 0; i < array_length(layers); i++) {
	var tileId = layer_tilemap_get_id(layers[i]);
	if (tileId != -1) {
		array_push(tiles, tileId);
	}
}
tiles = array_reverse(tiles)
tileSurf = surface_create(sprite_width, sprite_height);
image_speed = 0.35
image_angle = irandom_range(0, 360)
depth = 80
blend = #ff8986