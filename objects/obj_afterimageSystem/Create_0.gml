afterimages = ds_list_create()
enum afterimagetype
{
	normal,
	fade,
	attack,
	blue,
	buzzsaw,
	milton,
	selectcolor,
	mach,
}
depth = 45
uniformLight = shader_get_uniform(shd_fullshade, "lightest");
uniformDark = shader_get_uniform(shd_fullshade, "darkest");
blink = true
alarm[0] = 3