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

- `xml`的`definitions`标签内必须含有`bpmn`规范的属性。

- `xml`中所有标签的`id`属性不能有重复。

- 所有从`Palette`中拖拽到`Render`的节点，包括`Shape`和`Connection`，都需要在`process`标签中呈现。

- `bpmndi`标签代表`Render`中绘制的所有内容，包括`Shape`、`Connection`以及位置和路径。

```ecmascript6
export default function() {
  return `<?xml version="1.0" encoding="UTF-8"?>
            <definitions xmlns="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:omgdi="http://www.omg.org/spec/DD/20100524/DI" xmlns:omgdc="http://www.omg.org/spec/DD/20100524/DC" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" id="sid-38422fae-e03e-43a3-bef4-bd33b32041b2" targetNamespace="http://bpmn.io/bpmn" exporter="bpmn-js (https://demo.bpmn.io)" exporterVersion="5.1.2">
              <process id="Process_1" isExecutable="false">
                <startEvent id="StartEvent_1y45yut" name="开始">
                <outgoing>SequenceFlow_0h21x7r</outgoing>
                </startEvent>
                <task id="Task_1hcentk">
                <incoming>SequenceFlow_0h21x7r</incoming>
                </task>
                <sequenceFlow id="SequenceFlow_0h21x7r" sourceRef="StartEvent_1y45yut" targetRef="Task_1hcentk" />
              </process>
              <bpmndi:BPMNDiagram id="BpmnDiagram_1">
                <bpmndi:BPMNPlane id="BpmnPlane_1" bpmnElement="Process_1">
                  <bpmndi:BPMNShape id="StartEvent_1y45yut_di" bpmnElement="StartEvent_1y45yut">
                    <omgdc:Bounds x="152" y="102" width="36" height="36" />
                    <bpmndi:BPMNLabel>
                      <omgdc:Bounds x="160" y="145" width="22" height="14" />
                    </bpmndi:BPMNLabel>
                  </bpmndi:BPMNShape>
                  <bpmndi:BPMNShape id="Task_1hcentk_di" bpmnElement="Task_1hcentk">
                    <omgdc:Bounds x="240" y="80" width="100" height="80" />
                  </bpmndi:BPMNShape>
                  <bpmndi:BPMNEdge id="SequenceFlow_0h21x7r_di" bpmnElement="SequenceFlow_0h21x7r">
                    <omgdi:waypoint x="188" y="120" />
                    <omgdi:waypoint x="240" y="120" />
                  </bpmndi:BPMNEdge>
                </bpmndi:BPMNPlane>
              </bpmndi:BPMNDiagram>
            </definitions>`
}
```

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

- 查看器和编译器都要对一个`html`容器设置一个宽高，否则会造成内容显示不全和闪现的问题。

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

- 使用`NavigatedViewer`后，`Render`画布内的节点属性支持缩放、拖拽功能。

```ecmascript6
import Modeler from 'bpmn-js/lib/NavigatedViewer'
```

### 使用`Modeler`编辑器

- 使用`Modeler`时需要引入`css`文件，可以通过`scss`等其它预编译器引入。

- 缩放、前进后退、打开、下载等功能需要单独编写方法进行支持。

- 下图显示的是`bpmn`在`Modeler`模式下提供的默认组件，并非全部组件。

```ecmascript6
import Modeler from 'bpmn-js/lib/Modeler'
import 'bpmn-js/dist/assets/diagram-js.css' // 左边工具栏以及编辑节点的样式
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-codes.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css'
```

![使用Modeler](/blog/images/BPMN工作流简述/1605084566835.jpg)

---
