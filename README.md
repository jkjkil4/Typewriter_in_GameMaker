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

4. 使用特殊效果的方法
    - 基本格式: 在typewriter_setText传入的字符串中，使用\<key:arg>来使用特殊效果
    - 设置颜色: \<color:颜色值> 其中颜色值为16进制 (比如FF0000，红:FF 绿:00 蓝: 00，最终是红色)
    - 设置透明度: \<alpha:透明度> 其中透明度为0~1的小数，1就是不透明，0就是透明
    - 文字抖动: \<random:抖动程度> 其中抖动程度决定了文字在各方向抖动的最大值（我是用irandom_range(-randomNum, randomNum)来做这个的）
    - 设置横向缩放: \<xscale:缩放大小> 缩放大小即为拉伸的倍数，不能为负数
    - 设置纵向缩放: \<yscale:缩放大小> 缩放大小即为拉伸的倍数，不能为负数
    - 设置横向间距: \<xspace:间距>
    - 设置纵向间距: \<yspace:间距>
    - 重置所有效果: \<reset>
 
5. 自定义特殊效果的方法
    - 在objTypewriter的Draw事件的switch(keyString)中加入对应的case "xxxxx"，然后在draw的地方作出相应的更改
    - 在objTypewriter的Draw事件的尾部，有一个switch(ssKeyString)，是用来做单次触发的，其中有个"SingleShot"的例子，就是弹出一个提示框

6. 其他
    - 带有private_开头的变量最好不要直接操作

7. 对于GM8版本的额外的说明
    - 使用了FoxWriting插件，如果你没有这个插件，你可以把fw_开头的函数的"fw_"删掉，但是就不能绘制非ASCII字符了
    - 必须给打字机设置一个字体才能绘制出文字(使用"xxx.font = 你载入的字体;"来设置)
    - 换行要用\<n> (在GMS2中是\n)
