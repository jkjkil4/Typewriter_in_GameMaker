///@arg <Real>TypewriterID

var _id = argument0;

var _list = _id.private_list;
_id.private_list = -1;
_id.private_str = "";

if(_list != -1) {
	var _len = ds_list_size(_list);
	for(var i = 0; i < _len; i++) {
		ds_list_destroy(_list[| i]);
	}
	ds_list_destroy(_list);
}