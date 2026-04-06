global.collect = approach(global.collect, 0, 5)
FMODevent_oneshot("event:/Sfx/General/Enemy/Ant/poisontick", x, y)
with obj_hud
	array_push(kettle.badnum, {x: kettle.x + 90, y: kettle.y, alpha: 1, text: "-5"})