---
title: Parsing error x-invalid-end-tag
date: 2018-08-08 17:18:19
updated: 2018-08-08 17:26:45
comments: true
categories:
- WEB前端
tags:
- vue
- iview
- eslint
---

最近在使用vue2.0整合iview3.0的时候遇到了个“Parsing error: x-invalid-end-tag”问题，说白了就是eslint检查工具的问题。iview将标签渲染为原生html标签时，由于这些标签是自闭合的，所以有end标签会报错。 

##### 一. 问题日志

```node
✘  https://google.com/#q=vue%2Fno-parsing-error  Parsing error: x-invalid-end-tag
  src\components\register.vue:45:11
            </Input>
             ^
```

##### 二. 解决方案

根目录下找到 eslintrc.js 文件，在这个文件中找到 rules 选项，在下面添加以下信息，然后重启服务器。

```typescript
'vue/no-parsing-error': [2, {'x-invalid-end-tag': false}]
```

![666](/blog/images/iview回标签报错/666.png)
