if !variable_global_exists("input_map")
	global.input_map = ds_map_create()
if !variable_global_exists("key_map")
	global.key_map = {}

global.buttonSpr = spr_gamepadbuttons_style1
global.joystickSpr = spr_joystick_style1
global.gamepad_axis_pressed = ds_map_create()
var _axes = [gp_axisrh, gp_axisrv, gp_axislv, gp_axislh];
for (var i = 0; i < array_length(_axes); i++)
{
	ds_map_add(global.gamepad_axis_pressed, _axes[i], false)
}

global.gamepad_deadzones = {}
ini_open(working_directory + "options.ini")
struct_set(global.gamepad_deadzones, "horizontal", ini_read_real("Deadzones", "horiz", 0.1))
struct_set(global.gamepad_deadzones, "vertical", ini_read_real("Deadzones", "verti", 0.2))
struct_set(global.gamepad_deadzones, "press", ini_read_real("Deadzones", "press", 0.4))
ini_close()
input_start()

active = true
device_found = false
global.player_gamepad_current = -4
vibration = 0
vibration_mag = 0
