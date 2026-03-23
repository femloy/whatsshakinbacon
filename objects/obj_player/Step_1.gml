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

if sprites != global.PlayerCharacters[character].sprites.player
{
	sprites = global.PlayerCharacters[character].sprites.player
	spr_palette = global.PlayerCharacters[character].playerPal
	global.patternSpr = global.PlayerCharacters[character].patternSpr
	if character == characters.milton
		palIndex = 1 // makes him Work.
	ini_open(global.saveFile)
	if ini_read_string("Game", "Pattern", "spr_playerPat_threads") != -1 && character == characters.mildred // change/remove when miton has stuff Tu!
	{
		global.patternSpr = asset_get_index(ini_read_string("Game", "Pattern", "spr_playerPat_threads"))
		aalIndex = ini_read_real("Game", "Palette", 1)
	}
	ini_close()
}