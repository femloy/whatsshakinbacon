var targobj = obj_player

if obj_player.x != x
	image_xscale = sign(obj_player.x - x)
x = lerp(x, obj_player.x - (42 * obj_player.xscale), 0.35)
y = lerp(y, obj_player.y, 0.35)