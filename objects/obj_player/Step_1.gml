if key_jump_pressed
	jumpBuffer = 15
if key_grab_pressed
	slapBuffer = 15
if key_down_pressed
	downBuffer = 15

jumpBuffer = approach(jumpBuffer, 0, 1)
slapBuffer = approach(slapBuffer, 0, 1)
downBuffer = approach(downBuffer, 0, 1)

playerSounds()

isMildred = character == characters.mildred
isMilton = character == characters.milton

global.characters[character].mainColors = character_get_color(sprites.player_pal, palette_index)

if supertaunt >= 10 && !canSupertaunt
{
	ini_open(global.saveFile)
	if ini_read_real("Game", "supertauntTip", false) != true
	{
		ini_write_real("Game", "supertauntTip", true)
		scr_transfotip(lang_get_phrase("tip_supertaunt"))
	}
	ini_close()
	canSupertaunt = true
	flash = true
	FMODevent_oneshot("event:/Sfx/Player/gotsupertaunt", x, y)
}
else if supertaunt < 10 && canSupertaunt
	canSupertaunt = false