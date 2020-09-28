---
title: this、apply、call and bind
date: 2019-05-13 10:45:54
updated: 2019-05-13 15:47:10
comments: true
categories:
- WEB前端
tags:
- JavaScript
- this
- apply
- call
- bind
---

本篇文章会详细讲解<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>相关的问题。

> [1] 如果你在阅读中发现错误或者存在某些问题可以通过邮件的形式发送到作者的邮箱，再收到邮件后作者会及时处理这些问题。
>
> [2] 阅读文章后你能了解到的有this 指向、apply、call和bind方法。

------

#### this

在深入了解<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>前，我们要知道<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>在调用函数时能够控制使用不同的上下文环境，同时<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>永远指向最后调用它的对象，在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">EcmaScript</code>中已经有效的规避的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>容易产生的错误，但是在我们阅读某个框架源码的时候，还是要深入了解下<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>。

------

#### 理解this指向

我们通过例子去理解this指向的问题。

例如我们拥有一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">USER</code>的对象，并且通过点号的形式进行调用。

```javascript
const USER = {
  name: 'Taylor',
  age: 34,
  greet() {
    console.log(`name: ${USER.name}`)
    console.log(`name: ${this.name}`)
  }
}

USER.greet()

// 输出结果：
// name: Taylor
// name: Taylor
```

可以看到我们在调用方法的时候相当于把<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>指向了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">USER</code>对象。

```javascript
const STUDENT = {
  name: 'Taylor',
  age: 12,
  greet() {
    console.log(`name: ${STUDENT.name}`)
    console.log(`name: ${this.name}`)
  },
  mother: {
    name: 'Swift',
    age: 35,
    greet() {
      console.log(`name: ${STUDENT.mother.name}`)
      console.log(`name: ${this.name}`)
    }
  }
}

STUDENT.greet()
STUDENT.mother.greet()

// 输出结果：
// name: Taylor
// name: Taylor
// name: Swift
// name: Swift
```

------

#### 改变this指向

能够改变<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>指向的操作有：

- 箭头函数

- 函数内部使用_this = this

- apply

- call

- bind

- new一个对象

  

##### 箭头函数

```javascript
const OBJ = {
  name: 'Taylor',
  time1: function() {
    setTimeout(function() {
      console.log(`name: ${this.name}`) // name: windowName
    }, 0)
  },
  time2: function() {
    setTimeout(() => {
      console.log(`name: ${this.name}`) // name: Taylor
    }, 0)
  }
}

OBJ.time1()
OBJ.time2()
```



##### 函数内部使用_this = this

```javascript
const OBJ = {
  name: 'Taylor',
  time1: function() {
    setTimeout(function() {
      console.log(`NAME: ${this.name}`) // name: windowName
    }, 0)
  },
  time2: function() {
    let _this = this
    setTimeout(function() {
      console.log(`NAME: ${_this.name}`) // name: Taylor
    }, 0)
  }
}

OBJ.time1()
OBJ.time2()
```



##### apply

```javascript
const OBJ = {
  name: 'Taylor',
  time1: function() {
    setTimeout(function() {
      console.log(`NAME: ${this.name}`) // name: windowName
    }, 0)
  },
  time2: function() {
    setTimeout(function() {
      console.log(`NAME: ${this.name}`) // name: Taylor
    }.apply(OBJ), 0)
  }
}

OBJ.time1()
OBJ.time2()
```



##### call

```javascript
const OBJ = {
  name: 'Taylor',
  time1: function() {
    setTimeout(function() {
      console.log(`NAME: ${this.name}`) // name: windowName
    }, 0)
  },
  time2: function() {
    setTimeout(function() {
      console.log(`NAME: ${this.name}`) // name: Taylor
    }.call(OBJ), 0)
  }
}

OBJ.time1()
OBJ.time2()
```



##### bind

```javascript
const OBJ = {
  name: 'Taylor',
  time1: function() {
    setTimeout(function() {
      console.log(`NAME: ${this.name}`) // name: windowName
    }, 0)
  },
  time2: function() {
    setTimeout(function() {
      console.log(`NAME: ${this.name}`) // name: Taylor
    }.bind(OBJ)(), 0)
  }
}

OBJ.time1()
OBJ.time2()
```



##### new绑定

```javascript
function User (name, age) {
  this.name = name
  this.age = age
}

const func = new User('Taylor', 27)
```

------

#### apply和call的区别

- apply接受一个包含多个参数的数组
- call接受多个参数

##### apply传参

```javascript
const OBJ ={
  fn: function(a, b) {
    console.log(a + b) // 3
  }
}

let func = OBJ.fn;
func.apply(OBJ, [1,2])
```



##### call传参

```javascript
const OBJ ={
  fn: function(a, b) {
    console.log(a + b) // 3
  }
}

let func = OBJ.fn;
func.call(OBJ, 1, 2)
```

------

#### bind和apply、call的区别

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">bind</code>方法创建一个新的函数, 当<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">bind</code>被调用时，将其<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>指向为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">bind</code>的第一个参数，在调用新函数时提供剩余参数序列。

```javascript
const OBJ ={
  fn: function(a, b) {
    console.log(a + b) // 3
  }
}

let func = OBJ.fn;
func.bind(OBJ, 1, 2)()
```

