get_menu_input()
if active
{
	if !array_contains(portraitsExist, currentChar)
	{
		array_push(portraitsExist, currentChar)
		add_portrait(currentChar)
	}
	if key_jump_pressed
	{
		event_user(0)
	}
}