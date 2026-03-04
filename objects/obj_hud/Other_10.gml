if musicBeat != obj_music.beat
{
	musicBeat = obj_music.beat
	musicBar = obj_music.bar
	discoColor++
	discoColor = wrap(discoColor, 0, array_length(discoColors) - 1)
}