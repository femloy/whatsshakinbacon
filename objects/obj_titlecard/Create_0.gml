tcard = "spr_titlecardMonolith"
titlecardSprite = lang_get_asset($"{tcard}1")
titlecardName = {sprite: lang_get_asset($"{tcard}2"), x: 0, y: 0, alpha: 0, fadeIn: false}
fadeAlpha = 0
fadeIn = true
scene = 0
depth = -600
fadeSurface = surface_create(SCREEN_WIDTH, SCREEN_HEIGHT)
circleSize = 0
circleSizeSpeed = 0
titlecardMilton = spr_titlecardMilton_wayback
titlecardMiltonIndex = 0
isMilton = obj_player.character == characters.milton
jingle = "event:/Music/W1/Monolith Mangrove/titlecard"
group = "Wayback_group"