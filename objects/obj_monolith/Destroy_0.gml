if ds_list_find_index(global.saveroom, id) == -1
{
	ds_list_add(global.saveroom, id)
	FMODevent_oneshot("event:/Sfx/General/Enemy/Monolith/cupdead", x, y)
	for (var i = 0; i < sprite_get_number(spr_mugmonolith_dead); i++)
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_baddiedead)
		{
			sprite_index = spr_mugmonolith_dead
			hsp = random_range(3, 5) * sign(x - obj_player.x)
			image_xscale = other.image_xscale
			image_speed = 0
			image_index = i
		}
	}
	
	repeat (8)
	{
		create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5)
		create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5)
	}
	
	instance_create(x, y, obj_goodmourning)
	instance_create(x, y, obj_whiteflash)
	obj_screensizer.bleedIntensity = 1
	scr_sleep(50)
	global.escape.active = true
	switch global.level
	{
		default:
			global.escape.timer = (60 * 60 * 3) // 3:00
			break
		case "forest":
			with obj_roomname
			{
				text = "the first of many"
				show = true
				alarm[0] = 60 * 3
			}
			global.escape.timer = (60 * 60 * 3) + (60 * 30) // 3:30
			break
		case "hotel":
			with obj_roomname
			{
				text = "the end"
				show = true
				alarm[0] = 60 * 3
			}
			global.escape.timer = (60 * 60 * 2) + (60 * 07) // 2:07
			break
	}
	obj_hud.bar.chunkMax = global.escape.timer
	global.combo.amt += 1
	obj_player.supertaunt++
	global.combo.timer = 60
}