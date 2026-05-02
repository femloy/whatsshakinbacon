var _rm = hotel_receptionentrance
var _dr = "A"
var q = saveFiles[selectedFile]
with obj_player 
{
	generalReset()
	targetRoom = _rm
	door = _dr
	movespeed = 0
	vsp = 0
	hsp = 0
	state = states.enterdoor
	palette_index = q.palette
	global.patternSpr = q.patternSpr
}
obj_savesystem.ini_str = global.saveFile
async_load_game()

global.level = noone
global.resetRoom = _rm
if !instance_exists(obj_fadeout)
	instance_create(0, 0, obj_fadeout)