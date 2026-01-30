if active
{
	if textLetter != textLength
	{
		currentChar = dialogStuff[currentDialog].char
		canProgress = false
		textLetter = approach(textLetter, textLength, 1)
		var _pause = 3
		var _longerPauses = ["!", ",", ".", "-", "?"]
		var _stringArr = ds_map_find_value(global.textCache, dialogStuff[currentDialog].text)[0]
		var _lDat = _stringArr[textLetter - 1]
		if array_contains(_longerPauses, _lDat.letter) 
			_pause = 10
		alarm[0] = _pause
		FMODevent_oneshot(dialogCharInfo[currentChar].voice)
	}
	else
	{
		alarm[2] = 60 * 2
		exit;
	}
}