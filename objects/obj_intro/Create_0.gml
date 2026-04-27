logo_xs = 0
logo_ys = 0
logo_alpha = 1
scene = -1
timer = 30
spd = 0

easeOutElastic = function(x) {
    var _c4 = (2 * pi) / 3;
    
    if (x == 0) return 0;
    if (x == 1) return 1;
    
    return power(2, -10 * x) * sin((x * 10 - 0.75) * _c4) + 1;
}

easeVal = 0
easeVal2 = 0