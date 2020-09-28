---
title: 深入解读vue源码（六）render
date: 2019-06-28 10:04:37
updated: 2019-07-03 14:18:17
categories:
- WEB前端
tags:
- vue
---

#### 基本介绍

所谓<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>其实是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的一个私有方法，这个方法用来将实例<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>转换成虚拟的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node</code>，这个方法的定义在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/render.js</code>文件中。

------

#### render的实现

首先在源码中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/index.js</code>方法中，能够看到关于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">renderMixin</code>这个方法。

```typescript
import { renderMixin } from './render'
...
renderMixin(Vue)
```

通过导入我们能够找到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">renderMixin</code>方法的定义，在这个方法里面能够看到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Vue</code>原型链上的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_render</code>这个私有方法。

```typescript
Vue.prototype._render = function (): VNode {
  ...
}
```

在这段代码中我们能够看到它不接收任何参数，但是它会返回一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">VNode</code>，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">VNode</code>是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>在编译后生成的虚拟节点，又叫<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Virtual DOM</code>。

在这个私有方法中，我们来查看他的具体实现方式。

```typescript
const vm: Component = this // 从this中拿到vm实例
const { render, _parentVnode } = vm.$options // 从vm.$options中拿到render
```

继续往下看能够看到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_parentVnode</code>私有方法和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm.$vnode</code>的定义，这些在下一篇文章中会详细的介绍，在这里我们只需关注<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>方法。

对于这个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>生成的方式有两种，一种是用户自己去写一个，另一种是通过编译生成一个。继续往下看代码。

```typescript
let vnode
try {
  ...
  vnode = render.call(vm._renderProxy, vm.$createElement)
} catch (e) {
  ...
} finally {
	...
}
```

这段代码中<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>方法调用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">call</code>方法的同时传递两个参数，这里我们要知道<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">call</code>方法的第一个参数是上下文环境，在生产环境中，这个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">call</code>方法的第一个参数代指的就是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>，而<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>我们就可以理解为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>。

在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">call</code>方法中传递的第二个参数在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>源码中是一个方法，这个方法在当前文件的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initRender</code>中有定义。

```typescript
export function initRender (vm: Component) {
  ...
  vm._c = (a, b, c, d) => createElement(vm, a, b, c, d, false) // 用于自动编译生成render
  vm.$createElement = (a, b, c, d) => createElement(vm, a, b, c, d, true) // 用于手动编写生成render
  ...
}
```

在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initRender</code>中，能够看到这两个方法的定义，通过观察这两个方法都是在调用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">createElement</code>方法的时候最后一个参数有所不同，通过最后一个参数的不同，决定了方法的作用不同。

这里我将通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的实际使用方式来介绍什么是自动编译和手动编写。

```vue
// 自动生成render
<div id="app">
  {{msg}}
</div>
<script>
  var app = new Vue({
    el: '#app',
    data() {
      return {
        msg: 'Hello Vue!'
      }
    }
  })
</script>

// 手动编写render
<div id="app"></div>
<script>
	var app = new Vue({
    el: '#app',
    render(createElement) {
      return createElement('div', {
        attrs: {
          id: 'app1'
        }
      }, this.msg)
    }
    data() {
      return {
        msg: 'Hello Vue!'
      }
    }
  })
</script>
```

这里有一点需要注意，在上一篇文章中，我们提到了挂载实例是会被替换掉的，所以不能挂载到标签为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">body</code>和标签为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">html</code>的节点上的，如下图所示，我们的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dom</code>结构中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">id</code>属性是为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">app1</code>，而并不是我们之前定义好的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">app</code>。

![](1561947451568.jpg)

回归源码，我们通过实际编写来介绍了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">createElement</code>方法，接下来我们继续分析<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm._renderProxy</code>方法，对于这个方法的入手点，还是我们老生常谈的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/index.js</code>这个文件，在这个文件中，能够看到这段代码。

```typescript
import { initMixin } from './init'
```

