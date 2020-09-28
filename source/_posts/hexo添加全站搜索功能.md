---
title: hexo添加全站搜索功能
date: 2018-01-19 16:47:13
updated: 2018-05-15 11:10:44
comments: true
categories:
- hexo
tags:
- hexo
---

本篇文章介绍一下hexo的全站搜索插件，功能是十分强大的，能够查看出所有包含带有与你输入关键字相同的文章。

![全站搜索示例图片](/blog/images/hexo添加全站搜索功能/1516351788.jpg)

1. 在hexo根目录安装插件

   ```sh
   npm install hexo-generator-searchdb --save
   ```

2. 修改站点配置文件

   ```shell
   search:
     path: search.xml
     field: post
     format: html
     limit: 10000
   ```

3. 修改主题配置文件

   ```shell
   local_search:
     enable: true
   ```
