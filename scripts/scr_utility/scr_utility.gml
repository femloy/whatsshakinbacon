function scr_savelevel()
{
	ini_open(global.saveFile)

	var _rankString = "D"
	if global.collect >= global.Crank
		_rankString = "C"
	if global.collect >= global.Brank
		_rankString = "B"
	if global.collect >= global.Arank
		_rankString = "A"
	if global.collect >= global.Srank
		_rankString = "S"
	if scr_Prank()
		_rankString = "P"
	if ini_read_real(global.level, "Highscore", 0) < global.collect
	{
		ini_write_real(global.level, "Highscore", global.collect)
		ini_write_string(global.level, "Rank", _rankString)
		ini_write_real(global.level, "Toppin1", global.toppins.bean)
		ini_write_real(global.level, "Toppin2", global.toppins.cup)
		ini_write_real(global.level, "Toppin3", global.toppins.lime)
		ini_write_real(global.level, "Toppin4", global.toppins.bag)
		ini_write_real(global.level, "Toppin5", global.toppins.orange)
		ini_write_real(global.level, "Treasure", global.treasure)
		ini_write_real(global.level, "Secrets", global.secretCount)
	}
	
	obj_savesystem.saveiconTimer = 30
	ini_close()
}

function create_uparrow() {
	instance_create(x, y, obj_uparrow).objId = id
}

function load_textures(_groups)
{
	with instance_create(0, 0, obj_loadingMini)
	{
		groups = _groups
		textures = []
			
		for (var i = 0; i < array_length(groups); i++) {
			array_push(textures, texturegroup_get_textures(groups[i]))
		}
		texturesMax = array_length(textures)
	}
}

function unload_textures(_textures)
{
	if _textures != noone
	{
		var _rep = array_length(_textures)
		repeat _rep
		{
			if (array_length(_textures)) 
			{
				var group = _textures[0]
				for (var i = 0; i < array_length(group); i++)
				{
					if texture_is_ready(group[i])
					{
						show_debug_message($"unloaded texture page {group[i]}")
						texture_flush(group[i])
					}
				}
				array_shift(_textures)
			}
		}
		
	}
}

function animation_end() {
	return image_index + image_speed * sprite_get_speed(sprite_index)  >=  image_number;
}

function shake_camera(_intensity, _time)
{
	if is_undefined(_time)
		_time = _intensity
	obj_camera.cameraShakeTimer = _time / 60
	obj_camera.cameraShake = _intensity
}

function tv_anim(_sprite, _timer = 0)
{
	with obj_hud.tv
	{
		if expressionSprite != _sprite
		{
			switchindex = 0
			state = states.move
			expressionSprite = _sprite
			expressionTimer = _timer
		}
	}
}

function instance_create (_x, _y, _obj, _struct = {})
{
	return instance_create_depth(_x, _y, 0, _obj, _struct)
}

function distance_to_pos(x1, y1, x2, y2, width, height)
{
	return point_distance(x1, 0, x2, 0) <= width && point_distance(0, y1, 0, y2 <= height)
}

function scr_cutoff()
{
	for (var _x = 0; _x < abs((sprite_width / 32)); _x++)
	{
		instance_create(x + (_x * 32) + 32, y, obj_cutoff, {image_angle: 180})
		instance_create(x + (_x * 32), y + sprite_height, obj_cutoff)
	}
	for (var _y = 0; _y < abs((sprite_height / 32)); _y++)
	{
		instance_create(x + sprite_width, y + (_y * 32) + 32, obj_cutoff, {image_angle: 90})
		instance_create(x, y + (_y * 32), obj_cutoff, {image_angle: -90})
	}
}

function save_to_ini(_section, _key, _val, _ini = working_directory + "options.ini") 
{
	ini_open(_ini)
	if is_string(_val)
	{
		if ini_read_string(_section, _key, _val) == _val
			return false;
		ini_write_string(_section, _key, _val)
	}
	else
	{
		if ini_read_real(_section, _key, _val) == _val
			return false;
		ini_write_real(_section, _key, _val)
	}
	ini_close()
	return true;
}

function create_smalltext(_text, _x = x, _y = y)
{
	instance_create(_x, _y, obj_smalltext).text = _text
}

function in_camera(_left = bbox_left, _right = bbox_right, _bottom = bbox_bottom, _top = bbox_top) {
	var camx = camera_get_view_x(view_camera[0])
	var camy = camera_get_view_y(view_camera[0])
	var camw = camera_get_view_width(view_camera[0])
	var camh = camera_get_view_height(view_camera[0])
	return _left < camx + camw && _right > camx && _top < camy + camh && _bottom > camy
}

function tile_delete(_x, _y) {
	var layers = layer_get_all();
	for (var i = 0; i < array_length(layers); i++) {
		var lay = layers[i];
		var layer_name = layer_get_name(lay);
		if layer_name != "Tiles_BG1" && layer_name != "Tiles_BG" && layer_name != "Tiles_BG2" && layer_name != "Tiles_BG3" {
			var ID = layer_get_id(layer_name)
			var tilemapID = layer_tilemap_get_id(ID)
			var tiledata = tilemap_get_at_pixel(tilemapID, _x, _y)
			tile_set_empty(tiledata)
			tilemap_set_at_pixel(tilemapID, 0, _x, _y)
		}
	}
}

function escape_background(_normal, _escape) {
	var layers = layer_get_all();
	for (var i = 0; i < array_length(layers); i++) {
		var lay = layers [i];
		var layer_name = layer_get_name(lay);
		var ID = layer_get_id(layer_name)
		var BGID = layer_background_get_id(ID)
		var BGSPR = layer_background_get_sprite(BGID)
		if BGSPR == _normal && global.escape.active
		layer_background_sprite(BGID, _escape)
		else if BGSPR == _escape && !global.escape.active
		layer_background_sprite(BGID, _normal)
	}
}

function scr_transfotip(_text, _font = global.creditsfont) {
	if instance_exists(obj_transfotip)
		instance_destroy(obj_transfotip)
	var q = instance_create(x, y, obj_transfotip)
	with q
	{
		text = _text
		font = _font
	}
	return q
}

function timeString(_variable)
{
	_variable = string_format(_variable, 1, 3);
	var _ms = string_digits(frac(_variable))
	_ms = string_copy(_ms, 2, 3)
	
	var _realSecond = floor(_variable)
	
	var _s = _realSecond
	_s = wrap(_s, 0, 59)
	if _s < 10
		_s = string_concat("0", _s)
	
	var _m = floor(_realSecond / 60)
	_m = wrap(_m, 0, 59)
	if _m < 10
		_m = string_concat("0", _m)
		
	var _h = floor(_realSecond / (60 * 60))
	if _h < 10
		_h = string_concat("0", _h)
	return $"{_h}:{_m}:{_s}.{_ms}"
}