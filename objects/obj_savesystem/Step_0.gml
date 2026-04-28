if state != savesystem.idle
{
	show_icon = true
	icon_alpha = 3
}
else if show_icon
{
	icon_alpha = max(icon_alpha - 0.03, 0)
	if icon_alpha <= 0
		show_icon = false
}

if show_icon
{
	icon_index += 0.45
}