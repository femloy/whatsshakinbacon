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
}
if _text != ""
{
	text = _text
	show = true
	alarm[0] = 60 * 3
}