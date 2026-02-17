np_setpresence_more("", "", false);
var _details = "Open Your Heart"
/*
var _state = ""
var _rank = "D";
if global.collect >= global.Srank
	_rank = "S"
else if global.collect >= global.Arank
	_rank = "A"
else if global.collect >= global.Brank
	_rank = "B"
else if global.collect >= global.Crank
	_rank = "C"
if global.level != noone
{
	_state = string_concat(string_seconds_to_timer(global.level_timer), " | Score: ", global.collect, " | Combo: ", global.combo.amt, " (", global.combo.dropped ? "Non P-Rank)" : "P-Rank)", " | Rank: ", _rank)
	switch global.level
	{
		case "forest":
			_details = "Waybackyard"
			break
		case "gutter":
			_details = "John Gutter 2"
			break
		case "beer":
			_details = "Mildred Gets Tipsy"
			break
		case "city":
			_details = "Legends of Shell City"
			break
	}
}*/
np_setpresence(_details, "", "", "");
alarm[1] = 5