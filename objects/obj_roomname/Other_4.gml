var _text = ""
switch room
{
	case wayback_1:
	case wayback_7:
	case wayback_9:
	case tutorial_1:
	case hotel_receptionentrance:
		_text  = lang_get_phrase($"roomname_{room_get_name(room)}")
		break
	case city_1:
		_text = "redemption"
		break
	case city_3:
		_text = "beware of drugs"
		break
}
if _text != "" && ds_list_find_index(global.saveroom, $"roomname: {room_get_name(room)}") == -1
{
	ds_list_add(global.saveroom, $"roomname: {room_get_name(room)}")
	text = _text
	show = true
	alarm[0] = 60 * 3
}