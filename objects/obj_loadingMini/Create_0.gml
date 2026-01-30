groups = ["Wayback_group"];
textures = []

for (var i = 0; i < array_length(groups); i++) {
	array_push(textures, texturegroup_get_textures(groups[i]))
}
alarm[0] = 20;
image_speed = 0.35;
depth = -700