
isTyping = false;	//控制是否在打字(比如false就会停住)
typingSpd = 0.2;	//打字速度
process = 0;		//打字进程
font = -1;			//字体

defColor = make_color_rgb(255, 255, 255);	//默认颜色


#region OtherThings
//元素结构体
Element = function(_type, _num) constructor
{
	enum ElementType { Text, Sprite };
	type = _type;
	num = _num;
}

//效果结构体
Effect = function(_index, _key, _arg) constructor
{
	index = _index;
	key = _key;
	arg = _arg;
}

//用来对<>的分析过程进行标记的枚举
enum EscapeFlags { NoEscape, KeyEscape, ArgEscape };


//某个宏定义
#macro TYPEWRITER_ADD_ARGS_TO_LIST															\
	if(_escapeKey == "sprite") {															\
		ds_list_add(private_eleList, new Element(ElementType.Sprite, asset_get_index(_escapeArg)));		\
	} else {																				\
		ds_list_add(private_effList, new Effect(_escapeIndex, _escapeKey, _escapeArg));		\
	}

/// @function				setText(_text)
/// @param {string} _text	传入带有<>的文字，将会被分析为不带<>的文字和效果列表
function setText(_text) {
	//清除原有的文字和效果列表
	clearText();
	reset();
	
	//解析text
	var _len = string_length(_text);
	private_eleList = ds_list_create();
	private_effList = ds_list_create();

	var _escapeFlag = EscapeFlags.NoEscape;
	var _escapeIndex = 0;
	var _escapeKey = "";
	var _escapeArg = "";

	for(var i = 0; i < _len; i++) {
		var ch = string_char_at(_text, i + 1);
		
		//识别转义
		if(ch == "<") {
			if(_escapeFlag == EscapeFlags.NoEscape)	{
				_escapeFlag = EscapeFlags.KeyEscape;
				_escapeIndex = ds_list_size(private_eleList);
				_escapeKey = "";
				_escapeArg = "";
				continue;
			} else {
				_escapeFlag = EscapeFlags.NoEscape;	
			}
		}
		
		//处理Key和Arg
		if(_escapeFlag == EscapeFlags.KeyEscape) {	//Key
			if(ch == ":") {
				_escapeFlag = EscapeFlags.ArgEscape;
			} else if(ch == ">") {
				_escapeFlag = EscapeFlags.NoEscape;
				TYPEWRITER_ADD_ARGS_TO_LIST
			} else {
				_escapeKey += ch;	
			}
			continue;
		} else if(_escapeFlag == EscapeFlags.ArgEscape) {	//Arg
			if(ch == ">") {
				_escapeFlag = EscapeFlags.NoEscape;	
				TYPEWRITER_ADD_ARGS_TO_LIST
			} else {
				_escapeArg += ch;
			}
			continue;
		}
		
		ds_list_add(private_eleList, new Element(ElementType.Text, ord(ch)));
	}
}

/// @function			reset()		用来重置打字机，但不会删除文字、字体和效果
function reset() {
	process = 0;
	private_effectIndex = 0;	
}

/// @function	elementListSize()	返回值是去除了<>但是包括<sprite:xxx>的eleList的大小	例如当setText传入的文字为"aaa<Key:Arg>b<Key:Arg>cccc<sprite:xxx>"时的返回值是 9
function elementListSize() {
	return private_eleList == -1 ? 0 : ds_list_size(private_eleList);	
}

/// @function	effectListSize()	返回值是除了<sprite:xxx>的effList的大小				例如当setText传入的文字为"aaa<Key:Arg>b<Key:Arg>cccc<sprite:xxx>"时的返回值是 2
function effectListSize() {
	return private_effList == -1 ? 0 : ds_list_size(private_effList);	
}

/// @function	clearText()	用来清除文字和效果列表
function clearText() {
	//销毁eleList中的元素
	if(private_eleList != -1) {	//如果有eleList
		var _listSize = ds_list_size(private_eleList);
		for(var i = 0; i < _listSize; i++) {	//遍历effList
			delete private_eleList[|i];	
		}
		private_eleList = -1;
	}
	
	//销毁effList中的元素
	if(private_effList != -1) {	//如果有effList
		var _listSize = ds_list_size(private_effList);
		for(var i = 0; i < _listSize; i++) {	//遍历effList
			delete private_effList[|i];	
		}
		private_effList = -1;
	}
}


//---Private变量，请勿直接使用---
private_eleList = -1;
private_effList = -1;
private_effectIndex = 0;
#endregion
