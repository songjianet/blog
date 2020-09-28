---
title: jQuery / JavaScript循环迭代变量导致内存泄漏问题
date: 2018-04-23 14:17:07
updated: 2018-05-15 11:18:05
comments: true
categories:
- WEB前端
tags:
- jQuery
---

##### jQuery / JavaScript循环迭代变量导致内存泄漏问题

这篇文章讲解下jQuery / JavaScript的弊端导致的内存泄漏问题，这个问题很容易被忽略，如果不被重视网站安全会有很大的危险性，希望各位能够认真对待。

```javascript
// 通常情况下我们使用jQuery / JavaScript去做一个循环的时候，我们会这样写。
for (var i = 0; i < 10; i++) {
    
}
```

这时，很多人就会问，“这个很正常啊，我们都写了很多年了，难不成还有什么问题”——来自我的一个工作了三年的同事。当然存在问题了，而且是很大的问题，在如今的信息化时代，网络安全性是很重要的，这样定义变量会存在很严重的内存泄漏问题。我们可以这样修改下程序，增加个输出的口

```javascript
for (var i = 0; i < 10; i++) {
    
}
console.log(i);
// 输出结果：10
```

这时发现问题了，为什么我定义在for循环里的迭代变量在循环外为什么会有值，别着急，我们可以走下断点查看

![第一次循环i的值](1-firstfor.png)

![第二次循环i的值](1-secondfor.png)

这时，细心的人一定发现了，为什么在循环外的i会有值输出，当然还会有更认真的人去调试这段程序，这时你会发现，代码会循环10次，每次的值分别是（1，2，3，4，5，6，7，8，9，10）。

当然出现这种问题的原因是作用域，JavaScript和jQuery只有全局作用域和函数体内作用域，没有块级作用域。块级的作用域是在es6中引入的，所以我们的循环变量i相当于一个全局变量，在任何地方都能取到值。我们可以看下面的两个例子

```javascript
for (var i = 0; i < 10; i++) {

}
ceshi(i);
function ceshi (i) {
	console.log(i);
}
// 输出结果：10
```

```javascript
for (var i = 0; i < 10; i++) {
    
}
var ceshi = (params) => params * params;
console.log(ceshi(i));
// 输出结果：100
```

如果我们想要改善这段代码，最好的方式就是用es6的let方式定义循环的迭代变量，我们可以这样写。

```javascript
for (let i = 0; i < 10; i++) {
    
}
console.log(i);
// 输出结果：i is not defined
```