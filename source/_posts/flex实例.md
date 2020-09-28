---
title: flex实例
date: 2018-07-25 18:36:42
updated: 2018-12-11 17:11:29
comments: true
categories:
- WEB前端
tags:
- html
- css
- flex
---

最近由于换工作，没留出时间去打理博客，在上篇博客中我说要写一篇关于flex实例的博客，这篇博客包含几种常用的flex布局的方式。在后续维护中，我还会去丰富博客中的文章内容等。

##### 导航栏制作

例如，我们制作一个五条信息的导航栏，如果使用普通的栅格布局，并没有直接的方式去实现，所以我们会使用flex布局。



技术点：

flex: 1;



源码：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style type="text/css">
        .menu {
            display: flex
        }
        
        .menu>dd {
            flex: 1;
            margin-left: 0px;
            line-height: 100px;
            text-align: center;
            background-color: green;
        }
    </style>
</head>

<body>
    <dl class="menu">
        <dd>菜单一</dd>
        <dd>菜单二</dd>
        <dd>菜单三</dd>
        <dd>菜单四</dd>
        <dd>菜单五</dd>
    </dl>
</body>

</html>
```



效果展示：

![flex导航栏展示图](/blog/flex实例/1532516311.jpg)



#####  列宽固定

在一些特殊的情况下，我们会对flex的其中一列进行固定宽度的设置，让剩余列进行等分。



技术点：

flex: 0 0 50%; 



源码：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        dl {
            display: flex;
        }
        
        dd {
            flex: 1;
            margin: 0px;
            text-align: center;
            line-height: 100px;
            background-color: pink;
        }
        
        dd:nth-of-type(1) {
            flex: 0 0 50%;
        }
    </style>
</head>

<body>
    <dl>
        <dd>菜单一</dd>
        <dd>菜单二</dd>
        <dd>菜单三</dd>
        <dd>菜单四</dd>
        <dd>菜单五</dd>
    </dl>
</body>

</html>
```



效果展示：

![flex列宽固定展示图](/blog/flex实例/1532516344.jpg)



##### 水平垂直居中

很多时候我们在网页的布局中需要用到元素的水平垂直居中，我们一般有很多的方式去实现，在这里我们使用flex进行实现。



技术点：

justify-content: center;

align-items: center;



源码：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style type="text/css">
        .flex_container {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 500px;
            height: 300px;
            border: 1px solid pink;
        }
        
        .content {
            width: 160px;
            height: 160px;
            border: 1px solid green;
        }
    </style>
</head>

<body>
    <div class="flex_container">
        <div class="content">
            <p>内容展示内容展示内容展示内容展示内容展示内容展示内容展示内容展示内容展示内容展示内容展示内容展示内容展示</p>
        </div>
    </div>
</body>

</html>
```



效果展示：

![flex水平垂直居中展示图](/blog/flex实例/1532516397.jpg)



##### 流式布局

我们可以通过flex构建流式布局的页面结构。



技术点：

flex-wrap: wrap;

align-content: flex-start;



源码：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        .demo {
            width: 350px;
            height: 350px;
            display: flex;
            flex-wrap: wrap;
            align-content: flex-start;
            background-color: aquamarine;
        }
        
        .items {
            width: 100px;
            height: 100px;
            border: 1px solid red;
            background-color: #fff;
        }
    </style>
</head>

<body>
    <div class="demo">
        <div class="items"></div>
        <div class="items"></div>
        <div class="items"></div>
        <div class="items"></div>
        <div class="items"></div>
        <div class="items"></div>
        <div class="items"></div>
        <div class="items"></div>
    </div>
</body>

</html>
```



效果展示：

![flex流式布局展示图](/blog/flex实例/1532516372.jpg)



##### 左图右信息

很多时候我们要制作卡片结构的网站，如果使用flex会比不适用flex简单很多。



技术点：

justify-content: space-around; 

flex: none; 



源码：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        .demo {
            width: 400px;
            height: 200px;
            display: flex;
            justify-content: space-around;
            border: 1px solid pink;
        }
        
        .demo>div {
            flex: none;
        }
        
        .left {
            width: 60px;
            height: 100%;
            background-color: green;
        }
        
        .btn {
            align-items: center;
        }
    </style>
</head>

<body>
    <div class="demo">
        <div class="left"></div>
        <div class="right">
            <h3>这是一个h3</h3>
            <span>这是一个span</span>
            <span>这是一个span</span>
        </div>
        <div class="btn">按钮</div>
    </div>
</body>

</html>
```



效果展示：

![flex左图右信息展示图](/blog/flex实例/1532516438.jpg)



##### 两端对齐

可以抛弃掉float控制两端对齐的传统方式。

技术点：

flex-direction: row;
justify-content: space-between;

源码：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        .demo {
            width: 400px;
            height: 200px;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            border: 1px solid blueviolet;
        }
    </style>
</head>

<body>
    <div class="demo">
        <div>left</div>
        <div>right</div>
    </div>
</body>

</html>
```



效果展示：

![flex两端对齐展示图](/blog/flex实例/1544519349.jpg)
