enum dialogChars
{
	mildred,
	milton
}
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
	portraitInfo:
	{
		char: dialogChars.mildred, 
		x: 160,
		y: 384,
		anchor: fa_left,
		portrait: spr_player_idle,
		portraitIndex: 0,
		portraitTalking: true,
	}
}
dialogCharInfo[dialogChars.milton] = 
{
	voice: "event:/Sfx/Dialog/miltonSpeak",
	color: c_red,
	portraitInfo:
	{
		char: dialogChars.milton, 
		x: 768,
		y: 416,
		anchor: fa_right,
		portrait: spr_milton_idle,
		portraitIndex: 0,
		portraitTalking: true,
	}
}
portraits = []
portraitsExist = []
add_portrait = function(_character)
{
	var _info = dialogCharInfo[_character].portraitInfo
	array_push(portraits, _info)
}
dialogStuff = []
currentDialog = 0
active = false
textVisual = ""
textLetter = 1
canProgress = true
currentChar = characters.mildred
textLength = 1