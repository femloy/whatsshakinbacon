if canSupertaunt && visible
	create_particleStatic(choose(spr_supertaunteffect1, spr_supertaunteffect2, spr_supertaunteffect3, spr_supertaunteffect4), x + irandom_range(-50, 50), y + irandom_range(50, -50), 1, -5)
alarm[1] = irandom_range(15, 25)