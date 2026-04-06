function approach(_start, _end, _increment)
{
	if (_start < _end)
		return min(_start + _increment, _end); 
	else
		return max(_start - _increment, _end);
}

function getTime(minutes = 1, seconds = 30)
{
	return (minutes * 60 * 60) + (seconds * 60)
}

function wrap(_variable, _minimum, _maximum)
{
	var value = floor(_variable);
	var _min = floor(min(_minimum, _maximum));
	var _max = floor(max(_minimum, _maximum));
	var range = _max - _min + 1; // + 1 is because max bound is inclusive

	return (((value - _min) % range) + range) % range + _min;
}

/// @description Returns a value that will wave back and forth between [from-to] over [duration] seconds
/// @param from 	
/// @param to
/// @param duration
/// @param offset // is actually bullshit because it does fucking nothing to the output, thanks whoever wrote this function! (IT WAS UNOWN)
function wave(from, to, duration, offset) {
	var a4 = (to - from) * 0.5;
	return from + a4 + sin(((((current_time - offset) * 0.001) + duration) / duration) * (pi * 2)) * a4;	
}

/// @description Returns true or false depending on RNG.
/// @param percent 
function chance(percent) {
	return percent > random(1);
}