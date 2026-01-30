instance_create(x, y, obj_baddiedead).sprite_index = sprite_index
//scr_transfotip(lang_get_phrase("tip_snowball"))

with (obj_player)
    state = states.snowball

ds_list_add(global.saveroom, id)
instance_destroy()