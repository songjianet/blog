---
title: 深入解读vue源码（四）new Vue
date: 2019-06-20 15:58:34
updated: 2019-06-24 11:46:16
comments: true
categories:
- WEB前端
tags:
- vue
---

#### 基本介绍

这篇文章作为该系列文章中数据驱动部分的第一篇文章，将会揭开<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new Vue</code>背后做了什么事情。

在此之前，我们需要理解的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new</code>这个关键字，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new</code>在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>中的作用是实例化一个对象 / 方法，所以说<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new Vue</code>中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Vue</code>就是一个类，一个方法。

------

#### vue/dist下的文件介绍

在介绍<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new Vue</code>之前，我们需要理解<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>编译后在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dist</code>文件夹下的每个文件都是干什么的，这对我们在接下来的分析过程中有着至关重要的作用。同时也对在使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-cli</code>构建一个项目会有一定的认知。

首先，我们通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-cli</code>创建一个项目的时候（v2.6.10），在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node_modules/vue</code>文件夹下可以看到一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dist</code>文件夹，该文件夹下面的结构是这样的，接下来我们会逐步分析每个文件的作用：

![dist文件夹中的文件](/blog/images/深入解读vue源码（四）newVue/cli-dist.jpg)

##### README.md文件

在此文件中介绍了协议条款、Runtime+Compiler和Runtime-only、Development和Production Mode以及在常见的打包工具下面如何使用。

##### vue.common.js

构建方式：CommonJS、完整构建

打包工具：webpack1.x版本、browserify

打开这个文件，我们能看到以下代码，这段代码是通过区分生产环境和开发环境的不同，导入与之环境相对应的文件。

```javascript
if (process.env.NODE_ENV === 'production') {
  module.exports = require('./vue.common.prod.js')
} else {
  module.exports = require('./vue.common.dev.js')
}
```

##### vue.esm.js

构建方式：ES Module、完整构建

打包方式：webpack2.x等版本、rollup

针对这个文件有一个衍生的版本vue.esm.browser.js，这个文件是针对不同浏览器做的兼容性的文件。

##### vue.js

构建方式：UMD、完整构建

引用方式：CDN

##### vue.runtime.js

构建方式：UMD、运行时构建（不能使用template）

引用方式：CDN

##### vue.runtime.esm.js

构建方式：ES Module、运行时构建（不能使用template）

打包方式：webpack2.x等版本、rollup

##### vue.runtime.common.js

构建方式：CommonJS、运行时构建（不能使用template）

打包方式：webpack1.x版本、browserify

------

#### new Vue做了什么

首先当我们通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-cli</code>创建一个项目后，可以在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">main.js</code>文件中看到这样一段代码：

```javascript
import Vue from 'vue'
...
new Vue({
  router,
  store,
  render: function (h) { return h(App) }
}).$mount('#app')
```

我们可以点击查看到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的引入，这个文件的路径是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node_modules/vue/dist/vue.runtime.esm.js</code>，在此之前我们简单介绍了下这个文件。

当然，这里的文件都是编译后产生的文件，并不是我们想要分析的源码文件，不过当你点击跳转到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue.runtime.esm.js</code>这个文件的时候你会看到这样一段代码，这段代码对应的源码文件的位置是在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/index.js</code>，当你打开这个文件时候，你就能看到这两个文件中的对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>方法的定义是相通的：

```javascript
function Vue (options) {
  if (process.env.NODE_ENV !== 'production' &&
    !(this instanceof Vue)
  ) {
    warn('Vue is a constructor and should be called with the `new` keyword')
  }
  this._init(options)
}

...Mixin(Vue) // 将Vue方法类混入到一些方法中
```

看到这的时候，可能会有些人有疑问，说为什么定义<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>这个方法类是在这里<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/index.js</code>。我们在<a href="http://www.songjian.site/2019/05/16/%E6%B7%B1%E5%85%A5%E8%A7%A3%E8%AF%BBvue%E6%BA%90%E7%A0%81%EF%BC%88%E4%B8%89%EF%BC%89runtime-compiler%E5%85%A5%E5%8F%A3/">《深入解读vue源码（三）runtime-compiler入口》</a>这篇文章中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/index.js</code>时候已经进行介绍了，你也可以查看源码中这个文件的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">import</code>部分的代码。

