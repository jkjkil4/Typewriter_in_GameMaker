///@arg <String>inputHexString

var _hexString = argument0;
var _len = string_length(_hexString);
var _output = 0;

for(var i = 0; i < _len; i++) {
	_output += getNumFromHex(string_char_at(_hexString, i + 1)) << (i * 4);
}

return _output;