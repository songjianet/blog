---
title: 深入解读vue源码（五）挂载实例的实现
date: 2019-06-27 10:46:27
updated: 2019-06-27 22:27:37
categories:
- WEB前端
tags:
- vue
---

#### 基本介绍

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>中我们是通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法去实现<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>的挂载，这个方法在源码中很多文件都有定义如：

- src/platform/web/entry-runtime-with-compiler.js
- src/platform/web/runtime/index.js
- src/platform/weex/runtime/index.js

其实在前面的几片文章的介绍中我们可以看出来这些文件就是对不同平台、不同环境、不同的构建方式进行的区分，在这篇文章中会介绍带有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">compiler</code>版本的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法的实现原理。

------

#### compiler版本$mount的实现

##### 简单回顾

首先我们先回顾下，在上篇文章中我们讲解了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new Vue</code>的实现过程，在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/index.js</code>文件下能看到这样的代码。

```typescript
import { initMixin } from './init'
...
initMixin(Vue)
```

通过点击能够查看到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initMixin</code>方法，在这个方法中最底部有这样一段代码。

```typescript
if (vm.$options.el) {
  vm.$mount(vm.$options.el)
}
```

这段代码是在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>不为空的时候将其通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法挂载到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dom</code>中。

##### $mount的实现

compiler版本$mount的实现在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platform/web/entry-runtime-with-compiler.js</code>文件，打开这个文件我们一步步进行分析。

```typescript
const mount = Vue.prototype.$mount
```

这句话是将原型链上的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法缓存在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mount</code>上。

接着我们深入去看看<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>这个方法是通过什么方式定义的，这个方法定义的路径在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platforms/web/runtime/index.js</code>下，该文件中有这样一段代码。

```typescript
Vue.prototype.$mount = function (
  el?: string | Element,
  hydrating?: boolean
): Component {
  el = el && inBrowser ? query(el) : undefined
  return mountComponent(this, el, hydrating)
}
```

回归正轨，我们继续分析这个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platform/web/entry-runtime-with-compiler.js</code>文件。

```typescript
Vue.prototype.$mount = function (
  el?: string | Element,
  hydrating?: boolean
): Component {
  ...
}
```

这段代码重新定义了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>在原型链上的方法，这时候很多人会好奇，为什么会定义两遍。

其实<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platform/web/entry-runtime-with-compiler.js</code>文件中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法是一个重写复用的方法，这个方法只在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">compiler</code>版本中存在，在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime-only</code>版本中并不存在。

在这里我们能够看到这个方法接收两个参数，一个参数是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>，它表示挂载的元素，可以是字符串类型，也可以是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">DOM</code>对象，第二个参数<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">hydrating</code>是和服务端渲染相关的，在客户端浏览器渲染的情况下我们可以忽略这个参数。

在这个方法内部，我们会看到一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">query</code>方法。

```typescript
el = el && query(el)
```

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">query</code>方法是在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platforms/web/util/index.js</code>这个文件中进行定义的，这个方法也是比较简单的，总的来说就是调用原生的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">document.querySelector</code>方法。

```typescript
export function query (el: string | Element): Element {
  if (typeof el === 'string') {
    const selected = document.querySelector(el)
    if (!selected) {
      process.env.NODE_ENV !== 'production' && warn(
        'Cannot find element: ' + el
      )
      return document.createElement('div')
    }
    return selected
  } else {
    return el
  }
}
```

这个方法通过判断传入的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>是否是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">string</code>类型，如果是的话将其转换成<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dom</code>元素保存在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">selected</code>中，并且判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">selected</code>是否为空，为空则警告，不为空则<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">query</code>方法返回<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">selected</code>，当传入的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>是元素节点类型则直接返回。

```typescript
if (el === document.body || el === document.documentElement) {
  process.env.NODE_ENV !== 'production' && warn(
    `Do not mount Vue to <html> or <body> - mount to normal elements instead.`
  )
  return this
}
```

继续分析<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法，能够看到这样一段代码，这段代码的作用就是判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>的标签中有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">body</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">html</code>标签的情况下进行警告，这个警告的原因是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mount</code>方法是通过覆盖的形式进行挂载的，所以不能直接挂载到这两个标签上，通常情况下我们的挂载都是通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">id</code>进行挂载的。

```typescript
if (!options.render) {
  ...
}
```

继续往下看代码，会看到对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>的处理，通过判断是否有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>这个函数，我们在使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-cli</code>创建一个项目的时候在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">main.js</code>文件中会看到这样的代码，这段代码中在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new Vue</code>的过程中创建了一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>并且挂载到了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">#app</code>下。

```javascript
new Vue({
  router,
  store,
  render: function (h) { return h(App) }
}).$mount('#app')
```

在判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>的内部又进行了对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>的判断，值得注意的是，如果想使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>就要使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">compiler</code>版本。这<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>的内部有两个对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>的判断，首先我们来分析第一个。

```typescript
let template = options.template // 拿到template定义的值
if (template) {
  if (typeof template === 'string') { // 判断template为string类型
    if (template.charAt(0) === '#') { // 判断template中的第一个字符为#号
      template = idToTemplate(template)
      /* istanbul ignore if */
      if (process.env.NODE_ENV !== 'production' && !template) { // 判断template是否为空，为空的情况下提示找不到模板元素或模板元素为空
        warn(
          `Template element not found or is empty: ${options.template}`,
          this
        )
      }
    }
  } else if (template.nodeType) { // 判断template为节点类型
    template = template.innerHTML
  } else {
    if (process.env.NODE_ENV !== 'production') { // 不是这string类型或节点类型的情况下提示无效的模板选项
      warn('invalid template option:' + template, this)
    }
    return this
  }
} else if (el) {
  template = getOuterHTML(el) // template是字符串类型
}
```

