bgx++
get_input()
if menu == 0
{
	var m = key_down_pressed - key_up_pressed
	if m != 0
	{
		selected += m
		selected = clamp(selected, 0, array_length(menus[currentmenu]) - 1)
	}
	if key_jump_pressed
	{
		menus[currentmenu][selected][2]()
	}
}
else 
{ 
	if key_grab_pressed
	{
		menu = 0
		selected  = 0
	}
	if (keyboard_check_pressed(vk_anykey)) 
	{
		if (!keyboard_check_pressed(vk_enter) && 
		!keyboard_check_pressed(vk_shift) && 
		!key_jump_pressed && 
		!keyboard_check_pressed(vk_tab)) 
		{
			draw_set_font(global.bigfont)
			textInput = keyboard_string
		} 
		if keyboard_check(vk_control) && keyboard_check_pressed(ord("v"))
			textInput = clipboard_get_text()
		if (keyboard_check_pressed(vk_enter) || key_jump_pressed)
		{
			if menu == 1
			{
				connectIP = textInput
				menu = 2
				keyboard_string = ""
				textInput = "2222"
			}
			else if menu == 2
			{
				connectPort = real(textInput)
				var _port = connectPort
				if creating
				{
					global.server = network_create_server(network_socket_tcp, connectPort, 16)
					if global.server < 0
					{
						while (global.server < 0 && connectPort < 65535)
						{
							connectPort++
							global.server = network_create_server(network_socket_tcp, connectPort, 32);
						}
						if connectPort != _port
							show_message($"Your port has been changed to: {connectPort}")
					}
						global.connected = true
						room_goto(Mainmenu)
						obj_player.state = states.normal
						instance_create(x, y, obj_server)
				}
				else {
					global.client = network_create_socket(network_socket_tcp);
					var server = network_connect(global.client, connectIP, connectPort);
					if server < 0
					{
						show_message("Connection failed or server does not exist!")
						menu = 1
						creating = false
						keyboard_string = ""
						textInput = ""
						global.client = -4
					}
					else 
					{
						global.connected = true
						obj_player.state = states.normal
						room_goto(Mainmenu)
						instance_create(x, y, obj_server)
						obj_server.create_notifAsync($"Player has connected!", c_yellow)
					}
				}
			}
		}
	}
}