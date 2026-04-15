texturesMax = 0;
draw_flush()
draw_texture_flush();
groups = ["Default", "Player_group", "Effect_group", "Potable_group", "Pause_group", "Secret_group"];
textures = []

for (var i = 0; i < array_length(groups); i++) {
	array_push(textures, texturegroup_get_textures(groups[i]))
}

lang_init()
texturesMax = array_length(textures)
alarm[0] = 20;
image_speed = 0.35;
blackAlpha = 0
fadeOut = false
global.level_loaded_pages = noone

show_debug_overlay(true)