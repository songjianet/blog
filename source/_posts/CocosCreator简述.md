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
> [Prefab介绍](https://docs.cocos.com/creator/manual/zh/asset-workflow/prefab.html?h=prefab)
> [Animation介绍](https://docs.cocos.com/creator/manual/zh/components/animation.html?h=animation)
> [AnimationClip介绍](https://docs.cocos.com/creator/manual/zh/animation/animation.html#clip-%E5%8A%A8%E7%94%BB%E5%89%AA%E8%BE%91)
> [instantiate方法](https://docs.cocos.com/creator/manual/zh/getting-started/quick-start.html?h=instantiate)
> [getComponent方法](https://docs.cocos.com/creator/manual/zh/scripting/access-node-component.html?h=getcomponent)

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

- 通常情况下开发者会使用`git`进行项目的管理，针对`CocosCreator`编辑器可视化界面的操作也是可以通过`git`进行管理的。

- 在项目创建后开发者可以在编辑器的资源管理器里面看到整个项目的目录结构，开发者只需管理`assets`目录即可，针对`internal`目录则是引擎自动为你创建的一个不可变动的目录。

![资源管理器](/blog/images/CocosCreator简述/1601433806377.jpg)

---

### 项目目录介绍

- `assets`目录是需要进行代码管理的，这个文件夹下会记录所有在`CocosCreator`编辑器可视化界面的操作。

- 之所以能与可视化编辑器做关联是因为在可视化编辑器操作的每一个属性都会与之对应的`prefab`或`scene`等资源做关联，可视化编辑器就相当于在操作资源中的某一个对象或属性。

- 在`assets`目录下每创建一个文件或者文件夹都会生成一个对应名称的`meta`文件，`meta`文件用于记录引擎使用该资源时所需的数据。

- 在对文件或文件夹执行创建、修改和删除操作的时候建议在`CocosCreator`编辑器中执行，通过`CocosCreator`编辑器之外对文件或文件夹的任何操作都无法记录到`meta`文件。

- `Cocos`游戏引擎的资源管理器是按照`uid`进行区分的，不是传统的按照文件路径进行区分，所以开发者无法设置相同的资源名称，如`scripts -> login -> index.js`和`scripts -> home -> index.js`也是会被引擎是别成一个相同的文件。

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

## `scene`

- 在游戏开发的过程中，开发者可以把`scene`理解为一个`html`页面，页面之间的切换就是`scene`之间的切换。

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

- 作为开发者没有办法去直接修改一个`scene`中根`canvas`节点上的`size`属性，但是可以通过修改根节点上`Canvas`组件的画布中的`Design Resolution`属性的尺寸。

- `scene`中`canvas`的尺寸取决于`ui`设计图的尺寸。

- `canvas`会根据不同的屏幕自动进行一定的适配，但是这并不是最完全的解决方案。

![修改场景中画布的尺寸](/blog/images/CocosCreator简述/1601445429445.jpg)

---

### 在`scene`中添加背景图片

- 通常情况下一个`scene`场景是需要一个甚至多个背景图片的。

- 在`scene`中添加背景图片需要在根`Canvas`组件的节点下创建一个`sprite`精灵元素，通过给`sprite`精灵元素设置尺寸与背景图片进而实现场景中有背景图片的效果。

- 出于要设置`scene`的背景图片，所以这里选择普通精灵组件进行设置。

- 更改`scene`中的根节点上`Canvas`组件尺寸为`1280*720`。

- 创建一个普通的`Sprite`组件，右键层级选择器中的`Sprite`组件重命名为`background`。

- 将资源管理器中的背景图片拖拽到名为`background`的`Sprite`精灵组件中`Sprite Frame`上。

- 设置`background`精灵的大小。

![设置场景背景图片](/blog/images/CocosCreator简述/1601448150617.jpg)

---

## `prefab`

- `prefab`是一个想要用在一个或多个项目中一个组件节点。

- `prefab`一旦创建后并且层级管理的`node`节点也被删除后，该`node`节点的信息不会自动在项目中加入，需要使用脚本进行控制。

- 当一个节点被拖拽转变成了`prefab`后，可以在层级管理器对该节点进行删除，如果想要对`prefab`有更改，可以在资源管理器中双击该`prefab`。

- `prefab`的根节点一般是一个空的`Node`组件，切该`Node`组件下允许有多个组件或脚本文件。

![创建空节点](/blog/images/CocosCreator简述/1601453429993.jpg)

- `prefab`并不能通过资源管理器进行创建，只能将一部分的节点从层级管理器中拖拽到资源管理器的一个目标路径。

![拖拽节点成Prefab](/blog/images/CocosCreator简述/1601453581158.jpg)

---

## `animation`

- `animation`是一个帧动画，它允许控制组件上所有属性动画，如：宽、高、缩放等。

- 一个`animation`上允许设置多个属性的动画。

- `animation`有两种播放形式，一种为自动播放，另一种为脚本调用。

- 当你的想从动画编辑器转身去做其它任何操作的时候，一定要关闭动画编辑器，否则会有动画无法保存的情况。

---

### 创建`animation`

- 点击想要创建动画的节点，并打开动画编辑器。

- 当节点上没有`Animation`是，可以通过属性检查器添加或者通过动画编辑器进行添加。

![创建animation](/blog/images/CocosCreator简述/1601457135329.jpg)

---

### 创建`clip`

- `clip`动画剪辑就是一份动画的声明数据，需要将它挂载到`Animation`组件上，就能够将这份动画数据应用到节点上。

![创建clip](/blog/images/CocosCreator简述/1601458180992.jpg)

---

### 绑定`clip`到`animation`

- 将创建好的`clip`从资源管理器拖拽到属性检查器中`Animation`组件的`Default Clip`属性上。

![绑定clip到animation](/blog/images/CocosCreator简述/1601458653128.jpg)

---

### 打开动画编辑器编辑功能

- 打开动画编辑器进行编辑，关闭动画编辑器的编辑功能也是该按钮。

![打开动画编辑器进行编辑](/blog/images/CocosCreator简述/1601459099288.jpg)

- 动画编辑器的节点与`Animation`组件所在的节点是相同的，并且动画可操作的属性也是`Animation`组件所属节点的属性。

![打开动画编辑器进行编辑](/blog/images/CocosCreator简述/1601599450411.jpg)

---

### 添加一个`scale`动画

- 这里实现的是一个简单的`scale`动画，其它类型的动画和动画组合不再讲述。

- 选择`scale`制作一个缩放的动画，在修改属性检查器中的`Scale`属性的时候，动画编辑器会自动为开发者插入一个关键帧。

- 如果没有开启动画编辑器的编辑状态，则不会动态创建一个关键帧。

- 在设置`Scale`属性值为`0`的时候，则该节点不会进行显示。

![添加动画第一帧](/blog/images/CocosCreator简述/1601601452462.jpg)

- 设置动画结束时间为`1.5`秒，并将动画编辑器中的播放头（红色竖线）拖拽到`0:15`的位置。

![拖动播放头](/blog/images/CocosCreator简述/1601601778261.jpg)

- 设置属性检查器中的`Scale`属性，将其值为`1`。

![设置结束值](/blog/images/CocosCreator简述/1601601913242.jpg)

- 点击动画编辑器中的播放按钮，查看编辑后的动画效果。

![查看动画效果](/blog/images/CocosCreator简述/QQ20201002-093007-HD.gif)

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

---

## 脚本操作

### 介绍

- 由于脚本存在一定的逻辑性和业务导向性，所以在这里只做一些简单的介绍，更多的请前往官网查看相关`api`。

- `Cocos`游戏引擎允许开发者使用`JavaScript`语言进行编写，这点对于前端工作人员是非常友好的，不仅`Cocos`一家，很多游戏引擎都支持`JavaScript`。

- 在游戏的脚本开发中，允许开发者使用代码去实现一些无法通过可视化编辑器操作的业务逻辑，如：接口、动态创建节点、修改节点属性、全局的事件分发机制等。

---

### 脚本模板

- `cc.Class`用于声明`Cocos Creator`中的类。它是一个很常用的`api`。

- `extends: cc.Component`基类，可以是任意创建好的`cc.Class`。

- `properties`用于属性值的定义。

- `onLoad`加载节点。

- `start`所有节点都执行完`onLoad`后才执行。

- `update`会在场景加载完成后每一帧都执行一次，一般把需要经常计算或及时更新的逻辑内容放在`update`中。

```javascript
cc.Class({
    extends: cc.Component,

    properties: {},

    onLoad () {},

    start () {},

    update (dt) {}
})
```

---

### 为组件创建脚本

- 在资源管理器中新建一个`JavaScript`文件。

- 点击需要此脚本的节点，在属性检查器中点击添加组件 -> 用户脚本组件后，可以看到整个项目中所有的脚本文件。

![给组件添加脚本](/blog/images/CocosCreator简述/1601605395313.jpg)

---

### 关联脚本变量与资源

- 每一个脚本中都有一个`properties`对象，该对象可以理解为一个在当前脚本内的一个变量。

- 通常脚本中的变量有两种使用方式，其一是作为与资源关联的桥梁，其二是可以用作当前脚本内的变量。

- 在脚本中需要创建一个变量才能与资源做关联，做关联的方式也是直接将资源拖拽到属性检查器脚本组件下的属性中。

![给组件添加脚本](/blog/images/CocosCreator简述/1601605601374.jpg)

- 当作为资源关联桥梁时，需要指定默认值和类型，类型可以是`Cocos`游戏引擎所有组件的类型。

```javascript
properties: {
  soundPrefab: {
    default: null, // 设置资源默认值
    type: cc.Prefab // 设置资源类型
  },
  count: 0 // 计数器，当作脚本内的运行变量
}
```

---

### 获取`prefab`

- 当把一个节点从层级管理器拖拽到资源管理器中变成一个`prefab`时，应该将这个节点从层级管理器中删除。

- `prefab`无法自动加载到一个`sence`中的某一个位置，只能通过脚本获取该`prefab`并将其挂载到一个`sence`中的一个`node`下。

```javascript
onLoad () {
  // 使用给定模板在场景中生成一个新的节点
  this.sound = cc.instantiate(this.soundPrefab)
}
```

--- 

### 将`prefab`添加到`node`

- 通过脚本加载`prefab`到`node`上时，不仅需要获取`prefab`资源，也需要获取`node`节点。

- 获取`node`节点的方式和获取`prefab`资源的方式相同，先声明一个变量，将其从层级管理器中拖拽到属性检查器中。

```javascript
properties: {
  soundPrefab: {
    default: null,
    type: cc.Prefab
  },
  backgroundNode: {
    default: null,
    type: cc.Node
  }
}

onLoad () {
  this.sound = cc.instantiate(this.soundPrefab)
  // 将prefab挂载在node下
  this.backgroundNode.addChild(this.sound)
}
```

---

### 通过脚本获取`sprite`

- 在开发者动态修改、创建一个或多个`sprite`时，则需要通过脚本获取`node`下的`sprite`。

- 该`node`也需要通过创建变量后与资源进行关联。

- 如果一个`node`只需要获取并没有其它节点需要挂载在该`node`下时，可以不写`instantiate`和`addChild`。

```javascript
properties: {
  backgroundNode: {
    default: null,
    type: cc.Node
  }
}

onload () {
  // 获取挂载在该节点下的所有动画
  // cc.Sprite则为Sprite组件
  // Sprite组件可以在该node下的属性检查器中找到
  // 获取挂载在该节点下的所有精灵
  // getComponent也可以获取到同节点的其它组件，如：Animation，Button等
  this.sprites = this.backgroundNode.getComponent(cc.Sprite)
}
```

### 场景切换

---

### 播放背景音乐

---

### 播放按钮点击音效

---

## 状态管理器

---

## 屏幕适配

---

## 针对小游戏进行分包

