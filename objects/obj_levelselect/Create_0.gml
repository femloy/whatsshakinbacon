obj_player.state = -4
worldNames = ["Lunch Hour", "Final"]
levels = []
var _world1 = [
	[tutorial_1, "tutorial", "A", "Tutorial"],
	[wayback_1, "forest", "A", "Waybackyard"], 
	[city_1, "city", "A", "Rock Bottom"], ]
var _final = [
	[hotel_final, "hotel", "A", "Final"],]


array_push(levels, _world1, _final)

selectedWorld = 0
selectedLevel = 0
potableIndex = 0