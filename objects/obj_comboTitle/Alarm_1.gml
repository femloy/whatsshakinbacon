points = approach(points, 0, 5)
var _sprite = asset_get_index($"spr_collect{irandom_range(1, 5)}")
create_collect(_sprite, x, y, true)