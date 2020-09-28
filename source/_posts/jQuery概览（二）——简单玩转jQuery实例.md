---
title: jQuery概览（二）——简单玩转jQuery实例
date: 2018-02-02 11:51:13
updated: 2018-05-15 11:20:31
comments: true
categories:
- WEB前端
tags:
- 返回顶部效果
- 左侧导航菜单
- tab切换
---

本文介绍一下基本的jQuery的经典案例，大家可以用来参考，本文具有一定的参考价值，在实际的开发中会遇到很多类似的功能，我在这里实现了一些常用功能，可以供大家参考，后续还会在这篇文章中更新其他常用功能，大家可以收藏我的博客，继续关注

一、返回顶部效果

```html
<!DOCTYPE html>
<html>
<head>
	<title>向上滚动</title>
	<style type="text/css">
		.divB{
			height: 2500px; 
			width: 100%;
			background-color: green;
		}
		.divG{
			width: 50px;
			height: 50px;
			color: #ffffff;
			position: fixed;
			bottom: 30px;
			right: 30px;
			background-color: red;
			cursor: pointer;
		}
		.hideG{
			display: none;
		}
	</style>
	<script type="text/javascript" src="jquery-3.3.1.min.js"></script>
</head>
<body>
	<div class="divB"></div>
	<div class="divG hideG" onclick="gotoTop();">返回顶部</div>

	<script type="text/javascript">
		$(document).ready(function() {
			var returnTop = $(window).scrollTop();
			if (returnTop > 180) {
				$(".divG").removeClass('hideG');
			}else{
				$(".divG").addClass('hideG');
			}
		});

		function gotoTop() {
			$(window).scrollTop(0);
		};
	</script>
</body>
</html>
```

<br>

二、左侧导航菜单

```html
<!DOCTYPE html>
<html>
<head>
	<title>左侧菜单</title>
	<style type="text/css">
		.hide{
			display: none;
		}
	</style>
	<script type="text/javascript" src="jquery-3.3.1.min.js"></script>
</head>
<body>
	<div>
		<div>
			<div onclick="showMenu(this);">菜单一</div>
			<ol class="con">
				<li>111</li>
				<li>111</li>
				<li>111</li>
			</ol>
		</div>
		<div>
			<div onclick="showMenu(this);">菜单二</div>
			<ol class="con hide">
				<li>111</li>
				<li>111</li>
				<li>111</li>
			</ol>
		</div>
		<div>
			<div onclick="showMenu(this);">菜单三</div>
			<ol class="con hide">
				<li>111</li>
				<li>111</li>
				<li>111</li>
			</ol>
		</div>
	</div>

	<script type="text/javascript">
		function showMenu(self){
         	$(self).next().removeClass('hide').parent().siblings().children('.con').addClass('hide');
		}
	</script>
</body>
</html>
```

<br>

三、tab切换

```html
<!DOCTYPE html>
<html>
<head>
	<title>tab切换</title>
	<style type="text/css">
		.hide{
			display: none;
		}
		.clickMenu{
			color: red;
		}
	</style>
	<script type="text/javascript" src="jquery-3.3.1.min.js"></script>
</head>
<body>
	<div class="tab">
		<ol class="title">
			<li zidingyi="c1" class="clickMenu" onclick="clickMenu(this);"></li>
			<li zidingyi="c2" onclick="clickMenu(this);"></li>
			<li zidingyi="c3" onclick="clickMenu(this);"></li>
		</ol>
		<div class="content">
			<div id="c1">c1内容</div>
			<div id="c2" class="hide">c2内容</div>
			<div id="c3" class="hide">c3内容</div>
		</div>
	</div>

	<script type="text/javascript">
		function clickMenu(self) {
			$(self).addClass('clickMenu').siblings().removeClass('clickMenu');
			$("#" + $(self).attr('zidingyi')).removeClass('hide').siblings().addClass('hide');
		}
	</script>
</body>
</html>
```