fmod_studio_event_instance_stop(snd, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
fmod_studio_event_instance_release(snd)

ini_open(global.saveFile)
if ini_read_real("General", $"Totem{totem}", false) == false
{
	obj_totemViewer.goawayTimer = 60 * 3
	obj_totemViewer.totemIndex = totem
	ini_write_real("General", $"Totem{totem}", true)
}
ini_close()