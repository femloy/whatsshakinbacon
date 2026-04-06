if place_meeting(x, y, obj_player)
{
	if obj_player.key_up_pressed
	{
		selected++
		selected = wrap(selected, 0, array_length(palettes) - 1)
		with obj_player
		{
			with instance_create(x, y, obj_baddiedead)
			{
				sprite_index = spr_mildred_clothes
				usePalette = true
				spr_palette = spr_playerPal
				paletteIndex = other.palette_index
				spr_pattern = global.patternSpr
				patColors = global.characters[other.character].sprites.patColors
				hsp = random_range(-7, 7)
				vsp = random_range(-10, -14)
			}
			palette_index = other.palettes[other.selected].index
			global.patternSpr = other.palettes[other.selected].sprite
			FMODevent_oneshot("event:/Sfx/General/dresser", x, y)
		}
	}
}
textAlpha = approach(textAlpha, place_meeting(x, y, obj_player), 0.1)
indicatorAlpha = approach(indicatorAlpha, indicator, 0.1)