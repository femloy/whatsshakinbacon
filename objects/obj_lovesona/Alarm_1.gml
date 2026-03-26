global.collect += 10
points = max(points - 10, 0)
create_collect(asset_get_index($"spr_collect{irandom_range(1, 5)}"), x, y)
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y)
if points > 0
	alarm[1] = 5
else
	alarm[0] = 60