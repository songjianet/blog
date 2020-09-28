---
title: hexo文章图片显示
date: 2018-01-19 16:47:13
updated: 2018-05-15 11:11:43
comments: true
categories:
- hexo
tags:
- hexo
---

本篇文章介绍一下在hexo的框架内，想要在页面文章中显示图片的方法。

1. 把主页配置文件`_config.yml` 里的`post_asset_folder:`这个选项设置为`true`

2. 在你的hexo目录下执行这样一句话`npm install hexo-asset-image --save`，这是下载安装一个可以上传本地图片的插件

3. 清除缓存重新构建后，创建文章后会在文章同级的目录中有一个跟文章名一样的文件夹，图片放在里面就行

   ```shell
   hexo clean && hexo g
   ```