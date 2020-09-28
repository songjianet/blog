---
title: jQuery调试方式
date: 2018-04-23 9:53:25
updated: 2018-05-15 11:21:17
comments: true
categories:
- WEB前端
tags:
- jQuery
- jQuery debug
---

##### 调试工具介绍（谷歌浏览器的js调试方式）

首先，我要讲解的是jQuery的常见问题和弊端，那就离不开能够调试jQuery的debug工具，由于jQuery是脚本化的客户端程序，所以很多ide都没有对jQuery提供debug程序，当然我相信未来还是会有的。不过这些都没有关系，我们可以试用谷歌浏览器的js调试程序对jQuery的运行进行调试。

我在浏览器中打开了一个名为es6.html的页面，里面的内容为sublime中的内容

![浏览器打开es6.html页面](/blog/jQuery调试方式/webOpenHtml.png)

![sublime打开es6.html页面](/blog/jQuery调试方式/sublimeOpenHtml.png)

然后在浏览器中按F12调用调试台，点击Sources选项，之后在代码的行号位置，可以通过单击的方式选择断点的位置

![打开控制台选择Sources选项，之后在代码想要调试的行号进行单击](/blog/jQuery调试方式/caozuo.png)

之后可以在右上角找到调试的基本操作，在这里我就不多说了，大家可以自己进行尝试

![debug](/blog/jQuery调试方式/debug.png)
