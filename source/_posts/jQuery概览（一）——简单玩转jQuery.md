---
title: jQuery概览（一）——简单玩转jQuery
date: 2018-01-26 15:09:13
updated: 2018-05-15 11:20:52
comments: true
categories:
- WEB前端
tags:
- 选择器
- 属性操作
- CSS操作
- jQuery对CSS样式的操作
- jQuery对HTML文档结构的操作
- 事间
- 动画效果
- 对象访问控制
---

本篇文章介绍一下基本的jQuery的使用规则，包含常用的选择器，属性操作等等，如果在后续还有更新，我会在这篇文章中的相应位置进行增加，请大家继续关注我的博客

一、选择器

基本选择器：

```javascript
$("*") // 选中所有元素 
$("#ceshi"); // 选中id为ceshi的元素
$(".ceshi"); // 选中class为ceshi的元素
$("div"); // 选中所有div元素
$("#ceshi > div:first"); // 选中id为ceshi下的第一个div元素
$("#ceshi, div"); // 选中id为ceshi的元素和所有div元素
$("div:first"); // 选中第一个div
$("div:last"); // 选中最后一个div
$("div:even"); // 选中索引为偶数的div（从0开始）
$("div:odd"); // 选中索引为奇数的div（从0开始）
$("div:eq(1)"); // 选中索引为1的div元素
$("div:gt(3)"); // 选中索引值大于3的div元素（不包括索引值为3的div元素）
$("div:lt(3)"); // 选中索引值小于3的div元素（不包括索引值为3的div元素）
$("input:focus"); // 选中当前聚焦的input元素
$("div:animated"); // 选中当前正在执行动画的div元素
$("div:hidden"); // 选中所有隐藏的div元素
$("div:visible"); // 选中所有可见的div元素
$("[id]"); // 选中所有带有id属性的元素
$("[class='ceshi']"); // 选中所有为ceshi类的元素
$("[class!='ceshi']"); // 选中所有不为ceshi类的元素
$("[class$='ceshi']"); // 选中所有带有ceshi字符的类
```

内容选择器

```javascript
$("div:contains('ceshi')"); // 选中文本带有ceshi的所有的div
$("div:empty"); // 选中所有不包含子元素或者空文本的div
$("div:parent"); // 选中所有包含子元素或者文本元素的div
$("div:has(p)"); // 选中所有包含p元素的div元素
```

表单选择器

```javascript
$(":input"); // 选中所有 input, textarea, select 和 button 元素
$(":text"); // 选中所有 type="text" 的 <input> 元素
$(":password"); // 选中所有 type="password" 的 <input> 元素
$(":radio"); // 选中所有 type="radio" 的 <input> 元素
$(":checkbox"); // 选中所有 type="checkbox" 的 <input> 元素
$(":submit"); // 选中所有 type="submit" 的 <input> 元素
$(":reset"); // 选中所有 type="reset" 的 <input> 元素
$(":button"); // 选中所有 type="button" 的 <input> 元素
$(":file"); // 选中所有 type="file" 的 <input> 元素
$(":image"); // 选中所有 type="image" 的 <input> 元素 （出场率最低的type类型）
$(":enabled"); // 选中所有激活的input元素
$(":disabled"); // 选中所有禁用的input元素
$(":selected"); // 选中所有被选取的input元素
$(":checked"); // 选中所有被选中的input元素
$("#upparent_name").find("option:selected").text() // 获得id=upparent_name的下拉框选中的option的文本内容
```

<br>

二、属性操作

基本属性操作

```javascript
$("div").attr("class"); // 返回文档中所有div元素的class属性值
$("div").attr("class","ceshi"); // 设置所有div的class属性值为ceshi
$("div").removeAttr("class"); // 删除文档中所有div的class属性 （不建议使用）
$("img").removeProp("src"); // 删除img的src属性 （建议使用）
$("input[type='checkbox']").prop("checked", true); // 选择所有被选中的复选框
$("input[type='checkbox']").prop("checked", false); // 选择所有没被选中的复选框
```

