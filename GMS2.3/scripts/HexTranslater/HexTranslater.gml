

/// @function						getColorFromHexString(_hexString)
/// @param {string} _hexString		传入的字符串，例如"FF0000"
function getColorFromHexString(_hexString){
	var _len = string_length(_hexString);
	var _output = 0;

	for(var i = 0; i < _len; i++) {
		_output += getNumFromHex(string_char_at(_hexString, i + 1)) << (i * 4);
	}

	return _output;
}


/// @function		getNumFromHex(_hex)
/// @param {string} _hex		传入的字符(十六进制)
function getNumFromHex(_hex) {
	var _hexOrd = ord(_hex);

	if(_hexOrd >= ord("0") && _hexOrd <= ord("9")) {
		return _hexOrd - ord("0");
	
	} else if(_hexOrd >= ord("A") && _hexOrd <= ord("F")) {
		return _hexOrd - ord("A") + 10;	
	
	} else if(_hexOrd >= ord("a") && _hexOrd <= ord("f")) {
		return _hexOrd - ord("a") + 10;	
	}

	return 0;	
}