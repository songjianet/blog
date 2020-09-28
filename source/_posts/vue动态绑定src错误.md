---
title: vue动态绑定src错误
date: 2018-12-11 17:26:40
updated: 2018-12-11 17:45:43
comments: true
categories:
- WEB前端
tags:
- vue
- webpack
- assets和static
---

#### 问题概述

​	很多时候我们要对图片进行动态的绑定，例如在循环的时候增加<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">:src</code>，但是这样会造成一个问题，就是编译虽然不报错，但是我们在网页中并不能看到我们的图片，不过我们在浏览器里打开控制台的时候发现图片的路径是正确无误的。

![找不到图片展示图](/blog/images/vue动态绑定src错误/20181211173152.png)

#### 产生原因

​	这时候就有很多人好奇为什么出现这个情况，在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">webpack</code>中会将图片当作模块来用，因为我们图片是动态加载的，所以<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">url-loader</code>将无法进行图片的解析，然后在我们运行项目的时候会导致图片路径没有被加工，只是显示到了文档的结构中。

#### 解决办法

​	将图片作为模块方式加载进去。

```vue
data () {
  return {
    images: require('./imagename.jpc')
  }
}
```

#### 拓展介绍

##### assets

在项目编译的过程中会被<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">webpack</code>处理解析为模块依赖，只支持相对路径的形式。

##### static

在这个目录下文件不会被<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">webpack</code>处理,简单就是说存放第三方文件的地方，不会被<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">webpack</code>解析。他会直接被复制到最终的打包目录（默认是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">dist/static</code>）下。必须使用绝对路径引用这些文件。