CSS属性操作

```javascript
$("div").addClass("selected"); // 为div元素加上 'selected' 类
$("div").removeClass("selected"); // 从div元素中删除 'selected' 类
$("div").toggleClass("selected"); // 如果存在就删除,否则就添加
```

HTML获取值和写入信息操作

> .html()是用来读取元素的html内容（包括html标签）；
>
> .text()用来读取元素的纯文本内容，包括其后代元素；
>
> .val()是用来读取表单元素的"value"值；
>

```javascript
$('p').html(); // 返回p元素的html内容
$("p").html("ceshi <b>ceshi</b>!"); // 设置p元素的html内容
$('p').text(); // 返回p元素的文本内容
$("p").text("ceshi"); // 设置p元素的文本内容
$("input").val(); // 获取文本框中的值
$("input").val("ceshi"); // 设置文本框中的内容
```

<br>

三、jQuery对CSS的操作

样式

```javascript
$("p").css("color"); // 获得p元素的color属性值
$("p").css("color","green"); // 为p元素设置color为green
$("p").css({ "color": "green", "background": "yellow" }); // 为p元素设置字体颜色和背景颜色，设置多属性的时候要使用{}
```

位置

```javascript
$('p').offset(); // 获得p元素相对于当前视口的偏移（相对于浏览器左上角窗口）
$('p').offset().top; // 获得p元素距离当前视口顶部偏移值
$('p').offset().left; // 获得p元素距离当前视口左侧偏移值
$("p").position(); // 获得p元素相对于父元素的偏移位置（可见元素才有效）
$(window).scrollTop(); // 获取鼠标滚轮滑动的高度
$(window).scrollLeft(); // 获取鼠标滚轮滑动的宽度
$(window).scrollTop('100'); // 设置垂直偏移100
$(window).scrollLeft('100'); // 设置水平偏移100
```

大小尺寸

```javascript
$("p").height(); // 获取p元素的高
$("p").width(); // 获取p元素的宽
$("p:first").innerHeight(); // 获得第一个p元素的区域高度（包含上下padding，不包含上下border和margin）
$("p:first").innerWidth(); // 获得第一个p元素的区域宽度
$("p:first").outerHeight(); // 获得第一个p元素（包括padding，border，margin）
$("p:first").outerWidth(); // 获得第一个p元素
$("p:first").outerHeight(true); // 为true时包括边距
```

<br>

四、jQuery对文档的处理

内部插入

```javascript
$("p").append("<b>ceshi</b>"); // 在每个p元素内的最后面追加内容
$("<b>ceshi</b>").appendTo("p"); // 将内容追加到p元素的最后面
$("p").prepend("<b>ceshi</b>"); // 在每个p元素内的最前面追加内容
$("<b>ceshi</b>").prependTo("p"); // 将内容追加到p元素的最前面
```

外部插入

```javascript
$("div").after("<p>ceshi</p>"); // 在同级div元素的最后插入内容
$("div").before("<p>ceshi</p>"); // 在同级div元素的最前面插入内容
$("p").insertAfter("#ceshi"); // 所有p元素插入到id为ceshi元素的后面
$("p").insertBefore("#ceshi"); // 所有p元素插入到id为ceshi元素的后面
```

替换

```javascript
$("p").replaceWith("<b>ceshi. </b>"); // 将匹配到的所有p元素替换成<b>ceshi. </b>（可以是文档内容和标签元素）
$("<b>ceshi. </b>").replaceAll("p"); // 将元素或内容替换给所有选中的p元素
```

删除

```javascript
$("div").empty(); // 删除匹配的div元素中所有的子节点，不包括本身
$("div").remove(); // 删除所有匹配的元素，包括本身
$("div").detach(); // 删除所有匹配的元素（和remove()不同的是:所有绑定的事件、附加的数据会保留下来）
```

复制

```javascript
$("p").clone(); // 生成被选元素的副本，包含子节点、文本和属性
$("p").clone(true); // 可选，布尔值，规定是否复制元素的所有事件处理，默认地，副本中不包含事件处理器。
```

