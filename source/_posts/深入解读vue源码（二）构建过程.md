---
title: 深入解读vue源码（二）构建过程
date: 2019-05-14 16:17:28
updated: 2019-05-16 10:59:31
categories:
- WEB前端
tags:
- vue
---

#### 基本介绍

通过上篇文章<a color="blue" href="http://www.songjian.site/2019/05/14/%E6%B7%B1%E5%85%A5%E8%A7%A3%E8%AF%BBvue%E6%BA%90%E7%A0%81%E4%B9%8B%E7%9B%AE%E5%BD%95%E8%AE%BE%E8%AE%A1/">《深入解读vue源码（一）目录设计》</a>了解到了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的目录设计后，这篇文章要对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的构建过程进行一些详细的介绍。

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的构建过程是在根目录下的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">scripts</code>目录中通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Rollup</code>编译<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">build.js</code>文件。

------

#### 构建脚本

通常一个基于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node</code>的项目在根目录下都会有一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">package.json</code>的文件，它是对项目的一个描述文件，描述的内容可以是包版本、启动脚本、项目名等等，它的内容是一个标准的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JSON</code>对象。

我们主要从<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">build</code>模式下分析项目的构建过程（打包编译到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dist</code>目录），在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">package.json</code>中我们能看到这样一段代码：

```json
"scripts": {
  "build": "node scripts/build.js",
  "build:ssr": "npm run build -- web-runtime-cjs,web-server-renderer",
  "build:weex": "npm run build -- weex"
}
```

上面的代码作用于构建<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>应用程序，其中<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">ssr</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">weex</code>是对第一条的环境拓展参数，当执行<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">npm run build</code>的时候实际执行的就是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node scripts/build.js</code>。

对于有环境拓展参数的命令来讲，会将命令中的参数（ -- 符号后面的参数）传入<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">process.argv</code>数组中。

------

#### 解读构建过程

##### scripts/build.js分析

我们知道了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">build</code>过程实际是去读取这个文件，打开这个文件我们开始一段段分析：

```javascript
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist')
}
```

这段代码是在判断项目的根目录下是否存在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dist</code>目录，不存在则创建。

```javascript
let builds = require('./config').getAllBuilds()
```

这里通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">builds</code>变量保存一个在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">scripts/config.js</code>中返回的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src/platforms</code>路径下所有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>文件的数组对象，该对象包括支持<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">ssr</code>、客户端渲染和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">weex</code>的文件名和文件路径等信息。

```javascript
if (process.argv[2]) { // 判断是否是ssr或者weex
  const filters = process.argv[2].split(',') // 将数组中的第三条数据以逗号分隔形式保存到数组
  builds = builds.filter(b => { // 遍历builds对象
    // 对filters的每一项与builds对象中的文件名或者文件路径进行筛选，当b中包含f时返回true
    return filters.some(f => b.output.file.indexOf(f) > -1 || b._name.indexOf(f) > -1)
  })
} else { // process.argv[2] = undefined，则不是ssr或者weex
  builds = builds.filter(b => {
    // 将b中不包含weex的数据设置为true
    return b.output.file.indexOf('weex') === -1
  })
}
```

这段代码判断的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">build</code>的编译类型，用类型去判断编译哪些文件，在这里通过判断<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">process.argv[2]</code>数组中是否存在第三条数据，存在第三条数据的情况下就是说明<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">build</code>的环境拓展参数是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">ssr</code>或者<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">weex</code>。

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">process.argv[2]</code>的值在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">ssr</code>的环境下是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">'web-runtime-cjs,web-server-renderer'</code>，在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">weex</code>的环境下是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">'weex'</code>，在没有环境拓展参数的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">build</code>下为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">undefined</code>。

```javascript
build(builds) // 将筛选后的builds对象传入build方法

function build (builds) {
  let built = 0 
  const total = builds.length
  const next = () => { // 定一个匿名函数，通过递归方式调用
    buildEntry(builds[built]).then(() => { // 调用buildEntry方法，返回一个promise对象
      built++
      if (built < total) {
        next()
      }
    }).catch(logError) // 调用logError，打印输出错误信息
  }

  next() // 调用
}
```

这段代码主要功能是通过递归的方式不断的调用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">buildEntry</code>方法，该方法返回一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">promise</code>对象，之所以使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">promise</code>对象的原因是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Rollup</code>本身接收和返回的是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">promise</code>对象。

```javascript
function buildEntry (config) { // 接收builds数组中的一个对象
  const output = config.output // 保存对象中的output的value
  const { file, banner } = output // banner为scripts/config.js中定义的注释信息
  const isProd = /(min|prod)\.js$/.test(file) // 正则匹配为min和prod的输出文件名
  return rollup.rollup(config) // 将对象传入rollup，交给rollup进行打包
    .then(bundle => bundle.generate(output))
    .then(({ output: [{ code }] }) => {
      if (isProd) { // 代码格式化形式
        const minified = (banner ? banner + '\n' : '') + terser.minify(code, {
          toplevel: true,
          output: {
            ascii_only: true
          },
          compress: {
            pure_funcs: ['makeMap']
          }
        }).code
        return write(file, minified, true) // 调用创建文件方法，创建文件方法再次不在赘述
      } else {
        return write(file, code)
      }
    })
}
```