点击跳转到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/init.js</code>文件中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initMixin</code>下的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_init</code>原型链的私有方法，在介绍<a href="http://www.songjian.site/2019/06/20/%E6%B7%B1%E5%85%A5%E8%A7%A3%E8%AF%BBvue%E6%BA%90%E7%A0%81%EF%BC%88%E5%9B%9B%EF%BC%89new%20Vue/">《深入解读vue源码（四）new Vue》</a>这篇文章的时候，我们基本了解了这个原型链的私有方法，但是还有这样一段代码我们没有分析。

```typescript
if (process.env.NODE_ENV !== 'production') {
  initProxy(vm) // 开发环境
} else {
  vm._renderProxy = vm // 生产环境
}
```

这里通过对运行环境的判断来进行一些操作，对于生产环境来说<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_renderProxy</code>就是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>，我们继续分析开发环境下的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initProxy</code>方法都做了什么。

首先<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initProxy</code>方法是定义在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/proxy.js</code>中的，在这个文件的底部，我们能看到这样的代码。

```typescript
initProxy = function initProxy (vm) {
  if (hasProxy) { // 判断浏览器是否支持proxy
    const options = vm.$options
    const handlers = options.render && options.render._withStripped
    ? getHandler
    : hasHandler
    vm._renderProxy = new Proxy(vm, handlers)
  } else {
    vm._renderProxy = vm
  }
}
```

这段代码中通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hasProxy</code>来判断浏览器是否支持<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">proxy</code>，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">proxy</code>的作用简单来讲就是对对象访问做一个劫持，在当前主流的浏览器中，基本都是支持<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">proxy</code>的，继续往下看，我们来分析下<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getHandler</code>这个对象。

```typescript
const hasHandler = {
  has (target, key) {
    const has = key in target // 判断key在不在target中，返回布尔类型
    const isAllowed = allowedGlobals(key) ||
          (typeof key === 'string' && key.charAt(0) === '_' && !(key in target.$data)) // allowedGlobals是一些全局的属性和方法，这里是判断key是否属于allowedGlobals中的属性或方法
    if (!has && !isAllowed) { // 都不满足的情况下
      if (key in target.$data) warnReservedPrefix(target, key)
      else warnNonPresent(target, key) // 调用warnNonPresent函数，这个函数抛出的是一个警告
    }
    return has || !isAllowed
  }
}
```

关于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">warnNonPresent</code>有一个值得讲解的问题，首先我们来看下这个函数。

```typescript
const warnNonPresent = (target, key) => {
  warn(
    `Property or method "${key}" is not defined on the instance but ` +
    'referenced during render. Make sure that this property is reactive, ' +
    'either in the data option, or for class-based components, by ' +
    'initializing the property. ' +
    'See: https://vuejs.org/v2/guide/reactivity.html#Declaring-Reactive-Properties.',
    target
  )
}
```

这个函数内的报错信息大家应该不会陌生，这个报错就是因为在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>中使用了一个在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">props</code>或<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">computed</code>中没有声明过的变量。

回到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/render.js</code>文件中，我们继续看这段代码。

```typescript
if (!(vnode instanceof VNode)) {
  if (process.env.NODE_ENV !== 'production' && Array.isArray(vnode)) {
    warn(
      'Multiple root nodes returned from render function. Render function ' +
      'should return a single root node.',
      vm
    )
  }
  vnode = createEmptyVNode()
}
```

这段代码通过判断上面<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">try</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">catch</code>语句块中生成的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vnode</code>是否是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">VNode</code>类型，然后继续判断如果<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vnode</code>是一个数组类型则会抛出一个警告信息，如果为数组类型则代表着有多个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">VNode</code>的节点生成。

------

#### 总结

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm._render</code>最终是通过执行<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">createElement</code>方法并返回一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vnode</code>，它是一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Virtual DOM</code>，这个概念也是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue2</code>对比于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue1</code>的升级点。

------

#### 相关链接

- <a color="blue" href="http://es6.ruanyifeng.com/#docs/proxy">proxy</a>