/// @description Insert description here
// You can write your code in this editor

t1 = instance_create_depth(50, 50, 0, objTypewriter);
typewriter_setText(t1, "This is a <color:FF00FF>test <color:FF0000>t<color:00FF00>e<color:0000FF>x<color:00FFFF>t<reset>,\n ........  <color:FF0000><xscale:1.2><yscale:1.2><random:1>YOYOSB");
t1.isTyping = true;
t1.typingSpd = 0.3;

t2 = instance_create_depth(50, 150, 0, objTypewriter);
typewriter_setText(t2, "<color:CC4444>This <color:44CC44>is <color:4444CC>another <color:44CCCC>text<reset>,\n<random:1>emmmmmmmmmmmmmm");
t2.isTyping = true;
t2.typingSpd = 0.5;