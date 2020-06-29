///@arg <String>inputHex

var _hex = argument0;

var _hexOrd = ord(_hex);

if(_hexOrd >= ord("0") && _hexOrd <= ord("9")) {
	return _hexOrd - ord("0");
	
} else if(_hexOrd >= ord("A") && _hexOrd <= ord("F")) {
	return _hexOrd - ord("A") + 10;	
	
} else if(_hexOrd >= ord("a") && _hexOrd <= ord("f")) {
	return _hexOrd - ord("a") + 10;	
}

return 0;