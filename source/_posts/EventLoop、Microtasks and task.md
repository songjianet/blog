---
title: EventLoop、MicroTasks and MacroTask
date: 2019-04-03 14:33:14
updated: 2019-04-18 17:14:08
comments: true
categories:
- WEB前端
tags:
- JavaScript
- EventLoop
- Stack
- Queue
- Synchronous
- Asynchronous
- MicroTasks
- MacroTask

---

本篇文章主要讲解一下<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>中的事件循环机制以及深入讲解异步任务中的宏任务和微任务。

> [1] 如果你在阅读中发现错误或者存在某些问题可以通过邮件的形式发送到作者的邮箱，再收到邮件后作者会及时处理这些问题。
>
> [2] 阅读文章你需要了解的专业术语有事件循环机制（EventLoop）、栈（Stack）、队列（Queue）、微任务（MicroTasks）、宏任务（MacroTask）、同步任务（Synchronous）、异步任务（Asynchronous）。

------

#### 基本概念

- JavaScript是单进程的脚本语言；
- EventLoop是JavaScript中的事件循环机制（执行机制）；
- Stack栈是一种先进后出（FILO）的数据结构；
- Queue队列是一种先进先出（LILO）的数据结构；
- Synchronous是JavaScript中的同步任务；
- Asynchronous是JavaScript中的异步任务；
- MicroTasks是JavaScript异步中的微任务；
- MacroTask是JavaScript异步中的宏任务；

------

#### Stack and Queue

##### 基本介绍

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Stack</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Queue</code>都是两种基本的数据结构，而常用的数据结构有八种，其余六种数据结构分别是：数组（Array）、散列表（Hash）、树（Tree）、链表（Linked List）、堆（Heap）、图（Graph）。

##### Stack

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Stack</code>是一种先进后出（FILO）的数据结构，有且只有一个指向栈顶的指针，对栈的操作只能操作栈顶，不能操作栈底。<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Stack</code>是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">EventLoop</code>在执行的上下文中将所有的函数以入栈和出栈的形式进行编排。所有种类函数在执行前进行入栈，执行后进行出栈，如果遇到异步函数操作，V8和JavaScript引擎会将其交给事件表和事件队列（在该环节不做过多解释，可在下一环节找到详细的解释）。

```javascript
function test_1(a) {
  return a * 3
}
function test_0(b) {
  return test_1(4) * 2
}
console.log(test_0(3))
```

我们可以通过下面的图片去了解入栈和出栈的规则，当理解了栈的规则后，就可以很清晰的看出上面代码的输出结果。

![栈的执行流程](/images/EventLoop、Microtasks%20and%20task/stack.gif)

##### Queue

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Queue</code>是一种先进先出（LILO）的数据结构，拥有一个指向队首和队尾的指针，队列既能操作队首也能操作队尾。

------

#### EventLoop

首先我们要知道<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>是单线程的。我们可以把单线程理解为一个自动售票机，购票者需要自觉排队购票，如果其中有一个购票者第一次使用自动售票机的情况下会因为不熟练而使得该购票者购票时间相对较长，无论该购票者用了多少时间，后面的人依旧要进行排队购票。

![排队购票示例图](/images/EventLoop、Microtasks%20and%20task/1554278130031.jpg)

回归到浏览器和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>本身，如果我们有一个新闻页面，如果需要加载大量的图片并且在图片没有完全加载出来的时候我们不能让浏览器卡着什么都不显示，所以就有人提出了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Synchronous</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Asynchronous</code>。

------

#### Synchronous and Asynchronous

##### 基本介绍

- Synchronous（同步任务）包含：DOM，CSS，promise；
- Asynchronous（异步任务）包含：promise的then，setTimeout，setInterval等；
- Asynchronous（异步任务）进入事件表注册回调函数到事件队列，此队列是先进先出队列；
- JavaScript首先区分同步任务和异步任务，同步任务直接执行，异步任务进入事件表；
- JavaScript优先执行同步任务；
- 进入到事件表的异步任务会注册回调函数到事件队列；
- 当JavaScript执行完全部的同步任务后，会判断事件队列中是否有待执行的任务；

##### 代码示例

为了更清晰的解释同步和异步的执行，首先我们来看一段代码，通过代码进行理解：

```javascript
console.log('start');
setTimeout(() => {
  console.log('setTimeout')
  test()
}, 0);
function test () {
  console.log('test');
}
console.log('end');
// 输出：start，end，setTimeout，test
```

通过上面的代码会发现这和传统理解<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>是从上到下执行是相悖的，为此可以查看下面的流程图进行详细的流程分析。

![同步异步执行示例图](/images/EventLoop、Microtasks%20and%20task/1554282142999.jpg)

