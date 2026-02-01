if !global.option_hud
	exit;
if totemAlpha > 0
{
	draw_set_alpha(totemAlpha)
	draw_sprite(spr_totems, totemIndex, 96, SCREEN_HEIGHT - 92)
	draw_set_font(global.creditsfont)
	
	ini_open(global.saveFile)
	draw_set_halign(fa_center)
	var _countTotems = (ini_read_real("General", "Totem0", false) == true) + (ini_read_real("General", "Totem1", false) == true) + (ini_read_real("General", "Totem2", false) == true)
	draw_text_oyh(96, SCREEN_HEIGHT - 164, $"[wave]{_countTotems}/3!")
	ini_close()
	
	draw_set_alpha(1)
}