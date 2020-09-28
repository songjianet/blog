---
title: jQuery案例（二）动态添加删除搜索标签，封装标签文本到数组
date: 2018-02-05 17:20:13
updated: 2018-05-15 11:18:24
comments: true
categories:
- WEB前端
tags:
- push
---

本篇文章介绍一下jQuery动态添加搜索标签，删除搜索标签，封装标签文本到数组（需要引bootstrap和jQuery查看效果），在实际开发项目中有很大的可能性遇到标签搜索的功能，通过这个例子可以为大家提供一个针对标签搜索的思路

HTML代码：

```html
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<style type="text/css">
		.add_fljl{
			margin: 20px 0px;
		}
		.fljl_list > div{
			float: left;
			max-width: 200px; 
			margin-bottom: 20px;
			margin-right: 20px;
		}
		.a_fljl{
			padding: 7px 10px;
			background-color: #337ab7;
			color: #ffffff;
		}
		.a_fljl > span:first-child{
			padding: 0px 5px;
		}
		.a_fljl > span:last-child{
			padding: 0px 5px;
			cursor: pointer;
		}
	</style>
	<script type="text/javascript" src="jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="bootstrap-3.3.7-dist/css/bootstrap.min.js"></script>
</head>
<body>
	<div class="col-md-12">
		<form class="form-inline add_fljl">
			<div class="form-group">
				<label>关键词标签：</label>
				<input class="fljl_input"><input class="search_fljl" type="button" value="添加关键词"><input class="up_chart" type="button" value="封装成数组">
			</div>
		</form>
		<div class="fljl_list">
			
		</div>
	</div>

	<script type="text/javascript">
		$(".search_fljl").click(function(){
			if($(".fljl_input").val() == ''){ // 判断输入是不是空
				alert("请在输入框内输入需要搜索的名字标签");
			}else{
				$(".fljl_list").append("<div><span class=\"a_fljl\"><span class=\"fljl_name\">" + $(".fljl_input").val() + "</span><span onclick=\"del_fljl(this);\"><span class=\"glyphicon glyphicon-trash\"  aria-hidden=\"true\"><span></span></span></div>");
			}
		});
		// 删除一个标签
		function del_fljl(self){
			var m = confirm("是否删除" + $(self).prev().text() + "标签");
			if (m == true){
				alert("已删除");
				$(self).parent().parent().remove();
			}else{
				alert("已取消删除");
			}
		}
		// 封装成数组
		$(".up_chart").click(function(){
			var goto_action = [];
			$('.fljl_list').find('.fljl_name').each(function() {
				goto_action.push($(this).text());
			});
			alert(goto_action);
		});
	</script>
</body>
</html>
```

<br><br>

![效果展示](/blog/images/jQuery案例（二）动态添加删除搜索标签，封装标签文本到数组/zhanshi.gif)
