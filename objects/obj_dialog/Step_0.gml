getMenu_input()
if active
{
	if !array_contains(portraitsExist, currentChar)
	{
		array_push(portraitsExist, currentChar)
		add_portrait(currentChar)
	}
	if key_jump2
	{
		event_user(0)
	}
}