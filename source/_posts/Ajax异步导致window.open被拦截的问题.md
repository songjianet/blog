---
title: Ajax异步导致window.open被拦截的问题
date: 2018-05-04 11:36:38
updated: 2018-05-15 11:00:02
comments: true
categories:
- WEB前端
tags:
- Ajax
- jQuery
- window.open()
---

##### 问题介绍

这个问题的出现最根本的原因就是网页中的广告，让我在开发中耽误了半天的时间去找为什么异步成功回调后window.open()会被拦截。现在很多页面的广告都是通过Ajax异步成功的方式跳转到一个广告的页面，所以例如谷歌浏览器，火狐浏览器等很多浏览器就会为自身安全性增加对异步跳转的拦截（注：360浏览器暂时还没有对这个功能的拦截）。首先，先让大家看看代码

```javascript
function addlogs (url, module_name, title) {
    $.ajax({
        type: "post",
        url: $("#ctx").val() + "/addlogs",
        data: {url:url,module_name,title},
        success: function(result) {
            var success = result.success;
            if(success){
                window.open(url); 
            }
        }
    });	
}
```

上面的这段代码是增加信息点击数量的功能，这个代码在Ajax成功后进行了页面打开的操作，就是因为这个操作一些浏览器会认为打开的这个页面是广告，所以就被拦截了。我在网上找了半天时间也没有发现什么有用的方法，有说加定时器等等，经过我的尝试都没有解决我的问题，可能是开发情况不一样导致的。最后看到了浏览器装的屏蔽广告的插件突发奇想，百度了一下屏蔽广告插件的原理，为此尝试将Ajax改成同步请求，结果成功了

```javascript
async: false, 
```