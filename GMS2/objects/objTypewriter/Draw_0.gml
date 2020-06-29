/// @description Insert description here
// You can write your code in this editor


var strLen = string_length(private_str);
var typeLen = floor(process);

var countWidth = 0, countHeight = 0;
var currentLineHeightMax = 0;

var color = defColor;
var alpha = 1;
var randomNum = 0;
var xscale = 1, yscale = 1;
var xspace = 0, yspace = 0;

var effectSize = ds_list_size(private_list);
var hasEffect = private_list != -1 && effectSize > 0;
if(hasEffect) {
	var effectIndex = 0;
	var effectList = private_list[| 0];
	var effectStringIndex = effectList[| 0];
}

for(var i = 0; i < min(strLen, typeLen); i++) {
	var ch = string_char_at(private_str, i + 1);
	
	//换行
	if(ch == "\n") {
		countWidth = 0;
		countHeight += currentLineHeightMax;
		currentLineHeightMax = 0;
		typeLen += 1;
	}
	
	//应用特效
	if(private_list != -1 && effectSize > 0) {
		while(effectIndex < effectSize) {
			if(effectStringIndex != i)
				break;
			var keyString = effectList[| 1];
			var argString = effectList[| 2];
			
			switch(keyString) {
			case "color":
				color = getColorFromHexString(argString);	
				break;
			case "alpha":
				alpha = real(argString);
				break;
			case "random":
				randomNum = real(argString);
				break;
			case "xscale":
				xscale = real(argString);
				if(xscale < 0)
					xscale = 1;
				break;
			case "yscale":
				yscale = real(argString);
				if(yscale < 0)
					yscale = 1;
				break;
			case "xspace":
				xspace = real(argString);
				break;
			case "yspace":
				yspace = real(argString);
				break;
			case "reset":
				color = defColor;
				alpha = 1;
				randomNum = 0;
				xscale = 1;
				yscale = 1;
				xspace = 0;
				yspace = 0;
				break;
			}
			
			effectIndex++;
			if(effectIndex >= effectSize)
				break;
			effectList = private_list[| effectIndex];
			effectStringIndex = effectList[| 0];
		}
	}
	
	//得到绘制的位置
	var xx = x + countWidth;
	var yy = y + countHeight;
	if(randomNum != 0) {
		xx += irandom_range(-randomNum, randomNum);
		yy += irandom_range(-randomNum, randomNum);
	}
	
	//统计宽高
	countWidth += string_width(ch) * xscale + xspace;
	var tmpHeight = string_height(ch) * yscale + yspace;
	if(tmpHeight > currentLineHeightMax)
		currentLineHeightMax = tmpHeight;
	
	draw_text_transformed_color(xx, yy, ch, xscale, yscale, 0, color, color, color, color, alpha);
	
}

//单次触发
if(hasEffect) {
	if(effectIndex > private_effectIndex) {
		for(var i = private_effectIndex; i < min(effectSize, effectIndex); i++) {
			var singleShotList = private_list[| i];
			var ssKeyString = singleShotList[| 1];
			var ssArgString = singleShotList[| 2];
			switch(ssKeyString) {
			case "SingleShot":
				show_message("SingleShot!");
				break;
			}
		}
	}
	private_effectIndex = effectIndex;
}