分析上面的代码，我们能够看出当前环境不为生产环境并且在没有使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new</code>关键字的时候进行警告，同时继续执行<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_init</code>方法。

我们通过点击可以查看到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_init</code>方法的实现，这个方法的文件路径是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/init.js</code>，值得注意的是下划线这个符号在编程界一半代指私有的属性或方法，不能直接被外部调用的属性或方法。

```typescript
Vue.prototype._init = function (options?: Object) {
  ...
}
```

实际<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_init</code>方法是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>原型链上的一个方法，这个方法做了很多的初始化工作，其中包含一个合并<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">options</code>的方法：

```typescript
// merge options
if (options && options._isComponent) {
  // optimize internal component instantiation
  // since dynamic options merging is pretty slow, and none of the
  // internal component options needs special treatment.
  initInternalComponent(vm, options)
} else {
  vm.$options = mergeOptions(
    resolveConstructorOptions(vm.constructor),
    options || {},
    vm
  )
}
```

这段代码是将我们在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Vue</code>方法类中传入的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">options</code>合并到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm.$options</code>上，在通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-cli</code>创建一个项目的时候就可以通过下面的写法能够获取到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>等。

```javascript
vm.$options.el
vm.$options.data
```

继续往下看<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_init</code>方法，能够看到这个方法内初始化了很多东西，如生命周期、事件等：

```javascript
vm._self = vm
initLifecycle(vm) // 生命周期
initEvents(vm) // 事件
initRender(vm) // render
callHook(vm, 'beforeCreate')
initInjections(vm) // resolve injections before data/props
initState(vm) //state 
initProvide(vm) // resolve provide after data/props
callHook(vm, 'created')
```

当初始化都做完后，再往下看就是挂载<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">el</code>，就是将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dom</code>结构挂载上来：

```javascript
if (vm.$options.el) {
  vm.$mount(vm.$options.el)
}
```

------

#### data中的数据是如何被调用的

这一部分作为延展来讲，在后续的文章中我会对其进行详细的介绍，在这里拿这个进行简单的举例说明是为了更好的让大家理解<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Vue</code>这个方法类中初始化的过程。

当我们在用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>去写项目的时候，大家都知道通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mounted</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">methods</code>中通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this.</code>就能调用到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>中定义的变量，接下来我们就来看看这其中有着怎样的关系。

首先在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_init</code>方法中我们能够看到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initState(vm)</code>，我们点击寻找这个方法所在文件的路径是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/core/instance/state.js</code>，在这个文件中找到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initState</code>这个方法，这个方法里面根据不同的条件装载不同的方法，这些装载的方法也是在这个文件中定义的。

```typescript
export function initState (vm: Component) {
  vm._watchers = []
  const opts = vm.$options
  if (opts.props) initProps(vm, opts.props)
  if (opts.methods) initMethods(vm, opts.methods)
  if (opts.data) {
    initData(vm)
  } else {
    observe(vm._data = {}, true /* asRootData */)
  }
  if (opts.computed) initComputed(vm, opts.computed)
  if (opts.watch && opts.watch !== nativeWatch) {
    initWatch(vm, opts.watch)
  }
}
```

这里我们着重分析下装载<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>的过程，了解这个过程后也就理解了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>的调用过程。

通过点击<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initData</code>跳转到对应的方法，可以看到这个方法的实现还是比较简单的。

```typescript
function initData (vm: Component) {
  let data = vm.$options.data
  ...
}
```

上面这段代码通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm.$options.data</code>的形式获取到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>并将其保存起来。

```typescript
data = vm._data = typeof data === 'function'
    ? getData(data, vm)
    : data || {}
```

这段代码通过判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>是否是一个函数，并且将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getData</code>方法的返回值保存到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm._data</code>中。其实我们的在写一个组件的时候<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>既可以是函数也可以是对象，例如下面的这两种写法，不过官方更推荐我们使用函数形式的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>。

