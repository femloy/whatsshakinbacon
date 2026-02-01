if ds_list_find_index(global.saveroom, id) == -1
{
	ds_list_add(global.saveroom, id)
	switch image_index
	{
		default:
			with instance_create(x, y, obj_baddiedead)
			{
				sprite_index = other.sprite_index
				image_speed = 0
				image_index = other.image_index + 1
			}
		break
		case 5:
			with instance_create(x, y, obj_baddiedead)
			{
				sprite_index = other.sprite_index
				image_speed = 0
				image_index = other.image_index + choose(1, 2)
			}
		break
		case 0:
			with instance_create(x, y, obj_baddiedead)
			{
				sprite_index = other.sprite_index
				image_speed = 0
				image_index = 1
			}
			with instance_create(x, y, obj_baddiedead)
			{
				sprite_index = other.sprite_index
				image_speed = 0
				image_index = 2
			}
		break
	}
	create_particleStatic(spr_bangeffect, x + 16, y + 16, 1, 1)
	FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y)
	FMODevent_oneshot("event:/Sfx/General/Beaker Backyard/trash", x, y)
	push_achievement(achievements.waybackFodder)
}