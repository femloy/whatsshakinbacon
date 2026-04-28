/*saveiconAlpha = 0
saveiconIndex = 0
saveiconTimer = 0*/
depth = obj_screensizer.depth + 50

enum savesystem
{
	idle,
	loading,
	saving,
}
state = savesystem.idle
show_icon = false
icon_alpha = 0
icon_index = 0
icon_max_index = sprite_get_number(spr_littlesaltdance)
ini_str = "";
ini_open("saveData.ini")
ini_str_options = ini_close()