---
title: jQuery案例（一）动态添加表单，获取表单的值，封装Json
date: 2018-01-26 9:26:13
updated: 2018-05-15 11:18:57
comments: true
categories:
- WEB前端
tags:
- Json
- 动态添加表单
---

本篇文章介绍一下jQuery动态添加表单，获取表单的值，封装Json的方法（代码命名带有一些娱乐性，本段代码完全是在给朋友讲解的过程中手敲的，起名并不太规则），jQuery请自行引用。（注：代码可能不是最精简的方式）

HTML代码：

```html
<button type="button" name="chuxianba" id="chuxianba">chuxianba</button>
<input type="submit" name="submit" id="submit" value="tijiao">
<div class="input-frame"></div>
```

jQuery代码：

```javascript
var onclickNum = 0; // 迭代变量
var getInputName = []; // Json的键
var getInputval = []; // Json的值
var html = '';
var toJson = '';
// 动态添加网页输入框结构
$("#chuxianba").click(function () {
  onclickNum ++;
  html += '<div id="frame' + onclickNum + '"><input type="text" name="hh' + onclickNum + '"></div>';
  $(".input-frame").html(html);
});
// 直接循环拼装成Json，没有用到字符串转Json方式，当然也可以使用
$("#submit").click(function () {
  toJson += '[{';
  for ( ; onclickNum > 0; onclickNum --){
    // 动态拼接选择器，获取input的name值给getInputName数组
    getInputName[onclickNum] = $("#frame" + onclickNum +  "> input").attr("name"); 
    // 动态拼接选择器，获取input的输入值
    getInputval[onclickNum] = $("#frame" + onclickNum +  "> input").val();
    // 迭代器默认为0（没有使用状态），第一次使用为1，累加。所以根据Json格式，最后一个是没有“，”号的，所以迭代器小于2的时候是没有“，”号的拼接
    if(onclickNum < 2){
      toJson += '"' + getInputName[onclickNum] + '":"' + getInputval[onclickNum] + '"';
    }else{
      toJson += '"' + getInputName[onclickNum] + '":"' + getInputval[onclickNum] + '",';
    }
  }
  toJson += '}]';
  // 弹出拼接好的Json串
  alert(toJson);
  window.location.reload();
  // 没有后台的时候使用重载页面的方式，如果有后台form提交到action的时候需要return返回一个页面，返回页面实际就是重新载入页面，ajax提交成功的时候，会清空表单，重新等待下一条信息的输入，所以会选择重载页面（在不是动态添加表单数量的时候且用ajax提交的时候，我们可以在提交成功的时候直接清空表单数据也是可以的）
});
```