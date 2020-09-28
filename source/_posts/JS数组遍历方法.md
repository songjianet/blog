---
title: JS数组遍历方法
date: 2018-12-20 09:52:30
updated: 2019-06-27 22:40:46
comments: true
categories:
- WEB前端
tags:
- js
- ECMAScript 6
---

##### 介绍

所谓的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JS高阶函数</code>就是《JavaScript高级程序设计》中提到的六种迭代方法，这六种方法有着很广泛的应用，尤其是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">forEach</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">map</code>。其实学会这六种方法之后我们在一些时候就可以完全的抛弃<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">for</code>循环，当然有些时候<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">for</code>循环还是必不可少的东西。但是对于初学者来说这些迭代方法都很像，很难看出来什么区别，不免会觉得头大。

##### map

简单理解：让数组通过某种计算产生一个新数组

示例：

```javascript
arr.map(function (item, index) {
    return item * 2
})
// 返回数组中每一项乘以2后的值
```

##### forEach

简单理解：让数组中的每一项做一件事

示例：

```javascript
arr.forEach(function (item, index) {
    console.log(item)
})
// 打印数组中每一项的值
```

##### filter

简单理解：筛选出数组中符合条件的项组成新数组

示例：

```javascript
arr.filter(function (item, index) {
    return item > 3
})
// 返回数组中大于3的项
```

##### reduce

简单理解：让数组中的前项和后项做某种计算，并累计最终的值

示例：

```javascript
arr.reduce(function (prev, next) {
    return prev + next
})
// 计算出数组中所有项的和
```

##### every

简单理解：检测数组中的每一项是否符合条件

示例：

```javascript
arr.every(function (item, index) {
    return item > 0
})
// 每一项都满足条件才会返回true
```

##### some

简单理解：检测数组中是否有某些项符合条件

示例：

```javascript
arr.some(function () {
    return item > 0
})
// 只要数组中有一项符合条件就会返回true
```

##### set（补充介绍）

简单理解：用于去重操作，以及构造数据结构

示例：

```javascript
new Set(arr)
// 对数组中的重复项去重
```

