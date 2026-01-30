if active
{
	draw_set_font(global.npcfont)
	draw_set_alpha(1)
	draw_sprite(spr_dialogbox, 0, 64, 64)
	draw_set_halign(fa_left)
	draw_set_alpha(1)
	draw_set_color(dialogCharInfo[currentChar].color)
	draw_text_oyh(64 + 16, 64 + 14, dialogStuff[currentDialog].text, 800, textLetter)
	draw_set_color(c_white)
	for (var i = 0; i < array_length(portraits); i++)
	{
		var q = portraits[i]
		q.portraitIndex += 0.35
		q.portraitTalking = q.char == dialogStuff[currentDialog].char
		draw_sprite_ext(q.portrait, q.portraitIndex, q.x, q.y, q.anchor == fa_right ? -5 : 5, 5, 0, q.portraitTalking ? c_white : c_gray, 1)
	}
}