if beat != obj_soundtestPlayer.beat
{
	beat = obj_soundtestPlayer.beat
	if dancing
	{
		groove++
		groove = wrap(groove, 1, 2)
		sprite_index = asset_get_index($"spr_harper_milton_groove{groove}")
		image_index = 0
		y -= 15
	}
}