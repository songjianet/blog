---
title: vue生命周期钩子
date: 2018-08-30 13:21:40
updated: 2018-08-30 14:41:13
comments: true
categories:
- WEB前端
tags:
- vue
- 生命周期
- 钩子函数
---

关于生命周期钩子对于一些想深入了解vue内部工作原理的人是很重要的。

#### 1. 什么是vue生命周期

vue生命周期就是vue实例从创建到销毁的一个过程，我们一般把这个过程叫做生命周期。详细的来讲就是从<span style="color: red;"> 开始创建，初始化数据，编译模板，挂在dom，渲染，更新，渲染，卸载 </span>的一系列过程。

下面的图片是vue官网对生命周期钩子各个阶段的图解，我在上面写了一些注释以帮助理解。

![lifecycle](lifecycle.png)

#### 2. 钩子函数代码

通过代码，我们把所有的钩子都罗列出来，然后通过浏览器的console进行查看。

```vue
<div id="app1">{{message}}
    <button @click="clickme">点我更新数据</button>
</div>

new Vue({
  el: '#app1',
  data () {
    return {
      message: '生命周期案例'
    }
  },
  beforeCreate () {
    console.log('=====创建前=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  created () {
    console.log('=====已创建=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  beforeMount () {
    console.log('=====mount之前=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  mounted () {
    console.log('=====mount=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  beforeUpdate () {
    console.log('=====更新前=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  updated () {
    console.log('=====更新完成=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  beforeDestroy () {
    console.log('=====销毁前=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  destroyed () {
    console.log('=====销毁后=====')
    console.log('message:' + this.message)
    console.log(this.$el)
  },
  methods: {
    clickme () {
      this.message = '数据已更新'
    }
  }
})
```

<br>下图为浏览器中看到的效果

<br>

![1535610503](1535610503.jpg)

#### 3. 各个钩子函数的作用

##### beforeCreate

vue实例的挂载元素$el和数据对象data都为undefined，还处在没有被初始化的阶段。

##### created

vue实例的数据对象data有了，但是$el还没有。

##### beforeMount

vue实例的$el和data都已经被初始化了，但还是挂载之前的虚拟dom节点，同时数据也并没有被渲染到dom中。

##### mounted

vue实例挂载完成，数据也渲染完成

##### update部分

点击更新数据按钮后，查看控制台和页面

![1535610580](1535610580.jpg)

<span style="color: red;">beforeUpdate中data并没有发生变化</span>

<span style="color: red;">updated中data已经变化</span>

##### beforeDestroy

销毁前所有的实例都是可用状态

##### destroyed

Vue 实例销毁后调用。调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。 该钩子在服务器端渲染期间不被调用。