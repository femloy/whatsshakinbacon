depth = target.depth + 2
x = target.x + irandom_range(shake, -shake)
y = target.y - 42 + irandom_range(shake, -shake)
shake = approach(shake, 0, 1)
if mashCount <= 0
	instance_destroy()
	
timeKill--
if timeKill <= 0
{
	instance_destroy()
	instance_create(x, y, obj_hipnatuese)
}