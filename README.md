# Typewriter_in_GameMaker
 Typewriter 打字机

1. 与打字机有关的东西
    - object: objTypewriter是打字机
    - script: typewriter_setText(typewriterID, text)是用来设置打字机文本的
    - script: typewriter_delText(typewriterID)是用来清空打字机文本的
    - *script: getNumFromHex是用来从十六进制转换到数字的（你用不到这个*
    - *script: getColorFromHexString是用来从十六进制得到颜色的（你用不到这个*

2. 与打字机无关的东西
    - objTest中是关于打字机的使用例子

3. 使用方法
    - 使用xxx = instance_create_xxxx函数来创建一个objTypewriter的实例
    - 使用typewriter_setText(xxx, text)来设置文字
    - xxx.isTyping来控制是否继续(比如false将会让打字机停下来) 默认为false
    - xxx.typingSpd是打字的速度

4. 注意事项
    - 带有private_开头的变量最好不要直接操作
