if !fadeout
	fade = approach(fade, 1, 0.1)
else {
	fade = approach(fade, 0, 0.05)
}
if fadeout && fade == 0
	instance_destroy()