##### scripts/config.js分析

在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">scripts/build.js</code>文件中我们调用了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">scripts/config.js</code>这个方法，并且把数据保存在了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">builds</code>的变量中，对于<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">scripts/config.js</code>文件的分析，会从<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getAllBuilds</code>方法开始。

```javascript
if (process.env.TARGET) { // 判断是否有TARGET，只有在dev环境下才有TARGET
  module.exports = genConfig(process.env.TARGET)
} else {
  exports.getBuild = genConfig
  // 通过枚举的形式将builds中的key名取出来形成新的数组，并对数组的每一项进行循环调用genConfig方法
  exports.getAllBuilds = () => Object.keys(builds).map(genConfig) 
}
```

上面这段代码通过判断启动参数来区分是否是编译环境，如果是编译环境的情况下，则把<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">getAllBuilds</code>映射出去。

```javascript
const builds = {
  'web-runtime-cjs-dev': {
    entry: resolve('web/entry-runtime.js'), // 入口文件
    dest: resolve('dist/vue.runtime.common.dev.js'), // 编译后的文件
    format: 'cjs', // 编译文件的格式
    env: 'development', // 指定环境
    banner // 注释
  }
  ......
}
```

这段代码是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">builds</code>的基本结构，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Object.keys(builds)</code>获取到的值是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">['web-runtime-cjs-dev', ……]</code>这样的一个数组。之后对数据进行循环，去调用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">genConfig</code>方法。

```javascript
const banner =
  '/*!\n' +
  ` * Vue.js v${version}\n` +
  ` * (c) 2014-${new Date().getFullYear()} Evan You\n` +
  ' * Released under the MIT License.\n' +
  ' */'
```

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">banner</code>是一个注释，在打包编译的时候将其传入对应文件。

```javascript
const resolve = p => {
  const base = p.split('/')[0] // 对传入的路径进行截取形成新的数组，同时取得第一条数据，如weex、web、server等
  if (aliases[base]) { // 判断aliases[base]是否为undefined
    // 将aliases[base]目录和p路径从base.length + 1往后截取的字符串拼接成打包的entry入口的文件路径
    return path.resolve(aliases[base], p.slice(base.length + 1))
  } else {
    // 为undefined的情况下将当前目录、返回上层目录和要输出的文件目录或者生成其它node包的目录传入path.resolve方法
    return path.resolve(__dirname, '../', p)
  }
}
```

通过上面的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">resolve</code>这个方法已经对<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">builds</code>的结构进行了一系列的处理，并将新的结构返回给<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Object.keys(builds)</code>中。

其中<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">genConfig</code>方法作用是将处理好的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">builds</code>结构包装成符合<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Rollup</code>打包渲染的结构，在这里就不再赘述。

##### scripts/alias.js分析

此文件主要用于包装出一个执行不同环境的命令时对应的源码相对路径，并且把相对路径包装成绝对路径。

```javascript
const resolve = p => path.resolve(__dirname, '../', p)

module.exports = {
  vue: resolve('src/platforms/web/entry-runtime-with-compiler'),
  compiler: resolve('src/compiler'),
  core: resolve('src/core'),
  shared: resolve('src/shared'),
  web: resolve('src/platforms/web'),
  weex: resolve('src/platforms/weex'),
  server: resolve('src/server'),
  sfc: resolve('src/sfc')
}
```

------

#### runtime only and runtime compiler

##### 基本介绍

说到构建过程，我们在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>官网能够看到两种构建方式，分别是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime only</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime compiler</code>。这两种构建方式在使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-cli</code>创建一个项目的时候，会提供选择的操作，不过我们默认情况下推荐选择<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime only</code>。

##### 二者区别

- <code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime only</code>代表构建过程是在运行的时候，这种构建模式删除了模板编译的功能，因此无法支持带<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>属性的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>实例。使用此构建方式需要借助<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-loader</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">webpack</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vueify</code>等打包构建工具。
- <code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">runtime compiler</code>代表构建过程在运行的时候添加了编译器的功能，有了编译器就能够解析带有<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">template</code>属性的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>实例。

##### 例子

```javascript
// runtime compiler
new Vue({
  template: '{{hello world!}}'
})

// runtime only
new Vue({
  render(h) {
    return h('div', 'hellow world!')
  }
})
```



------

#### 总结

到此一个完整的构建过程就已经介绍完了，构建过程主要就是在执行根目录下的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">scripts</code>目录中的文件。