------

#### MicroTasks and Macrotask

##### 基本介绍

- MicroTasks（微任务）包括promise的then；
- Macrotask（宏任务）包括script、setTimeout、setInterval；
- MicroTasks（微任务）和Macrotask（宏任务）进入的是两个不同的事件队列；
- 当Synchronous（同步任务）执行完毕后会去判断事件队列中是否有待执行的函数，如果有待执行的函数后要判断事件队列中是否有MicroTasks Queue（微任务队列）和Macrotask Queue（宏任务队列），如果存在则先执行MicroTasks Queue（微任务队列）中的函数；

由于这是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">EventLoop</code>中最细致的地方，所以下面会列举出比较常用的例子。

##### setTimeout

Synchronous（同步任务）完成后立即执行的setTimeout：

```javascript
setTimeout(() => {
  console.log('setTimeout')
}, 0);
// 输出：setTimeout
```

Synchronous（同步任务）完成后延迟立即执行的setTimeout：

```javascript
setTimeout(() => {
  console.log('setTimeout')
}, 5000);
// 等待5s后输出：setTimeout
```

<span style="color: red;">注：即使我们给setTimeout延迟5s执行，实际的环境中绝大多数是大于这个时间的，例如一个延迟一秒的setTimeout中有个ajax方法，setTimeout会等待ajax请求完毕后再去执行，这段期间即使超过一秒了，但是里面的ajax受网络环境影响并没有及时返回，这时setTimeout的延迟时间。</span>

##### setInterval

此函数与<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">setTimeout</code>相似，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">setInterval</code>是每隔一段时间讲函数注入到事件表中，在判断是什么类型任务进入不同的事件队列。

##### promise

promise的功能在此不再赘述，如果想详细了解可以阅读<a href="http://es6.ruanyifeng.com/#docs/promise" style="color: blue">阮一峰ECMAScript 6 入门中的Promise 对象章节</a>。


##### 代码示例

宏任务和微任务进入不同队列且微任务优先执行：

```javascript
setTimeout(() => {
  console.log('setTimeout1')
},0)
let p = new Promise((resolve,reject) => {
  console.log('promise1')
  resolve()
})
p.then(() => {
  console.log('promise2')    
})
setTimeout(() => {
  console.log('setTimeout2')
},0)
// 输出：promise1，promise2，setTimeout1，setTimeout2
```

上面的代码的执行流程为：

1. promise1为同步任务直接打印；
2. promise2进入微任务队列；
3. setTimeout1进入宏任务队列；
4. setTimeout2进入宏任务队列；
5. promise2打印（优先执行微任务）；
6. setTimeout1打印；
7. setTimeout2打印；

嵌套任务：

```javascript
Promise.resolve().then(() => {
  console.log('Promise1')  
  setTimeout(() => {
    console.log('setTimeout2')
  },0)
})

setTimeout(() => {
  console.log('setTimeout1')
  Promise.resolve().then(() => {
    console.log('Promise2')    
  })
},0)
// 输出：Promise1，setTimeout1，Promise2，setTimeout2
```

上面的代码的执行流程为：

1. promise1进入微任务队列；
2. setTimeout1进入宏任务队列；
3. 打印promise1，setTimeout2进入宏任务队列；
4. 打印setTimeout1，promise2进入微任务队列；
5. 打印promise2；
6. 打印setTimeout2；

------

#### 综合示例

首先我们来看一段终极代码，了解完整的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">EventLoop</code>执行流程：

```javascript
console.log('1');

setTimeout(() => {
	console.log('2');
	new Promise((resolve) => {
		console.log('3');
		resolve();
	}).then(() => {
		console.log('4')
	})
})

new Promise((resolve) => {
	console.log('5');
	resolve();
}).then(() => {
	console.log('6')
})

function test() {
	console.log('7')
	setTimeout(() => {
		console.log('8');
		new Promise((resolve) => {
			console.log('9');
			resolve();
		}).then(() => {
			console.log('10')
		})
    console.log('11')
	})
}

console.log('12');
test();
// 输出：1，5，12，7，6，2，3，4，8，9，11，10
```

------

#### 总结

当<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>开始执行时候会将所有函数押入执行栈，其中同步任务按序执行，异步任务加入事件表，事件表把函数分为宏任务和微任务将其回调函数分别压入不同的事件队列。当同步任务执行完毕后，引擎会检查是否存在异步任务，如果不存在则程序结束。如果存在判断是否有微任务，没有的情况下直接执行宏任务队列，有微任务的情况下，优先执行微任务队列里面的函数。

![终极图片](/images/EventLoop、Microtasks%20and%20task/1554364051301.jpg)
