init_input()
global.gamepadConnected = false
global.gamepadCurrent = -2

global.gamepadDeadzones = {}
ini_open(working_directory + "options.ini")
global.gamepadDeadzones.horizontal = ini_read_real("Deadzones", "horiz", 0.1)
global.gamepadDeadzones.vertical = ini_read_real("Deadzones", "verti", 0.2)
global.gamepadDeadzones.general = ini_read_real("Deadzones", "general", 0.4)
global.gamepadDeadzones.press = ini_read_real("Deadzones", "press", 0.4)
global.buttonSpr = spr_gamepadbuttons_style1
global.joystickSpr = spr_joystick_style2
ini_close()

horizontalStickPressed = false
verticalStickPressed = false
horizontalStickPressedR = false
verticalStickPressedR = false



gamepad_check_any = function(_device)
{
	for (var i = gp_face1; i < gp_axisrv; i++)
	{
		if gamepad_button_check(_device, i)
		{
			return true;
		} 
	}
	return false;
}
connectedGamepads = []
