///@arg <Real>typewriterID
///@arg <String>text

var _id = argument0;
var _str = argument1;

//销毁原有的text
typewriter_delText(_id);

//解析text
var _len = string_length(_str);

var _resultStr = "";
var _resultList = ds_list_create();

var _escapeFlag = EscapeFlags.NoEscape;
var _escapeIndex = 0;
var _escapeKey = "";
var _escapeArg = "";

for(var i = 0; i < _len; i++) {
	var ch = string_char_at(_str, i + 1);
		
	//识别转义
	if(ch == "<") {
		if(_escapeFlag == EscapeFlags.NoEscape)	{
			_escapeFlag = EscapeFlags.keyEscape;
			_escapeIndex = string_length(_resultStr);
			_escapeKey = "";
			_escapeArg = "";
			continue;
		} else {
			_escapeFlag = EscapeFlags.NoEscape;	
		}
	}
		
	//处理Key和Arg
	if(_escapeFlag == EscapeFlags.keyEscape) {	//Key
		if(ch == ":") {
			_escapeFlag = EscapeFlags.argEscape;	
		} else if(ch == ">") {
			_escapeFlag = EscapeFlags.NoEscape;
			var _keyAndArg = ds_list_create();
			ds_list_add(_keyAndArg, _escapeIndex, _escapeKey, _escapeArg);
			ds_list_add(_resultList, _keyAndArg);
		} else {
			_escapeKey += ch;	
		}
		continue;
	} else if(_escapeFlag == EscapeFlags.argEscape) {	//Arg
		if(ch == ">") {
			_escapeFlag = EscapeFlags.NoEscape;	
			var _keyAndArg = ds_list_create();
			ds_list_add(_keyAndArg, _escapeIndex, _escapeKey, _escapeArg);
			ds_list_add(_resultList, _keyAndArg);
		} else {
			_escapeArg += ch;	
		}
		continue;
	}
		
	_resultStr += ch;
}

_id.private_str = _resultStr;
_id.private_list = _resultList;
