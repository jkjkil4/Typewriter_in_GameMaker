/// @description Insert description here
// You can write your code in this editor

enum EscapeFlags { NoEscape, keyEscape, argEscape };

isTyping = false;	//控制是否在打字(比如false就会停住)
typingSpd = 0.2;	//打字速度
process = 0;		//打字进程

defColor = make_color_rgb(255, 255, 255);


//---Private变量，请勿直接使用---
private_str = "";
private_list = -1;
private_effectIndex = 0;