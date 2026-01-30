scene = 1
var _dialog = instance_create(x, y, obj_dialog)
with _dialog
{
	addDialog(dialogChars.milton, "HEY!")
	addDialog(dialogChars.milton, "HEY YOU!")
	addDialog(dialogChars.milton, "Now who do you think you's are?")
	addDialog(dialogChars.mildred, "What? Oh wait are you talking to me?")
	addDialog(dialogChars.mildred, "I just arrived at the hotel, and I was on my way to the staff room")
	addDialog(dialogChars.mildred, "At least something adjacent to that-")
	addDialog(dialogChars.mildred, "Can you get out of my way actually now")
	addDialog(dialogChars.mildred, "As a matter of fact- Who even ARE you??")
	addDialog(dialogChars.milton, "BE. QUIET. [shake]SHUT UP.")
	addDialog(dialogChars.milton, "I..")
	addDialog(dialogChars.milton, "I, am MILTON!")
	addDialog(dialogChars.milton, "I dont know who you are, or why you think its okay to [wave]LOOK[clear] like me")
	addDialog(dialogChars.milton, "But you and your little lady friend ruin my WHOLE. DAMN. VIBE.")
	addDialog(dialogChars.mildred, "Okay")
	addDialog(dialogChars.mildred, "I don't know what I even did to you")
	addDialog(dialogChars.mildred, "Infact- we JUST met.")
	addDialog(dialogChars.mildred, "Horrible first impression.")
	addDialog(dialogChars.milton, "Blah blah blah")
	addDialog(dialogChars.milton, "All I hear from you is nagging, not now.")
	addDialog(dialogChars.milton, "I know what your here for, and I know your going to that [wave]'Waybackyard'[clear]")
	addDialog(dialogChars.milton, "I dont have time to deal with your childish games")
	addDialog(dialogChars.milton, "Just stay out of my lane, and know I got ALL. ALL of my eyes on you")
	addDialog(dialogChars.milton, "All 3 of them!")
	addDialog(dialogChars.mildred, "You have two.")
	addDialog(dialogChars.milton, "All 2 of them!")
	addDialog(dialogChars.milton, "Plus Ernies 1!")
	addDialog(dialogChars.milton, "Let us leave now, Ernie")
	addDialog(dialogChars.milton, "MILTEAM, [wave]OUT![clear]", function()
	{
		obj_miltonCutscene.scene = 2
		obj_dialog.active = false
	})
	addDialog(dialogChars.mildred, "What an asshole..", function()
	{
		obj_miltonCutscene.alarm[2] = 2
	})
	active = true
	event_user(0)
}