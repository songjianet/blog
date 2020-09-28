---
title: vue-router介绍以及历史模式404问题
date: 2019-03-12 17:03:14
updated: 2019-03-19 17:48:44
comments: true
categories:
- WEB前端
tags:
- vue
- vue-router
- hash
- history
- nginx
---

#### vue-router实现原理

​	路由这个概念早期是后端开发人员提出来的，在传统的模版引擎中，我们经常可以看到如下网址：

```
http://www.xxx.com/login
```

​	在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-router</code>中我们有两种路由模式<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">history</code>。这两种模式都属于浏览器的自身特性，利用这两个特性，通过调用浏览器提供的接口来实现路由的功能。简单来说路由就是用来跟后端服务器进行交互的一种方式，通过不同的路径，来请求不同的资源，请求不同的页面是路由的其中一种功能。

​	但是在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-router</code>中我们还有一种模式叫<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">abstract</code>。该模式支持所有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">javascript</code>运行模式。如果发现没有浏览器的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">API</code>，路由会自动强制进入这个模式，在此篇文章中不做过多解释。

​	随着<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">ajax</code>的技术的流行，我们能够通过不刷新浏览器页面的情况下进行数据的交互操作，甚至更高级的单页面应用——<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">SPA</code>，能够办到不仅仅是页面交互无刷新，还可以是页面跳转无刷新，因此在现如今的前端开发中也就有了路由的概念，但是在2014年前，大家都是通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>来实现路由的。



#### hash介绍

​	<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>模式路由使用的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">URL</code>的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>值来作为路由，该模式的路由地址中会存在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">#</code>号，能够支持所有的浏览器，并且兼容<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">IE8</code>。该模式背后的原理是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">onhashchange</code>，在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">window</code>上我们能够通过编写方法监听该事件。

​	<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">#</code>号后面的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>值的变化，并不会导致浏览器向服务器发出请求，浏览器不发出请求，就不会刷新页面。同时<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>的变化会出发<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">onhashchange</code>时间，通过这个事件我们就会知道<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>值发生了哪些变化，通过这些变化来实现页面部分内容的操作。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>test</title>
    <style>
        #bg-color {
            width: 200px;
            height: 200px;
        }
    </style>
</head>
<body>
    <div id="bg-color"></div>
    <script>
        window.location.hash = 'yellow'
        window.onhashchange = (event) => {
            console.log(event.oldURL, event.newURL)
            let hash = location.hash.slice(1)
            let hash1 = window.location.hash
            console.log(hash, hash1)
            document.getElementById('bg-color').style.backgroundColor = hash
        }
    </script>
</body>
</html>
```

![1552403988863](/blog/vue-router介绍以及历史模式404问题/1552403988863.jpg)



#### history介绍

​	在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">h5</code>发布之后，多出了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">pushState</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">replaceState</code>两个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">API</code>，通过这两个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">API</code>可以改变链接地址且不发送请求，同时多出一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">popstate</code>事件。历史模式路由可以分为三大部分，分别是切换、修改、拦截，并且改模式的路由只能兼容到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">IE10</code>。

​	<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">history</code>不同于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>的地方在于，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>是拿来做页面定位的，如果拿来做路由，锚点功能就不能用了，而且<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hash</code>传参是基于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">URL</code>的，如果传递复杂的数据会有体积的限制，而<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">history</code>不仅可以把数据放入到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">URL</code>中，也可以将数据存放在一个特定的对象中。

##### 相关API

```javascript
window.history.go(-2); // 后退两次
window.history.go(2); // 前进两次
window.history.back(); // 后退
window.history.forward(); // 前进
window.history.lengthk(); // 查看当前历史堆栈中的页面数量

window.history.pushState(state, title, url)
// state: 需要保存的数据，这个数据在触发popstate事件时，可以在event.state里获取
// title：标题，基本没用，一般传 null
// url：设定新的历史记录的 url。新的 url 与当前 url 的 origin 必须是一樣的，否则会抛出错误。url可以是绝对路径，也可以是相对路径

window.history.replaceState(state, title, url)
// 与 pushState 基本相同，但她是修改当前历史记录，而 pushState 是创建新的历史记录

window.addEventListener("popstate", () => {
    // 监听浏览器前进后退事件，pushState 与 replaceState 方法不会触发              
})
```



#### history模式下的404问题

​	对于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>项目的开发环境下，我们使用历史模式路由是不会存在问题的，因为我们使用的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node</code>服务器，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dev</code>中已经配置好了，但是我们在生产环境对项目打包后部署在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">nginx</code>上的时候，点击刷新或者其他操作的时候有可能会出现404页面的问题，遇到这种问题我们可以在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">nginx</code>中增加如下配置信息就可以解决：

```nginx
location / {
    root   /data/nginx/html;
    index  index.html index.htm;

    if (!-e $request_filename) {
        rewrite ^/(.*) /index.html last;
        break;
    }
}
```

