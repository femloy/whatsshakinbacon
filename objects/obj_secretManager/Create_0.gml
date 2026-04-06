tiles = [];
alarm[0] = 10
layers = layer_get_all();

for (var i = 0; i < array_length(layers); i++) {
	var tileId = layer_tilemap_get_id(layers[i]);
	if (tileId != -1) {
		array_push(tiles, tileId);
	}
}
tiles = array_reverse(tiles)

patternPos = 0
patternAlpha = 0
fadein = true
stateTimer = 60 * 1.5
patternIndex = irandom_range(0, sprite_get_number(spr_tileDoodles))
tileSurf = surface_create(SCREEN_WIDTH, SCREEN_HEIGHT);
depth = 80

need_mask_update = false;
global.secretCount++
text_clear(lang_get_phrase("secret_get"))
scr_transfotip(lang_get_phrase("secret_get"), global.ransomfont)

if (array_length(tiles) == 0) {
	instance_destroy();
}
