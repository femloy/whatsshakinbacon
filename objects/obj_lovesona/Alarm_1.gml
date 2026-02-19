global.collect += 10
global.combo.timer = 60
points -= 10
create_collect(asset_get_index($"spr_lover{lover}_proj"), x, y)
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y)
if points > 0
	alarm[1] = 16
else
	alarm[0] = 30