```vue
<script>
	export default {
    data () {
      return {
        
      }
    }
    // data: {} 不推荐直接使用对象形式
  }
</script>
```

回归正题，当判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>的类型是一个函数的时候，调用了一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getData</code>方法。

```typescript
export function getData (data: Function, vm: Component): any {
  // #7573 disable dep collection when invoking data getters
  pushTarget()
  try {
    return data.call(vm, vm)
  } catch (e) {
    handleError(e, vm, `data()`)
    return {}
  } finally {
    popTarget()
  }
}
```

这个方法中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">pushTarget()</code>在之后的章节中会有详细的介绍，这个方法主要返回的是一个对象。

接下来我们继续分析<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">initData</code>这个方法。

```typescript
if (!isPlainObject(data)) {
  data = {}
  process.env.NODE_ENV !== 'production' && warn(
    'data functions should return an object:\n' +
    'https://vuejs.org/v2/guide/components.html#data-Must-Be-a-Function',
    vm
  )
}
```

这里是通过判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>是不是一个纯粹的对象（纯粹的对象代指使用"{}"和"new"创建出来的对象），如果不是一个对象并且在不是生产环境的情况（绝大对数是在开发环境下进行警告提示）下会在控制台抛出一个警告信息。

```typescript
// proxy data on instance
const keys = Object.keys(data) // 保存data中的所有key
const props = vm.$options.props
const methods = vm.$options.methods
let i = keys.length
while (i--) {
  const key = keys[i]
  if (process.env.NODE_ENV !== 'production') {
    if (methods && hasOwn(methods, key)) {
      warn(
        `Method "${key}" has already been defined as a data property.`,
        vm
      )
    }
  }
  if (props && hasOwn(props, key)) {
    process.env.NODE_ENV !== 'production' && warn(
      `The data property "${key}" is already declared as a prop. ` +
      `Use prop default value instead.`,
      vm
    )
  } else if (!isReserved(key)) {
    proxy(vm, `_data`, key)
  }
  // observe data
  observe(data, true /* asRootData */)
}
```

这段代码是拿到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>中对象的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">key</code>、拿到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">props</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">methods</code>，通过循环对比的方式判断这个对象是否只定义了一次，简单来说就是在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>中定义的对象不能再<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">props</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">methods</code>中进行重复的定义。之所以会有这种限制，是因为他们最后的方法和变量都是挂载到一个全局的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>下，最后用户就可以通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">this</code>关键字调用变量或者方法。

接下来我们继续看，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>中的数据是如何被改变和读取的，可以点击上面<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">proxy</code>方法，这个方法是通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">get</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">set</code>方法对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>中的数据进行读写操作的。

```typescript
const sharedPropertyDefinition = {
  enumerable: true,
  configurable: true,
  get: noop,
  set: noop
}
export function proxy (target: Object, sourceKey: string, key: string) {
  sharedPropertyDefinition.get = function proxyGetter () {
    return this[sourceKey][key]
  }
  sharedPropertyDefinition.set = function proxySetter (val) {
    this[sourceKey][key] = val
  }
  Object.defineProperty(target, key, sharedPropertyDefinition)
}
```

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">proxy</code>方法中通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">sharedPropertyDefinition</code>对象中定义的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">get</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">set</code>去实现一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getter</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">setter</code>方法，这个方法中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">target</code>就是传入的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vm</code>对象。

值得一提的是这个方法中的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">sourceKey</code>参数，这个参数传入的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">_data</code>，这个参数是一个不建议我们在实际业务中使用的方法，因为它是一个内部声明的方法，我们就是通过对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">sourceKey</code>的绑定实现了对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>的读取和更改。

------

#### 总结

这篇文章主要讲解的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">new Vue</code>的时候，它的内部到底做了什么操作以及简单的讲解下<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>中声明的数据是如何被读取和修改的，至于详细的关于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">data</code>的信息我们会在后续的文章中进行深入的讲解。

------

#### 相关链接

- <a color="blue" href="https://www.ibm.com/developerworks/cn/web/1306_jiangjj_jsinstanceof/index.html">JavaScript instanceof 运算符深入剖析</a>

