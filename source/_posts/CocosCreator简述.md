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

## 导读

> `scene`： 场景
> `canvas`： 画布
> `prefab`： 预制体
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

---

## 相关链接

> [Cocos Creator](https://www.cocos.com/)
> [Cocos Creator编辑器基础](https://docs.cocos.com/creator/manual/zh/getting-started/basics/editor-overview.html)
> [meta文件介绍](https://docs.cocos.com/creator/manual/zh/extension/reference/meta-reference.html?h=meta)
> [Sprite精灵组件中的Size Mode属性](https://docs.cocos.com/creator/manual/zh/components/sprite.html?h=size%20mode)

---

## 基础概念

### 引擎基本介绍

- `cocos creator`是一个完整的游戏开发解决方案，包含了轻量高效的跨平台游戏引擎，以及能让你更快速开发游戏所需要的各种图形界面工具。

- `cocos creator`的编辑器是完全为引擎定制打造，包含从设计、开发、预览、调试到发布的整个工作流所需的全功能一体化编辑器。

- `cocos creator`支持`web`、`ios`、`android`、各类"小游戏"、`pc`客户端等平台。

---

### 游戏基本概念

在游戏开发的过程中会设定如`scene`、`canvas`、`prefab`、`animation`、`sprite`、`anchor`等基本概念，如果涉及其它概念请参阅官网介绍。

- `scene`：代指游戏中的场景，每个场景都是由不同的物体组合而成的一个集合，可以是建筑、特效、道具等。
    在游戏开发过程中场景管理的意义在于方便开发者快速定位到场景中的不同物体、能够处理巨大场景带来的内存开销问题和渲染效率问题、减少判断不同物体边界碰撞的检测效率问题。
    对于`2d`的游戏场景在内存和渲染的开销上都会远远小于`3d`游戏的场景。

- `canvas`：画布可以隶属于任何一个节点下，但是通常情况下在一个`scene`场景下只应有一个层级最高的`canvas`，所有的`ui`和可渲染元素都应设置为层级最高的`canvas`的子节点。
    `canvas`能够随时获得设备屏幕的实际分辨率并对场景中所有渲染元素进行适当的缩放。

- `prefab`：是一种资源类型，是一个能够在项目中反复使用的一个对象，因而当遇到需要反复使用的对象或资源时可以使用`prefab`，如游戏中的弹出框。
    `prefab`允许放置在多个`scene`中，也可以在一个`scene`中使用多个`prefab`。
    当一个`prefab`被放置在了一个`scene`中，就相当于在`scene`中创建了一个`prefab`实例。
    如果一个`prefab`在不同的`scene`中被实例化了多次，只需修改`prefab`就可以达到全部修改的效果。

- `animation`：作为动画可以使用在任何一种物体组件上。
    一般一个游戏会制作很多种动画，其中一部分可以通过组件自动调用，另一部分也可以通过代码去调用。

- `sprite`：精灵是游戏中十分重要的组成部分，每一个物体都可以理解为一个精灵元素，如游戏的背景、人物模型、道具等。
    `sprite`可以是一个允许被用户控制的对象，也可以是一个跟用户操作无关的对象。
    `sprite`的属性包含很多，如`position`、`rotate`、`scale`，`opacity`，`color`等。
    `sprite`包括单色精灵和普通精灵，两者的区别在于单色精灵创建后会有个纯白色的背景，通过设置背景颜色可以更改纯白色背景，而普通精灵则是创建了一个透明的背景。
    单色精灵和普通精灵在`Sprite`精灵组件的`Size Mode`属性上有不同的差异。
    
- `anchor`：基点可以理解为游戏中所有物体或组件的一个对齐点，如果一个游戏中存在多个`scene`，则允许对`scene`设置不同的基点。
    基点的坐标`x: 0, y: 0`表示左下角，`x: 1, y: 1`表示右上角。
    基点的改变会影响该`node`下的所有元素。
    
---

### 创建一个基于`cocos`引擎的项目

- 打开`Cocos Dashboard`控制台。

![cocos dashboard控制台](/blog/images/CocosCreator简述/1601429624326.jpg)

- 点击`Cocos Dashboard`控制台左侧菜单中的编辑器按钮，下载用于游戏开发`CocosCreator`编辑器。

![CocosCreator编辑器](/blog/images/CocosCreator简述/1601429920794.jpg)

- 点击`Cocos Dashboard`控制台左侧菜单中的项目按钮，点击右下角可以创建一个`Creator`或`Creator 3D`项目。

![创建项目](/blog/images/CocosCreator简述/7814A061-DC9F-4A86-9BD3-19C7DD951B4F.png)
    
- 可以根据自己的需求进行初始的项目模板选择、项目名称、项目路径等，选择后点击创建并打开按钮，即可完成项目的创建。

![选择项目模板](/blog/images/CocosCreator简述/1601430679113.jpg)

---

### 项目管理与多人协作

- 通常情况下我们会使用`git`进行项目的管理，针对`CocosCreator`编辑器可视化界面的操作也是可以通过`git`进行管理的。

- 在项目创建后我们可以在编辑器的资源管理器里面看到整个项目的目录结构，我们只需管理`assets`目录即可，针对`internal`目录则是引擎自动为你创建的一个不可变动的目录。

![资源管理器](/blog/images/CocosCreator简述/1601433806377.jpg)

---

### 项目目录介绍

- `assets`目录是需要进行代码管理的，这个文件夹下会记录所有在`CocosCreator`编辑器可视化界面的操作。

- 之所以能与可视化编辑器做关联是因为在可视化编辑器操作的每一个属性都会与之对应的`prefab`或`scene`等资源做关联，可视化编辑器就相当于在操作资源中的某一个对象或属性。

- 在`assets`目录下每创建一个文件或者文件夹都会生成一个对应名称的`meta`文件，`meta`文件用于记录引擎使用该资源时所需的数据。

- 在对文件或文件夹执行创建、修改和删除操作的时候建议在`CocosCreator`编辑器中执行，通过`CocosCreator`编辑器之外对文件或文件夹的任何操作都无法记录到`meta`文件。

```
assets/
├─scripts // 脚本文件夹
├─scripts.meta
|    ├─utils // 公共脚本文件夹
|    ├─utils.meta
├─scenes // 场景文件夹
├─scenes.meta
├─resources // 静态资源文件夹
├─resources.meta
|    ├─textures // 纹理、图片资源文件夹
|    ├─textures.meta
|    ├─sounds // 声音资源文件夹
|    ├─sounds.meta
|    ├─fonts // 字体资源文件夹
|    ├─fonts.meta
├─prefabs // 预制体文件夹
├─prefabs.meta
├─animations // 动画文件夹
├─animations.meta
```

---

## `scene`基本操作

- 在游戏开发的过程中，我们可以把`scene`理解为一个`html`页面，页面之间的切换就是`scene`之间的切换。

- `html`页面中的`button`、`table`都可以理解成`scene`中的一个物体元素组件。

- 文章下面会介绍如何在`scene`添加一个背景图片，如果想添加其它组件，其原理和操作方式大相径庭，所以不多做举例。

---

### 创建`scene`

- 创建`scenes`文件夹，并在`scenes`文件夹下创建一个名为`index`的`scene`场景。

![创建场景](/blog/images/CocosCreator简述/create_scene.png)

---

### 进入`scene`编辑状态

- 通过点击创建好的`index`场景文件，进入场景的可视化编辑。

![进入场景编辑状态](/blog/images/CocosCreator简述/1601444413564.jpg)

---

### 设置`scene`中`canvas`的尺寸

- 点击层级管理器中的根`canvas`节点后，属性检查器也对对应的发生变化。

- 属性检查器会对应当前在层级管理器中选中的节点。

- 我们没有办法去直接修改一个`scene`中根`canvas`节点上的`size`属性，但是可以通过修改根节点上`Canvas`组件的画布中的`Design Resolution`属性的尺寸。

- `scene`中`canvas`的尺寸取决于`ui`设计图的尺寸。

- `canvas`会根据不同的屏幕自动进行一定的适配，但是这并不是最完全的解决方案。

![修改场景中画布的尺寸](/blog/images/CocosCreator简述/1601445429445.jpg)

---

### 在`scene`中添加背景图片

- 通常情况下我们的一个`scene`场景是需要一个甚至多个背景图片的。

- 在`scene`中添加背景图片需要在根`Canvas`组件的节点下创建一个`sprite`精灵元素，通过给`sprite`精灵元素设置尺寸与背景图片进而实现场景中有背景图片的效果。

- 出于我们要设置`scene`的背景图片，所以这里选择普通精灵组件进行设置。

- 更改`scene`中的根节点上`Canvas`组件尺寸为`1280*720`。

- 创建一个普通的`Sprite`组件，右键层级选择器中的`Sprite`组件重命名为`background`。

- 将资源管理器中的背景图片拖拽到名为`background`的`Sprite`精灵组件中`Sprite Frame`上。

- 设置`background`精灵的大小。

![设置场景背景图片](/blog/images/CocosCreator简述/1601448150617.jpg)

---

## `prefab`基本操作

- `prefab`是一个想要用在一个或多个项目中一个组件节点。

- `prefab`一旦创建后并且层级管理的节点也被删除后，该节点的信息不会自动在项目中加入，需要使用脚本进行控制。

- 当一个节点被拖拽转变成了`prefab`后，可以在层级管理器对该节点进行删除，如果想要对`prefab`有更改，可以在资源管理器中双击该`prefab`。

- `prefab`的根节点一般是一个空的`Node`组件，切该`Node`组件下允许有多个组件或脚本文件。

![创建空节点](/blog/images/CocosCreator简述/1601453429993.jpg)

- `prefab`并不能通过资源管理器进行创建，只能将一部分的节点从层级管理器中拖拽到资源管理器的一个目标路径。

![拖拽节点成Prefab](/blog/images/CocosCreator简述/1601453581158.jpg)

---

## 预览方式

- 预览能够帮助开发者查看到当前的效果，通常预览方式有三种，分别为浏览器预览、模拟器预览、真机预览。

---

### 浏览器预览和模拟器预览

- `CocosCreator`编辑器最顶部中间位置上的播放按钮为浏览器预览和模拟器预览。

- 浏览器预览不会自动播放背景音乐，需要进行一次点击才会播放。

![浏览器预览和模拟器预览](/blog/images/CocosCreator简述/1601449503406.jpg)

---

### 真机预览

- 真机预览在`CocosCreator`编辑器右上角位置。

- 真机预览可以使用手机上的任何带有扫描二维码功能的软件进行扫码预览。

![真机局域网预览](/blog/images/CocosCreator简述/1601449536008.jpg)


