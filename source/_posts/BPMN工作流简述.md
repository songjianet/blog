---
title: bpmn工作流简述
date: 2020-11-09 17:39:12
updated: 2020-11-09 17:39:12
comments: true
categories:
- bpmn
tags:
- bpmn
---

## 前言

- `BPMN`全称为`Business Process Modeling Notation`，它是由业务流程管理倡议组织`BPMI`全称`The Business Process Management Initiative`开发的一套标准的业务流程建模符号规范。

- `BPMN`为用户提供一套容易理解的标准符号，这些符号作为`BPMN`的基础元素，将业务流程建模简单化、图形化，将复杂的建模过程视觉化，让业务建模者、业务实施人员、管理监督人员对`BPMN`描述的业务流程都有一个更加清晰明了的了解。

- `BPMN`允许开发者在现有的标准符号基础上自定义一些符合业务逻辑的元素，让使用者可以不去学习`BPMN`的流程图的绘制方式，以更简洁的元素展示给使用者。

- 如果使用`BPMN`自定义一些元素，则开发人员会有一定的负担，但是使用者会得到一个比较好的体验。

---

## 基础概念

- `Render`: 承载绘制流程的画布容器。

- `Viewer`: 流程查看器，功能最简单，仅用来展示。

- `NavigatedViewer`: 包含鼠标导航工具的图表查看器，在`Viewer`上扩展了导航和缩放功能。

- `Modeler`: 流程编辑器，融合了`Viewer`和`NavigatedViewer`。并拥有工具栏、属性面板等，实现建模能力。

- `Palette`: 指代左侧工具栏。

- `Shape`: 左侧工具栏中的每一个节点。

- `Connection`: 连接线节点。

- `Context-Pad`: 节点拖拽到`Render`中后，点击节点右侧出现的菜单。

- `Properties-Panel`: 节点属性的配置栏。

![基础概念图](/blog/images/BPMN工作流简述/1604987259267.jpg)

---

## `bpmn2.0`规范的`xml`介绍

---

## 安装

```shell
# yarn
yarn add bpmn-js

# npm
npm install bpmn-js

# cnpm
cnpm install bpmn-js
```

---

## 快速上手 

### 使用`Viewer`查看器

- `Viewer`不包含任何的鼠标拖拽、缩放、新增、编辑和删除节点等功能，只能用做展示使用。

```vue
<template>
  <div class="canvas" ref="canvas"></div>
</template>

<script>
import Modeler from 'bpmn-js/lib/Viewer'
import defaultXML from './default-xml'

export default {
  name: 'App',
  data() {
    return {
      viewer: null
    }
  },
  mounted() {
    this.viewer = new Modeler({
      container: this.$refs.canvas
    })
    try {
      this.viewer.importXML(defaultXML())
    } catch (err) {
      console.log(err)
    }
  }
}
</script>

<style lang="scss">
.canvas {
  width: 100%;
  height: 100vh;
}
</style>
```

![使用Viewer](/blog/images/BPMN工作流简述/1605064724382.jpg)

### 使用`NavigatedViewer`包含鼠标导航工具的查看器
