depth = 20
palettes = []
selected = 0
textAlpha = 0
indicatorAlpha = 0
indicator = false

//Add Palettes
addPalette = function(_name, _desc, _index, _unlocked = true, _pattern = spr_playerPat_threads)
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
addPalette("Red Wears", "Unlocked by ???", 2, true)
addPalette("Orange Wears", "Unlocked by ???", 3, true)
addPalette("Blue Wears", "Unlocked by ???", 4, true)
addPalette("Yellow Wears", "Unlocked by ???", 5, true)
addPalette("Teal Wears", "Unlocked by ???", 6, true)
addPalette("Purple Wears", "Unlocked by ???", 7, true)
addPalette("Pristine Wears", "Unlocked by ???", 8, true)
addPalette("Darker Wears", "Unlocked by ???", 9, true)
addPalette("Magic Wears", "Unlocked by ???", 1, true, spr_pattern_genie)
addPalette("Scarf Wears", "Unlocked by ???", 1, true, spr_pattern_scarf)
addPalette("Heartbroken Wears", "Unlocked by ???", 1, true, spr_pattern_heartbreak)
addPalette("Lovely Wears", "Unlocked by ???", 1, true, spr_pattern_love)

ini_close()
for (var i = 0; i < array_length(palettes); i++)
{
	var q = palettes[i].index
	var p = palettes[i].sprite
	if q == obj_player.palette_index && p == global.patternSpr
	{
		selected = i
		break
	}
}
create_uparrow()