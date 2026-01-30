if ds_list_find_index(global.saveroom, id) == -1
{
	ds_list_add(global.saveroom, id)
	instance_destroy()
	shake_camera(3, 3)
	FMODevent_oneshot("event:/Sfx/General/Enemy/killenemy", x, y)
	with instance_create(x, y, obj_baddiedead)
	{
		sprite_index = spr_milton_waybacklook_dead
		usePalette = true
		spr_palette = spr_miltonPal
		paletteIndex = 0
		spr_pattern = spr_playerPat_miltonTears
		patColors = spr_miltonPatColors
	}
	repeat (3)
	{
		create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5)
		create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5)
	}
	create_particleStatic(spr_genericpoofeffect, x, y, 1, -2)
	create_particleStatic(spr_bangeffect, x, y, 1)
	var _dialog = instance_create(x, y - 32, obj_smallDialog)
	with _dialog
	{
		target = obj_player
		addDialog(dialogChars.mildred, "Good riddance...")
		draw_set_font(global.npcfont)
		draw_set_halign(fa_center)
		global.textSize = 0.5
		draw_text_oyh(x, y, dialogStuff[currentDialog].text, 800)
		global.textSize = 1
		var _stringArr = ds_map_find_value(global.textCache, dialogStuff[currentDialog].text)[0]
		var _stringArrLength = array_length(_stringArr)
		textLength = _stringArrLength
		textLetter = 0
		active = true
		alarm[0] = 45
	}
}