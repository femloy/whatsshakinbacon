global.language = "english"
global.langMapWord = ds_map_create()
global.langMapArt = ds_map_create()

function get_file_extension(filename) 
{
    var dot_pos = string_last_pos(".", filename);
    if (dot_pos > 0)
        return string_lower(string_copy(filename, dot_pos + 1, string_length(filename) - dot_pos));
        
    return ""; // No extension found
}

function lang_init()
{
	var _generalPath = "lang/"
	var _textFile = $"{_generalPath}/{global.language}/text.txt"
	var _json = json_parse(loadString(_textFile))
	var _jsonNames = variable_struct_get_names(_json)
	for (var i = 0; i < array_length(_jsonNames); i++)
	{
		ds_map_add(global.langMapWord, _jsonNames[i], variable_struct_get(_json, _jsonNames[i]))
	}
	
	var _textFile = $"{_generalPath}/{global.language}/art.txt"
	var _json = json_parse(loadString(_textFile))
	var _jsonNames = variable_struct_get_names(_json)
	for (var i = 0; i < array_length(_jsonNames); i++)
	{
		var q = variable_struct_get(_json, _jsonNames[i])
		var _spritePath = $"{_generalPath}/{global.language}/{q.path}"
		
		if get_file_extension(_spritePath) == "png"
			ds_map_add(global.langMapArt, _jsonNames[i], sprite_add(_spritePath, 0, false, false, q.xorigin, q.yorigin))
		else
			ds_map_add(global.langMapArt, _jsonNames[i], sprite_add_gif(_spritePath, q.xorigin, q.yorigin))
	}
}

function lang_get_phrase(_key)
{
	if ds_map_exists(global.langMapWord, _key)
		return (ds_map_find_value(global.langMapWord, _key))
	else
		return (_key)
}

function lang_get_asset(_key)
{
	if ds_map_exists(global.langMapArt, _key)
		return (ds_map_find_value(global.langMapArt, _key))
	else
		return -1
}