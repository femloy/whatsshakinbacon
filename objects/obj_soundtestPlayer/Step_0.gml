if place_meeting(x, y, obj_player)
{
	with obj_player
	{
		if key_up_pressed
		{
			with other
			{
				if songInst == -4
				{
					var _song = songs[currentSong]
					songInst = FMODcreate_event(_song.event)
					fmod_studio_event_instance_start(songInst);
				}
				playing = playing == true ? false : true
				show_debug_message($"Playing? {playing}")
				image_index = 1
				alarm[0] = 5
			}
		}
	}
}
isMilton = songs[currentSong].milton == true && playing
if songInst != -4
{
	fmod_studio_event_instance_set_callback(songInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT)
	fmod_studio_event_instance_set_paused(songInst, !playing)
}