get_input()
if keyboard_check_pressed(vk_anykey)
{
	if !prompSkip
		prompSkip = true
	else if prompSkip && key_jump_pressed
		video_close()
}
if video_get_status() == video_status_closed
{
	video_close()
	instance_destroy() 
    room_goto(Mainmenu)
}
video_set_volume(global.MasterVolume / 100)