<br>

五、事件

页面载入事件（两种最常见的方式，推荐第一种方法）

```javascript
// 方法一
$(document).ready(function () {
  
});
// 方法二
$(function () {
  
});
```

常用事件

```javascript
$("button").click(); // 单击事件
$("button").dblclick(); // 双击事件
$("input[type=text]").focus(); // input元素获得焦点时，触发focus事件
$("input[type=text]").blur(); // input元素失去焦点时，触发blur事件
$("button").mousedown(); // 当鼠标按下时触发事件
$("button").mouseup(); // 按钮上松开鼠标按键时触发的事件
$("p").mousemove(); // 当鼠标指针在指定元素中移动时触发的事件
$("p").mouseover(); // 当鼠标指针位于元素上方时触发事件
$("p").mouseout(); // 当鼠标指针从元素上方移开时触发事件
$(window).keydown(); // 当键盘按钮被按下时触发事件
$(window).keypress(); // 当键盘或按钮被按下时触发事件，每输入一个字符都触发一次
$("input").keyup(); // 当按钮松开时触发事件
$(window).scroll(); // 当窗口发生滚动时触发事件
$(window).resize(); // 当浏览器窗口大小发生改变时触发事件
$("input[type='text']").change(); // 当元素的值发生改变时触发事件
$("input").select(); // 当元素中的内容被选中时触发事件
$("form").submit(); // 当提交表单时触发事件
$(window).unload(); // 当用户离开页面时触发事件
```

（event object）对象，所有事件函数都可以传入event参数方便处理事件

```javascript
event.pageX // 事件发生时，鼠标距离网页左上角的水平距离
event.pageY // 事件发生时，鼠标距离网页左上角的垂直距离
event.type // 事件的类型
event.which // 按下了哪一个键
event.data // 在事件对象上绑定数据，然后传入事件处理函数
event.target // 事件针对的网页元素
event.preventDefault() // 阻止事件的默认行为(比如点击链接，会自动打开新页面)
event.stopPropagation() // 停止事件向上层元素冒泡

例：
$("p").click(function(event){
  alert(event.type); // 弹出"click"  
}); 
```

<br>

六、动画效果

基本

```javascript
$("p").show(); // 显示匹配的元素
$("p").show("slow"); // 参数表示速度,("slow","normal","fast"),也可为1000毫秒
$("p").hide(); // 隐藏匹配的元素
$("p").toggle(); // 切换匹配元素的显示和隐藏
```

滑动

```javascript
$("p").slideDown("1000"); // 用1000毫秒的时间将元素滑下
$("p").slideUp("1000"); // 用1000毫秒的时间将元素滑上
$("p").slideToggle("1000"); // 用1000毫秒的时间将元素滑上滑下
```

淡入淡出

```javascript
$("p").fadeIn("1000"); // 用1000毫秒的时间将元素淡入
$("p").fadeOut("1000"); // 用1000毫秒的时间将元素淡出
$("p").fadeToggle("1000"); // 用1000毫秒的时间将元素淡入淡出
$("p").fadeTo("slow", 0.6); // 用900毫秒的时间将元素的透明度调整到0.6
```

<br>

对象访问控制

```javascript
$.trim(); // 去除字符串两端的空格
$.each(); // 遍历一个数组或对象，for循环
$.inArray(); // 返回一个值在数组中的索引位置，不存在返回-1  
$.grep(); // 返回数组中符合某种标准的元素
$.extend(); // 将多个对象，合并到第一个对象
$.makeArray(); // 将对象转化为数组
$.type(); // 判断对象的类别（函数对象、日期对象、数组对象、正则对象等等）
$.isArray(); // 判断某个参数是否为数组
$.isEmptyObject(); // 判断某个对象是否为空(不含有任何属性)
$.isFunction(); // 判断某个参数是否为函数
$.isPlainObject(); // 判断某个参数是否为用"{}"或"new Object"建立的对象
$.support(); // 判断浏览器是否支持某个特性
```