if global.cutscenes.miltonIntro
	instance_destroy()
trigger = function()
{
	instance_destroy()
	instance_create(x, y, obj_miltonCutscene)
	
	ini_open(global.saveFile)
	ini_write_real("Cutscenes", "miltonIntro", true)
	global.cutscenes.miltonIntro = true
	ini_close()
}