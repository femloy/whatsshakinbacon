depth = 20
palettes = []
selected = 0
textAlpha = 0
indicatorAlpha = 0
indicator = false

//Add Palettes
addPalette = function(_name, _desc, _index, _unlocked = true, _pattern = global.PlayerCharacters[obj_player.character].patternSpr)
{
	var q =	{ pName: _name, desc: _desc, index: _index, sprite: _pattern }
	if _unlocked
	{
		array_push(palettes, q)
		return q
	}
}
ini_open(global.saveFile)

addPalette("Retail Wears", "Complimentary!", 1, true)
addPalette("Mint Wears", "Unlocked by finishing the tutorial", 10, ini_read_real("Palette", "mintwears", false))
addPalette("Red Wears", "Unlocked by ???", 2, ini_read_real("Palette", "redwears", false))
addPalette("Orange Wears", "Unlocked by ???", 3, ini_read_real("Palette", "orangewears", false))
addPalette("Blue Wears", "Unlocked by ???", 4, ini_read_real("Palette", "bluewears", false))
addPalette("Yellow Wears", "Unlocked by ???", 5, false)
addPalette("Teal Wears", "Unlocked by ???", 6, false)
addPalette("Purple Wears", "Unlocked by ???", 7, false)
addPalette("Pristine Wears", "Unlocked by ???", 8, false)
addPalette("Darker Wears", "Unlocked by ???", 9, false)

ini_close()
for (var i = 0; i < array_length(palettes); i++)
{
	var q = palettes[i].index
	var p = palettes[i].sprite
	if q == obj_player.palIndex && p == global.patternSpr
	{
		selected = i
		break
	}
}
create_uparrow()