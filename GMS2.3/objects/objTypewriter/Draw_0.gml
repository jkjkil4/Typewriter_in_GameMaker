if(private_eleList != -1 && private_effList != -1) {
	function getElementWidth(ele) {
		switch(ele.type) {
		case ElementType.Text:
			return string_width(chr(ele.num));
		case ElementType.Sprite:
			return sprite_get_width(ele.num);
		default:
			return 0;
		}
	}

	function getElementHeight(ele) {
		switch(ele.type) {
		case ElementType.Text:
			return string_height(chr(ele.num));
		case ElementType.Sprite:
			return sprite_get_height(ele.num);	
		default:
			return 0;
		}
	}
	
	
	var prevFont = draw_get_font();
	if(font != -1) {
		draw_set_font(font);	
	}


	var countWidth = 0;
	var countHeight = 0;
	var currentLineHeightMax = 0;

	var color = defColor;
	var alpha = 1;

	var xSpace = 0;
	var ySpace = 0;
	var xScale = 1;
	var yScale = 1;
	
	var randomNum = 0;

	var eleSize = ds_list_size(private_eleList);
	var effSize = ds_list_size(private_effList);
	var typeLen = floor(process);
	
	var hasEffect = effSize > 0;
	if(hasEffect) {
		var effectIndex = 0;
		var eff = private_effList[| 0];
	}

	for(var i = 0; i < min(eleSize, typeLen); i++) {
		var ele = private_eleList[|i];
	
		//换行
		if(ele.type == ElementType.Text && ele.num == ord("\n")) {
			countWidth = 0;
			countHeight += currentLineHeightMax;
			currentLineHeightMax = 0;
			typeLen += 1;
		}
		
		//应用特效
		if(private_effList != -1 && effSize > 0) {
			while(effectIndex < effSize) {
				if(eff.index != i)
					break;
				var keyString = eff.key;
				var argString = eff.arg;
			
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
					xScale = real(argString);
					if(xScale < 0)
						xScale = 1;
					break;
				case "yscale":
					yScale = real(argString);
					if(yScale < 0)
						yScale = 1;
					break;
				case "xspace":
					xSpace = real(argString);
					break;
				case "yspace":
					ySpace = real(argString);
					break;
				case "reset":
					color = defColor;
					alpha = 1;
					randomNum = 0;
					xScale = 1;
					yScale = 1;
					xSpace = 0;
					ySpace = 0;
					break;
				}
			
				effectIndex++;
				if(effectIndex >= effSize)
					break;
				eff = private_effList[| effectIndex];
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
		countWidth += getElementWidth(ele) * xScale + xSpace;
		var tmpHeight = getElementHeight(ele) * yScale + ySpace;
		if(tmpHeight > currentLineHeightMax)
			currentLineHeightMax = tmpHeight;
	
		switch(ele.type) {
		case ElementType.Text:
			draw_text_transformed_color(xx, yy, chr(ele.num), xScale, yScale, 0, color, color, color, color, alpha);
			break;
		case ElementType.Sprite:
			draw_sprite_ext(ele.num, -1, xx, yy, xScale, yScale, 0, noone, alpha);
			break;
		}
	}
	
	//单次触发
	if(hasEffect) {
		if(eleSize <= typeLen) {
			effectIndex = effSize;
		}
		if(effectIndex > private_effectIndex) {
			for(var i = private_effectIndex; i < min(effSize, effectIndex); i++) {
				var eff = private_effList[| i];
				var ssKeyString = eff.key;
				var ssArgString = eff.arg;
				switch(ssKeyString) {
				case "SingleShot":
					show_message("SingleShot!");
					break;
				}
			}
		}
		private_effectIndex = effectIndex;
	}
	
	draw_set_font(prevFont);
}

