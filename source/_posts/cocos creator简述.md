---
title: cocos creator简述
date: 2020-09-28 15:09:13
updated: 2020-09-28 15:09:13
comments: true
categories:
- cocos
tags:
- cocos
---

### 导读

> `scene`： 场景
> `prefab`： 预置体
> `animation`： 动画
> `sprite`： 精灵
> `position`： 精灵位置
> `rotate`： 精灵旋转
> `scale`： 精灵缩放
> `opacity`： 精灵透明度
> `color`： 精灵颜色
> `anchor`： 基点
> `texture`： 图片资源
> `sound`： 声音资源
> `node`： 节点


### 相关链接

> [cocos creator](https://www.cocos.com/)


### 引擎基本介绍

- `cocos creator`是一个完整的游戏开发解决方案，包含了轻量高效的跨平台游戏引擎，以及能让你更快速开发游戏所需要的各种图形界面工具。

- `cocos creator`的编辑器是完全为引擎定制打造，包含从设计、开发、预览、调试到发布的整个工作流所需的全功能一体化编辑器。

- `cocos creator`支持`web`、`ios`、`android`、各类"小游戏"、`pc`客户端等平台。


### 游戏基本概念

在游戏开发的过程中会设定如`scene`、`prefab`、`animation`、`sprite`、`anchor`等基本概念，如果涉及其它概念请参阅官网介绍。

- `scene`：代指游戏中的场景，每个场景都是由不同的物体组合而成的一个集合，可以是建筑、特效、道具等。
    在游戏开发过程中场景管理的意义在于方便开发者快速定位到场景中的不同物体、能够处理巨大场景带来的内存开销问题和渲染效率问题、减少判断不同物体边界碰撞的检测效率问题。
    对于`2d`的游戏场景在内存和渲染的开销上都会远远小于`3d`游戏的场景。

- `prefab`：是一种资源类型，是一个能够在项目中反复使用的一个对象，因而当遇到需要反复使用的对象或资源时可以使用`prefab`，如游戏中的弹出框。
    `prefab`允许放置在多个`scene`中，也可以在一个`scene`中使用多个`prefab`。
    当一个`prefab`被放置在了一个`scene`中，就相当于在`scene`中创建了一个`prefab`实例。
    如果一个`prefab`在不同的`scene`中被实例化了多次，只需修改`prefab`就可以达到全部修改的效果。

- `animation`：作为动画可以使用在任何一种物体组件上。
    一般一个游戏会制作很多种动画，其中一部分可以通过组件自动调用，另一部分也可以通过代码去调用。

- `sprite`：精灵是游戏中十分重要的组成部分，每一个物体都可以理解为一个精灵元素，如游戏的背景、人物模型、道具等。
    `sprite`可以是一个允许被用户控制的对象，也可以是一个跟用户操作无关的对象。
    `sprite`的属性包含很多，如`position`、`rotate`、`scale`，`opacity`，`color`等。
    
- `anchor`：基点可以理解为游戏中所有物体或组件的一个对齐点，如果一个游戏中存在多个`scene`，则允许对`scene`设置不同的基点。
    基点的坐标`x: 0, y: 0`表示左下角，`x: 1, y: 1`表示右上角。
    基点的改变会影响该`node`下的所有元素。


### 创建一个基于`cocos`引擎的项目

- 打开`Cocos Dashboard`控制台。

![cocos dashboard控制台](/blog/images/cocos creator简述/1601429624326.jpg)

- 点击`Cocos Dashboard`控制台左侧菜单中的编辑器按钮，下载用于游戏开发`CocosCreator`编辑器。

![CocosCreator编辑器](/blog/images/cocos creator简述/1601429920794.jpg)

- 点击`Cocos Dashboard`控制台左侧菜单中的项目按钮，点击右下角可以创建一个`Creator`或`Creator 3D`项目。

![创建项目](/blog/images/cocos creator简述/7814A061-DC9F-4A86-9BD3-19C7DD951B4F.png)
    
- 可以根据自己的需求进行初始的项目模板选择、项目名称、项目路径等，选择后点击创建并打开按钮，即可完成项目的创建。

![选择项目模板](/blog/images/cocos creator简述/1601429920794.jpg)


### 项目管理与多人协作
