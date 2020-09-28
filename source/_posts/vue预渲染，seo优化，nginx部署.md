---
title: vue预渲染，seo优化，nginx部署
date: 2018-09-03 17:05:40
updated: 2018-09-04 14:35:08
comments: true
categories:
- WEB前端
tags:
- vue
- 预渲染
- seo优化
- nginx部署
---

由于seo的优化对于单页面应用的vue来说优势不大，所以需要找到一个能够解决vue单页面应用问题的解决方案。大体上会有两种解决方式，一种是预渲染，一种是ssr服务端渲染。为此特意尝试了基于ssr的nuxt，但是效果并不是很好，所以打算使用预渲染的方式解决这个问题。

##### 1. 插件安装

	首先我们要安装两个插件，分别是prerender-spa-plugin和vue-meta-info，安装方式通过npm，cnpm，yarn等。我在这里使用的是cnpm。

```shell
cnpm install -D prerender-spa-plugin
cnpm install vue-meta-info
```

<span style="color: red;">扩展：</span>npm中的-D表示--save-dev，被写入到 devDependencies 对象里面去，如果不加-D表示--save，被写入到 dependencies 对象里面去。devDependencies  里面的插件只用于开发环境，不用于生产环境，而 dependencies  是需要发布到生产环境的。

##### 2. 编写webpack.prod.conf.js文件

```js
// 引入文件
const PrerenderSpaPlugin = require('prerender-spa-plugin')
const Renderer = PrerenderSpaPlugin.PuppeteerRenderer
const webpackConfig = merge(baseWebpackConfig, {
    plugins: [
        new CopyWebpackPlugin([
      {
        from: path.resolve(__dirname, '../static'),
        to: config.build.assetsSubDirectory,
        ignore: ['.*']
      }
    ]),
    new PrerenderSpaPlugin({
      // 生成文件的路径，也可以与webpakc打包的一致。
      // 下面这句话非常重要！！！
      // 这个目录只能有一级，如果目录层次大于一级，在生成的时候不会有任何错误提示，在预渲染的时候只会卡着不动。
      staticDir: path.join(__dirname, '../dist'),

      // 对应自己的路由文件，比如index有参数，就需要写成 /index/param1。
      routes: [ '/page/PurchaseAgent','/page/api/Yzapi','/userAdmin/Personal/AccountManagement','/userAdmin/Personal/MyOrder','/userAdmin/Personal/MyMoney'],

      // 这个很重要，如果没有配置这段，也不会进行预编译
      renderer: new Renderer({
        inject: {
          foo: 'bar'
        },
        headless: false,
        // 在 main.js 中 document.dispatchEvent(new Event('render-event'))，两者的事件名称要对应上。
        renderAfterDocumentEvent: 'render-event'
      })
    })
    ]
})
```

##### 3. 编写main.js文件

```js
new Vue({
  el: '#app',
  router,
  store,
  components: {App},
  template: '<App/>',
  /* 这句非常重要，否则预渲染将不会启动 */
  mounted () {
    document.dispatchEvent(new Event('render-event'))
  }
})
```

到此，我们使用prerender-spa-plugin这个做预渲染已经完成。接下来，我们进行seo插件的安装和使用。

<br>

##### 4. 配置vue-meta-info

```js
import MetaInfo from 'vue-meta-info'
Vue.use(MetaInfo)
```

##### 5. 使用vue-meta-info

我们可以在对应的页面加入一下参数以使用该seo插件。

```typescript
export default {
  name: 'purchaseAgent',
  metaInfo: {
    title: '标签页标题',
    meta: [
      {
        name: 'keywords',
        content: '代理1,代理2,代理3'
      },
      {
        name: 'description',
        content: '这是一段网页的描述'
      }
    ]
  }
}
```

##### 6. 编译项目

在完成预渲染和seo优化后，我们进行项目的打包构建。打包后我们会在项目目录中多出一个dist的文件夹，这个文件夹里面的资源就是编译后的项目。

```shell
npm run build
```

编译成功后，命令行提示信息如下图

![1535967882](/blog/images/vue预渲染，seo优化，nginx部署/1535967882.jpg)

同时项目目录中会多出一个dist文件夹

![1535967943](/blog/images/vue预渲染，seo优化，nginx部署/1535967943.jpg)

文件夹中的结构如下，其中page和userAdmin为我项目中的路由页面，static为静态的js，css等资源。

![1535967972](/blog/images/vue预渲染，seo优化，nginx部署/1535967972.jpg)

之后我们随便打开个页面可以看到没有样式，但是我们的seo已经存在在页面中，并且页面在预选然后也不再是单页面的应用，我们通过查看网站源代码时候可以发现，我们的内容会有很多。

<span style="color: red;">未使用预渲染的网站结构的图片</span>

![1535968788](1535968788.jpg)

<span style="color: red;">使用预渲染的网站结构以及使用了seo的效果图片</span>

![1535968376](1535968376.jpg)

##### 7. nginx发布项目

由于我们没有使用服务器发布项目，导致一些静态资源无法加载，所以我们要想看到样式，需要弄一个nginx服务器。

```shell
// 后台方法路径转发
location /api/ {
	proxy_pass http://192.168.1.12:8080/;
}

location / {
    root   F:/project/vue/lll/x/dist;
    index  index.html index.htm;
}
```

配置完成后启动nginx服务，通过localhost进行查看。

![1535968172](1535968172.jpg)
