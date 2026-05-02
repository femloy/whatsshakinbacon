event_inherited();

ini_open_from_string(obj_savesystem.ini_str)

if ini_read_string("tutorial", "Rank", "NONE") != "NONE"
{
	if ini_read_real("Cutscenes", "TutorialBlock", false) == false
	{
		alarm[0] = 60 * 1.5
		ini_write_real("Cutscenes", "TutorialBlock", true)
	}
	else
	{
		instance_destroy()
	}
}

obj_savesystem.ini_str = ini_close()