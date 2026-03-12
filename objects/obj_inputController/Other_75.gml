var _ev = async_load[? "event_type"]
var _pad = async_load[? "pad_index"]

switch _ev
{
	case "gamepad discovered":
		if gamepad_get_device_count() < 1
			exit;
		
		show_debug_message($"Found gamepad {_pad} - {gamepad_get_description(_pad)}")
		if global.player_gamepad_current <= 0
			device_found = true
	break
	
	case "gamepad lost":
		if _pad == global.player_gamepad_current
		{
			device_found = false
			global.player_gamepad_current = -4
			show_debug_message($"Lost gamepad {_pad} - {gamepad_get_description(_pad)}")
		}
	break
}