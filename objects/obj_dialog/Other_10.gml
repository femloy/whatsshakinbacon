if canProgress
{
	FMODevent_oneshot("event:/Sfx/General/Level/Doodles/doodlejump", x, y)
	dialogStuff[currentDialog].func()
	currentDialog++
	if currentDialog > array_length(dialogStuff) - 1 
	{
		instance_destroy()
		exit;
	}
	draw_set_font(global.npcfont)
	draw_set_halign(fa_left)
	draw_text_oyh(64 + 16, 64 + 14, dialogStuff[currentDialog].text, 800)
	var _stringArr = ds_map_find_value(global.textCache, dialogStuff[currentDialog].text)[0]
	var _stringArrLength = array_length(_stringArr)
	textLength = _stringArrLength
	textLetter = 0
	alarm[0] = 2
}
else {
	alarm[0] = -1
	currentChar = dialogStuff[currentDialog].char
	canProgress = true
	textLetter = textLength
	FMODevent_oneshot(dialogCharInfo[currentChar].voice)
}