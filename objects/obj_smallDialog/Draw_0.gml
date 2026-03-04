if active
{
	draw_set_font(global.npcfont)
	draw_set_halign(fa_left)
	draw_set_alpha(fade)
	draw_set_color(dialogCharInfo[currentChar].color)
	global.textSize = 0.8
	draw_text_oyh(target.x, target.y - 64, dialogStuff[currentDialog].text, string_width(dialogStuff[currentDialog].text), textLetter)
	global.textSize = 1
	draw_set_color(c_white)
	draw_set_alpha(1)
}