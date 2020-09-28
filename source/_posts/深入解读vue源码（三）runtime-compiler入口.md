---
title: 深入解读vue源码（三）runtime-compiler入口
date: 2019-05-16 10:28:46
updated: 2019-05-16 17:19:28
categories:
- WEB前端
tags:
- vue
---

#### 基本介绍

上篇文章较为全面的介绍了整个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>源码在执行<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">build</code>过程中的构建过程，在文章的最后还介绍了两种不同的构建方式，分别是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime only</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime compiler</code>。

值得注意的是这两种构建方式都是基于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">web</code>环境参数下的构建方式，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">weex</code>并不在这个范围内。

本篇文章我们会对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime compiler</code>这种构建方式的入口进行分析，之所以选择这种构建方式介绍是因为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime compiler</code>相对于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime only</code>来说多了个编译器的功能，在这篇文章中都会一并介绍。

简单来说<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>就是一个方法类，在这个方法中挂载了一些<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>自带的方法等。

------

#### 程序入口解析

##### entry-runtime-with-compiler分析

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">entry-runtime-with-compiler</code>文件是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime compiler</code>构建方式下的入口文件，该文件路径在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platforms/web/</code>下。

下面的代码是从<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">entry-runtime-with-compiler</code>中抽象出来的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mount</code>方法。这种能够表达代码结果和逻辑的代码我们称之为伪代码。伪代码并不能通过编译器的检查，更不能运行。

```javascript
const mount = Vue.prototype.$mount
Vue.prototype.$mount = function (el?: string | Element, hydrating?: boolean): Component {
	......
  const options = this.$options // new Vue(options)提供的实参options
  if (!options.render) { // 使用实例化Vue时提供render函数，不是render函数的情况下进入
    if (template) { // 如果没有提供render函数，则优先使用提供的template选项
      ......
    } else if (el) { // 既没有提供render函数，又没有template选项，就使用el选项
      template = getOuterHTML(el)
    }
  }
  ......
  return mount.call(this, el, hydrating)
}
```

上面的这段伪代码用于将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">html</code>模板编译成<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>函数，并且把<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法定义在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">prototype</code>上，使得每一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new</code>出来的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>实例都能使用此方法。

```javascript
function getOuterHTML (el: Element): string {
  if (el.outerHTML) {
    return el.outerHTML
  } else {
    const container = document.createElement('div')
    container.appendChild(el.cloneNode(true))
    return container.innerHTML
  }
}
```

上面这段代码主要是得到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">html</code>代码片段，它能够处理以下四种写法。

下面的这段代码，就是我们在使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>时候在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">main.js</code>最下面<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new</code>的一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>实例。

```javascript
{el: '#index'}
{el: document.querySelector('#index')}
{template: '#index'}
{template: '<div>{{msg}}</div>'}           
```

到这里基本讲解了下<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">entry-runtime-with-compiler</code>这个文件，我们通过引入的方式找到入口的核心。

```javascript
// src/platforms/web/entry-runtime-with-compiler.js
import Vue from './runtime/index'
// src/platforms/web/runtime/index.js
import Vue from 'core/index'
```

在这个文件中还有一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">compileToFunctions</code>方法，这个方法是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mount</code>方法内调用，通过编译器将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">html</code>转换为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>函数的方法，在此就先不在赘述。

##### src/core/index分析

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">core/index.js</code>是核心代码的入口。

```javascript
import Vue from './instance/index'
import { initGlobalAPI } from './global-api/index' // 全局api
import { isServerRendering } from 'core/util/env' // 布尔类型变量，判断是否是ssr
......

initGlobalAPI(Vue) // 开始执行初始化全局变量

// 为vue原型定义$isServer方法
Object.defineProperty(Vue.prototype, '$isServer', {
  get: isServerRendering
})

// 为vue原型定义$isServer方法
Object.defineProperty(Vue.prototype, '$ssrContext', {
  get () {
    /* istanbul ignore next */
    return this.$vnode && this.$vnode.ssrContext
  }
})

......

Vue.version = '__VERSION__'

export default Vue
```

##### src/core/instance/index分析

该文件定义了一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的类，然后又调用了一系列<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">init</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mixin</code>这样的方法来初始化一些功能，具体的在之后的文章中我们再进行深入的分析。

------

#### 总结

这篇文章简单的介绍了下<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的入口，后续的文章会对每一部分进行详细的介绍。