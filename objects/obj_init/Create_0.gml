draw_flush()
lang_init()

textures = []
textures_to_load = ["playerGroup", "hudGroupp"];

for (var i = 0; i < array_length(textures_to_load); i++) {
	var _tex = texturegroup_get_textures(textures_to_load[i])
	array_push(textures, _tex)
}

texturesMax = array_length(textures)
alarm[0] = 20;