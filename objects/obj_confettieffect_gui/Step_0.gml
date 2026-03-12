var gv = 0.5
if vsp > 0
	gv = 0.1
vsp += gv
x += hsp
y += vsp

if vsp > 5
	image_alpha -= 0.01
if image_alpha <= 0
	instance_destroy()