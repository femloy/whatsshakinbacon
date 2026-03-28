if ds_list_find_index(global.saveroom, id) == -1
{
	ds_list_add(global.saveroom, id)
		with instance_create(x + 16, y + 16, obj_baddiedead)
		{
			sprite_index = spr_onewayman_dead
			image_xscale = other.image_xscale
		}
	FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y)
}
instance_destroy(coll)