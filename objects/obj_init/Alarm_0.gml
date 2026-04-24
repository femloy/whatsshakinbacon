if array_length(textures) > 0
{
	var q = textures[0]
	for (var i = 0; i < array_length(q); i++)
	{
		if !texture_is_ready(q[i])
		{
			show_debug_message($"Loaded page: {q[i]}")
			texture_prefetch(q[i])
		}
	}
	array_shift(textures)
	alarm[0] = 1
	
} 
else
{
	instance_destroy()
	obj_intro.scene = 0
}