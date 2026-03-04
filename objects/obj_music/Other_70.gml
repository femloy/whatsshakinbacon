if async_load[? "type"] == "fmod_studio_event_description_set_callback"
{
	beat = async_load[? "beat"]
	bar = async_load[? "bar"]
	with obj_hud
		event_user(0)
}