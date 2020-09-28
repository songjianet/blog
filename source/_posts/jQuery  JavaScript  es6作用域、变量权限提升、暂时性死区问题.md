---
title: jQuery / JavaScript / es6作用域、变量权限提升、暂时性死区问题
date: 2018-04-23 14:29:33
updated: 2018-05-15 11:16:49
comments: true
categories:
- WEB前端
tags:
- jQuery
- JavaScript
- ECMAScript 6
---

继上篇文章<a href="http://120.79.151.66:4000/2018/04/23/jQuery%20%20JavaScript%E5%BE%AA%E7%8E%AF%E8%BF%AD%E4%BB%A3%E5%8F%98%E9%87%8F%E5%AF%BC%E8%87%B4%E5%86%85%E5%AD%98%E6%B3%84%E6%BC%8F%E9%97%AE%E9%A2%98/">jQuery / JavaScript循环迭代变量导致内存泄漏问题</a>后，有很多的问题没有给大家解释清楚，这篇文章将会详细的介绍三种关于变量的遗留性问题，需要大家在编写代码的时候提高警惕性。

##### 作用域

在<a href="http://120.79.151.66:4000/2018/04/23/jQuery%20%20JavaScript%E5%BE%AA%E7%8E%AF%E8%BF%AD%E4%BB%A3%E5%8F%98%E9%87%8F%E5%AF%BC%E8%87%B4%E5%86%85%E5%AD%98%E6%B3%84%E6%BC%8F%E9%97%AE%E9%A2%98/">jQuery / JavaScript循环迭代变量导致内存泄漏问题</a>文章中我们提到了作用域的问题，在这里会进行更详细的讲解。

首先，<span style="red">在JavaScript和jQuery中只有全局作用域和函数作用域，es6中新增了块级作用域</span>，同样es6引入了一个新的定义变量的方式是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">let</code>。这个变量的声明只会作用于当前的作用域之中，如果用这个变量声明的方式去一个变量，那么这个变量就存在块级作用域。我们可以看看下面的代码

```javascript
{
    var a = 10;
    let b = 20;
}
console.log(a);
console.log(b);
// 输出结果：a = 10
// 输出结果：b is not defined
```

<br />

```javascript
{
    var a = 10;
    let b = 20;
}
{
    console.log(a);
    console.log(b);
}
// 输出结果：a = 10
// 输出结果：b is not defined
```

经过上面的两段代码我们可以看出JavaScript和jQuery的弊端，及用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">var</code>生命的变量不存在块级作用域。而用es6声明方式定义的变量存在块级的作用域，在其他的代码块中无法使用该变量。

##### 变量权限提升

变量的权限提升指的是在没有声明变量的时候就对变量进行使用，这里需要注意的是，我们都知道<span style="red">JavaScript、jQuery、es6都是按照顺序从上到下执行的语言，当中间某一行出现错误，程序将中指，不会继续运行</span>。而在JavaScript和jQuery中如果出现变量权限的提升情况，控制台并不会进行报错，而会输出一个undefined，程序并不会终止，将会继续运行。在es6中如果出现这种情况，控制台会输出ReferenceError错误，我们可以看下面的代码

```javascript
console.log(foo);
var foo = 2;

console.log(bar);
let bar = 2;
// 输出结果：foo = undefined
// 输出结果：bar is note defined
```

##### 暂时性死区

所谓暂时性死区是指只要块级作用域内存在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">let</code>命令，那么这个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">let</code>就绑定了这个块级作用域，当这个块级作用域内存在对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">let</code>的变量权限提升就称之为暂时性死区

```javascript
var tmp = 123;
if (true) {
    tmp = 'abc';
    let tmp;
}
// 输出结果：tmp is note defined
```

关于暂时性死区的其他情况我们可以查看<a href="http://es6.ruanyifeng.com/#docs/let">es6官方文档</a>