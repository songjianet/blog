---
title: nuxt整合iView
date: 2018-09-12 15:31:30
updated: 2018-09-13 9:11:38
comments: true
categories:
- WEB前端
tags:
- nuxt
- iView
---

最近使用vue做项目的时候，需要对页面进行seo优化，众所周知spa对seo支持很不友好。所以，最开始的解决方式是vue-meta-info和prerender-spa-plugin的组合，通过预渲染的方式进行。但是经过实际的实践操作，发现预渲染并不能很好的处理大量的异步请求和大量路由页面的项目。为此只好去踩坑nuxt了。

关于nuxt在github上面有一个简单的demo我们可以安装下来进行查看。

![1536737877](/blog/images/nuxt整合iView/1536737877.jpg)

项目成功跑起来后我们可以通过localhost:3000端口进行查看。

![1536737963](/blog/images/nuxt整合iView/1536737963.jpg)

##### 1. 下载iView

在package.json文件中的dependencies下面添加iview版本号信息。

```typescript
"iview": "^3.0.0"
```

然后在命令行终端执行cnpm install后会在node_modules目录下面多处一个iview的文件夹。

```shell
cnpm install
```

##### 2. 创建并编写Iview.js配置文件

由于nuxt项目结构和我们普通的vue项目结构不同，这时很多人下载了iview并不知道怎么去引用到我们的项目中，实际在nuxt官网上面，已经对各个文件夹有了说明，其中的plugins文件夹为实例化之前需要运行的 Javascript 插件。

![1536740176](/blog/images/nuxt整合iView/1536740176.jpg)

我们需要在plugins文件夹下创建一个Iview.js的文件，这个文件的文件名首字母必须大写，否则在运行的时候会报错。

```typescript
import Vue from 'vue'
import Iview from 'iview'
Vue.use(Iview)
```

##### 3. 在nuxt.config.js中引用

我们要把Iview的文件在nuxt的配置文件中进行引入，同时也要导入iView的css文件。

```typescript
plugins: [{
    src: '~plugins/Iview.js',
    ssr: true,
}],
css: [
    'iview/dist/styles/iview.css'
]
```

##### 4. 防止iView被webpack打包多次

我们需要在nuxt.config.js中的build方法中，添加一个参数，防止多次打包。

```typescript
vendor:['iview']
```

##### 5. 测试

到iView官网中找到一个按钮，放到我们项目中pages文件夹下的index.vue文件中，打开浏览器就能看到iView的组件了。

```vue
<Button type="primary">Primary</Button>
```

![1536740765](/blog/images/nuxt整合iView/1536740765.jpg)