这段代码中包含了两个方法，分别是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">idToTemplate</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getOuterHTML</code>。在这里先简单介绍下<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">idToTemplate</code>方法。

```typescript
const idToTemplate = cached(id => {
  const el = query(id)
  return el && el.innerHTML
})
```

这段代码将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>传入到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">query</code>方法，在之前我们看到了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">query</code>方法中接收的两个参数类型，一个是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">string</code>，一个是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Element</code>，对于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">idToTemplate</code>方法，就是将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Element</code>类型传入<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">query</code>方法。

接下来我们继续看<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getOuterHTML</code>这个方法。

```typescript
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

这个方法是判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>中是否有后代元素并且是否只包含一个父级的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">DOM</code>节点，如果是直接返回，如果不是则在外层包一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">div</code>，使其只有一个父级节点。

在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>的内部对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>的二个判断是跟编译相关的，在后面的章节中我们还会进行详细的介绍，在这里我们只需要知道<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法就是判断是否有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>函数，有的话直接使用，没有的话通过编译<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>使其自动生成个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>函数，也可以理解为我们在使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>进行任何业务功能的编写时，都是依赖<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>函数的挂载得以实现的。

在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>这个原型链方法的最后还有这样一段代码。

```typescript
return mount.call(this, el, hydrating)
```

这段代码中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mount</code>方法是文件最开始写入缓存的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法，所以这段代码本质依旧是调用原型链上的方法，这个方法在文章的最开始已经介绍过了，是在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platforms/web/runtime/index.js</code>下的方法。

在这个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法内，能看到他最后返回的是一个名字叫做<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mountComponent</code>的函数，接下来我们去看一下这个函数，这个函数定义在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/lifecycle.js</code>这里。

```typescript
export function mountComponent (
  vm: Component,
  el: ?Element,
  hydrating?: boolean
): Component {
  vm.$el = el
  ...
}
```

首先这里会将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>缓存到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>中。

继续往下分析，我们会看到这样一段代码。

```typescript
if (!vm.$options.render) {
  vm.$options.render = createEmptyVNode
  if (process.env.NODE_ENV !== 'production') {
    /* istanbul ignore if */
    if ((vm.$options.template && vm.$options.template.charAt(0) !== '#') ||
        vm.$options.el || el) {
      warn(
        'You are using the runtime-only build of Vue where the template ' +
        'compiler is not available. Either pre-compile the templates into ' +
        'render functions, or use the compiler-included build.',
        vm
      )
    } else {
      warn(
        'Failed to mount component: template or render function not defined.',
        vm
      )
    }
  }
}
```

这段代码判断的是是否有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>，没有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>的情况下会给<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>赋值一个空的节点，并且在不是生产环境的情况下抛出一个警告信息，为什么会存在没有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>的情况呢，有些时候我们使用了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime-only</code>版本，并且定义了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>，这个时候我们的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime-only</code>版本中并没有对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>方法进行重写，所以无法获取一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">render</code>。

这个方法中还有一些信息，我们在这里只做一些简单的介绍

```typescript
callHook(vm, 'beforeMount') // 生命周期相关，在后续的文章中会单独进行介绍
if (process.env.NODE_ENV !== 'production' && config.performance && mark) {
  updateComponent = () => { // vue提供的性能埋点系统，用以监控程序运行状态
    ...
  }
} else {
  updateComponent = () => {
    vm._update(vm._render(), hydrating) // vNode
  }
}
```

这段代码中与性能埋点系统相关的东西，不在我的介绍范围内，详细的可以去官网查看有关文档，我们这里要去分析<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">updateComponent</code>方法，这个方法是怎么执行的呢。

```typescript
new Watcher(vm, updateComponent, noop, {
  before () {
    if (vm._isMounted && !vm._isDestroyed) {
      callHook(vm, 'beforeUpdate')
    }
  }
}, true /* isRenderWatcher */)
```

这里通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm._render</code>方法生成一个虚拟<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">DOM</code>，在实例化一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Watcher</code>方法，在调用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">updateComponent</code>方法。

最终调用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">VM._update</code>方法更新<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">DOM</code>，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Watcher</code>方法在这里有两个作用，一是用来初始化时候执行回调函数，二是在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>实例中监测的数据发生改变时触发回调函数。

```typescript
if (vm.$vnode == null) {
  vm._isMounted = true
  callHook(vm, 'mounted')
}
return vm
```

函数在最后判断跟节点的时候设置为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">true</code>，表示这个实例已经挂载了，紧跟着执行<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mounted</code>生命周期。

这里值得注意的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm.$vnode == null</code>表示<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>实例的父级的虚拟节点，所以为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">null</code>时候表示根<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>实例。

------

#### 总结

这篇文章主要讲解了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">$mount</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mountComponent</code>方法，这两个方法的逻辑也是十分清晰，它完成了整个实例化渲染<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">DOM</code>的功能。

------

#### 相关链接

- <a color="blue" href="https://developer.mozilla.org/zh-CN/docs/Web/API/Document/querySelector">document.querySelector()</a>
- <a color="blue" href="https://developer.mozilla.org/zh-CN/docs/Web/API/Element/outerHTML">element.outerHTML</a>

