if (async_load[? "event_type"] == "gamepad discovered")
{
    var _pad = async_load[? "pad_index"];
    gamepad_set_axis_deadzone(_pad, 0.2);
    array_push(connectedGamepads, _pad);
	global.gamepadConnected = true
	global.gamepadCurrent = connectedGamepads[0]
	show_debug_message($"Gamepad Connected at Pad {_pad}")
}
else if (async_load[? "event_type"] == "gamepad lost")
{
    var _pad = async_load[? "pad_index"];
    var _index = array_get_index(connectedGamepads, _pad);
    array_delete(connectedGamepads, _index, 1);
	show_debug_message($"Gamepad Disonnected at Pad {_pad}")
	global.gamepadConnected = false
	global.gamepadCurrent = -2
}