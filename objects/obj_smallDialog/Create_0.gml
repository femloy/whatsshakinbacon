addDialog = function(_char, _dialog, _func = function(){})
{
	var q =
	{
		char: _char,
		text: _dialog,
		func: _func
	}
	array_push(dialogStuff, q)
}
dialogCharInfo = []
dialogCharInfo[dialogChars.mildred] = 
{
	voice: "event:/Sfx/Dialog/mildredSpeak",
	color: c_lime,
}
dialogStuff = []
currentDialog = 0
active = false
textVisual = ""
textLetter = 1
canProgress = true
currentChar = characters.mildred
textLength = 1
target = noone
fadeout = false
fade = 0