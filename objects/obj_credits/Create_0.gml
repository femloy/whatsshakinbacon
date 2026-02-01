obj_player.state = -4

credits = []

add_credit = function(_text)
{
	var q = 
	{
		text: _text,
		y: array_length(credits)
	}
	array_push(credits, q)
}
with obj_music
	stop_music()

music = FMODcreate_event("event:/Music/Soundtest/credits")
fmod_studio_event_instance_start(music)
fmod_studio_event_instance_set_paused(music, false)

add_credit("PLACEHOLDER CREDITS")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("OPEN YOUR HEART")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("Mizukinny/Mildrux")
add_credit("Project lead, Artist, Composer, Coder")
add_credit("")
add_credit("")
add_credit("")
add_credit("Peebuttnudder")
add_credit("Director, Artist")
add_credit("")
add_credit("")
add_credit("")
add_credit("Varies")
add_credit("Composer")
add_credit("")
add_credit("")
add_credit("Guilava")
add_credit("Artist")
add_credit("")
add_credit("")
add_credit("")
add_credit("Scart")
add_credit("Artist")
add_credit("")
add_credit("")
add_credit("")
add_credit("And many others")
add_credit("I dont remember right now")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("")
add_credit("HAPPY VALENTINES DAY!")
add_credit("THANKS FOR PLAYING!")
draw_set_font(global.creditsfont)
y = SCREEN_HEIGHT + string_height("A") * 5