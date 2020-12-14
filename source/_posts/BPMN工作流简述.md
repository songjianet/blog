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

```vue
<template>
  <div class="canvas" ref="canvas"></div>
</template>

<script>
import Modeler from 'bpmn-js/lib/Modeler'
import 'bpmn-js/dist/assets/diagram-js.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-codes.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css'
import defaultXML from './default-xml'

export default {
  name: 'App',
  data() {
    return {
      modeler: null
    }
  },
  mounted() {
    this.modeler = new Modeler({
      container: this.$refs.canvas
    })
    try {
      this.modeler.importXML(defaultXML())
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

![使用Modeler](/blog/images/BPMN工作流简述/1605084566835.jpg)

### 节点属性配置面板

- 一个默认的`bpmn`设计器是不带有右侧的节点属性配置面板的。

- 节点属性配置面板可以有两种实现方式，其一是使用官方提供的插件实现，其二是可以通过自定义`vue`组件，在将`Shape`从`Palette`中拖拽到`Render`时，可以通过`Modeler`提供的事件监听，对用户点击过的`Shape`在右侧替换对应的`vue`组件。

- 这一部分会使用第一种方式进行配置右侧的节点属性栏，第二种方式会在后续的自定义中进行讲解。

- 安装`bpmn-js-properties-panel`和`camunda-bpmn-moddle`插件。

```shell
# yarn
yarn add bpmn-js-properties-panel
yarn add camunda-bpmn-moddle

# npm
npm install bpmn-js-properties-panel
npm install camunda-bpmn-moddle

#cnpm
cnpm install bpmn-js-properties-panel
cnpm install camunda-bpmn-moddle
```

- 在`html`部分与`canvas`同级，增加用于承载节点属性配置面板的容器。

```vue
<div class="bpmn-container">
  <div class="canvas" ref="canvas"></div>
  <div class="properties" ref="properties"></div>
</div>
```

- 引入对应的`js`和`css`。

```ecmascript6
import propertiesPanelModule from 'bpmn-js-properties-panel'
import propertiesProviderModule from 'bpmn-js-properties-panel/lib/provider/camunda'
import camundaModdleDescriptor from 'camunda-bpmn-moddle/resources/camunda'
import 'bpmn-js-properties-panel/dist/assets/bpmn-js-properties-panel.css'
```

- 在`new Modeler`中增加`propertiesPanel`、`additionalModules`和`moddleExtensions`对象。

```javascript
this.viewer = new Modeler({
  container: this.$refs.canvas,
  propertiesPanel: {
    parent: this.$refs.properties
  },
  additionalModules: [
    propertiesProviderModule,
    propertiesPanelModule
  ],
  moddleExtensions: {
    camunda: camundaModdleDescriptor
  }
})
```

- 由于之前将`class`为`canvas`容器的样式设置成了`100%`，所以节点属性配置面板不会展示出来，对此需要修改一部分样式。

```scss
.bpmn-container {
  display: flex;
  justify-content: space-between;

  .canvas {
    width: 80%;
    height: 100vh;
  }

  .properties {
    width: 20%;
  }
}
```

![节点属性配置面板](/blog/images/BPMN工作流简述/1605087706732.jpg)

---

## 全局操作

- 全局操作包括用户的缩放行为、画布的自适应、上一步下一步、下载、保存、打开等操作。

![全剧操作](/blog/images/BPMN工作流简述/1605146722819.jpg)

### 上一步

```vue
previous() {
  const commandStack = this.modeler.get('commandStack')

  // 没有可以执行的上一步操作，可以通过下面条件对上一步按钮设置禁用
  if (commandStack._stackIdx === -1) { return false }

  commandStack.undo()
}
```

### 下一步

```vue
next() {
  const commandStack = this.modeler.get('commandStack')
  
  // 没有可以执行的下一步操作，可以通过下面条件对下一步按钮设置禁用
  if (commandStack._stack.length - 1 === commandStack._stackIdx) { return false }

  commandStack.redo()
}
```

### 放大

```vue
zoomIn() {
  let zoom = this.modeler.get('canvas').zoom()

  zoom += 0.1

  // 保存当前的缩放比例到vue的data中，后续用于通过输入框控制缩放时使用
  // 保留一位小数，避免出现计算精度影响功能的情况
  this.zoom = Number(zoom.toFixed(1))

  this.modeler.get('canvas').zoom(zoom)
}
```

### 缩小

```vue
zoomOut() {
  let zoom = this.modeler.get('canvas').zoom()

  zoom -= 0.1

  this.zoom = Number(zoom.toFixed(1))

  this.modeler.get('canvas').zoom(zoom)
}
```

### 输入框控制缩放

```vue
<template>
  <div>
    <el-input v-model.number="zoomScale" size="mini" @change="setZoom" suffix-icon="el-icon-connection"></el-input>
    <div class="canvas" ref="canvas"></div>
    <div class="properties" ref="properties"></div>
  </div>
</template>

<script>
import Modeler from 'bpmn-js/lib/Modeler'
import 'bpmn-js/dist/assets/diagram-js.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-codes.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css'

export default {
  data() {
    return {
      zoom: 1, // 缩放比例
      zoomScale: 100, // 缩放基础值
      modeler: null
    }
  },
  mounted() {
    this.modeler = new Modeler({
      container: this.$refs.canvas
    })
  },
  methods: {
     setZoom() {
       this.zoom = this.zoomScale / 100
       this.modeler.get('canvas').zoom(this.zoom)
     }
  }
}
</script>
```

### 适应画布

```vue
<template>
  <div>
    <div class="canvas" ref="canvas"></div>
    <div class="properties" ref="properties"></div>
  </div>
</template>

<script>
import Modeler from 'bpmn-js/lib/Modeler'
import 'bpmn-js/dist/assets/diagram-js.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-codes.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css'

export default {
  data() {
    return {
      zoom: 1, // 缩放比例
      modeler: null
    }
  },
  mounted() {
    this.modeler = new Modeler({
      container: this.$refs.canvas
    })
  },
  methods: {
    fitViewport() {
      this.zoom = this.modeler.get('canvas').zoom('fit-viewport')
    
      const bBox = document.querySelector('.viewport').getBBox()
      const currentViewBox = this.modeler.get('canvas').viewbox()
      const elementMid = {
        x: bBox.x + bBox.width / 2 - 65,
        y: bBox.y + bBox.height / 2
      }
    
      this.modeler.get('canvas').viewbox({
        x: elementMid.x - currentViewBox.width / 2,
        y: elementMid.y - currentViewBox.height / 2,
        width: currentViewBox.width,
        height: currentViewBox.height
      })
    
      this.zoom = bBox.width / currentViewBox.width * 1.8
    }
  }
}
</script>
```

### 打开

- 打开`xml`本质就是一个上传文件的方法，然后将文件中的`xml`内容重新装载。

- 装载方式是使用`importXML`方法装载`xml`，可以查看文章中《快速上手 -> 使用`Modeler`编辑器》部分的介绍。

```vue
<template>
  <el-upload action="" :before-upload="beforeUpload">
    <div class="open">
      <i class="el-icon-folder-opened"></i>
      <p>打开</p>
    </div>
  </el-upload>
</template>

<script>
export default {
  methods: {
    beforeUpload(file) {
      const reader = new FileReader()

      reader.readAsText(file, 'utf-8')
      reader.onload = () => {
        console.log(reader.result) // xml内容
      }

      return false
    }
  }
}
</script>
```

### 新建

- 新建可以用于加载后端提供的`xml`模板，可以让使用者基于不同的模板进行绘制，减少用户的绘制时间。

### 重做

- 重做就是使用`importXML`方法装载一个空的`xml`文件。

### 下载xml

```ecmascript6
async downloadXML() {
  try {
    let { xml } = await this.modeler.saveXML({ format: true })

    downloadFile(`${this.modeler.getDefinitions().rootElements[0].name}.bpmn20.xml`, drawToXML(xml), 'application/xml')

    return xml
  } catch (err) {
    console.log(err)
  }
}
```

### 下载svg

```ecmascript6
async downloadSVG() {
  try {
    const { svg } = await this.modeler.saveSVG({ format: true })

    downloadFile(this.modeler.getDefinitions().rootElements[0].name, svg, 'image/svg+xml')

    return svg
  } catch (err) {
    console.log(err)
  }
}
```

### 保存

- 保存方法与下载`xml`方法是一致的，保存方法主要用于将`xml`通过接口发送给后端服务。

### 缩略预览

- 安装`diagram-js-minimap`插件。

```shell
# yarn
yarn add diagram-js-minimap

# npm
npm install diagram-js-minimap

# cnpm
cnpm install diagram-js-minimap
```

- 引入。

```ecmascript6
import minimapModule from 'diagram-js-minimap'
import 'diagram-js-minimap/assets/diagram-js-minimap.css'
```

- 在`Modeler`中装载插件。

```ecmascript6
this.modeler = new Modeler({
  container: this.$refs.canvas,
  additionalModules: [
    minimapModule
  ]
})
```

![关闭状态的效果](/blog/images/BPMN工作流简述/1605156209317.jpg)

- 插件默认为`close`状态，如果需要在项目打开时缩放预览为`open`状态，可执行以下代码。

```ecmascript6
this.modeler.get('minimap').open()
```

![打开状态的效果](/blog/images/BPMN工作流简述/1605156282864.jpg)

- 如果不满意默认的缩放预览效果，可以通过样式覆盖的形式去更改，在后续的文章中会以一个例子介绍具体的更改方法。

---

## 自定义`Palette`

- 在了解了`bpmn`基础概念和使用后，对一些模块以及它们之间的配合应该有了一定的概念，同时`bpmn`的默认样式可能无法满足业务的需求。

- 自定义`Palette`后允许通过配置生成工具栏、更改工具栏样式和布局等。

- 自定义的方式包含两种，其一是基于`Modeler`中的`Palette`进行修改，其二是完全重写`Palette`方法。

### 新建目录和文件

- 在`components`目录下新建`modeler`目录，在`modeler`目录下新建`palette`目录和`index.js`文件。

- 在`palette`目录下新建`CustomPalette.js`文件。

![基于`Modeler`中的`Palette`进行自定义目录结构](/blog/images/BPMN工作流简述/1605245857229.jpg)

### 基于`Modeler`中的`Palette`进行自定义

#### 编写`CustomPalette.js`代码

- 使用`$inject`注入一些需要的变量。

- 在类中使用`palette.registerProvider(this)`指定这是一个`palette`。

- `CustomPalette`类中的核心代码是`getPaletteEntries`函数，该函数的名称不能改变, 该函数返回的是一个对象, 对象中指定的内容就是自定义的中的每一项。

- `group`: 属于哪个分组, `比如tools`、`event`、`gateway`、`activity等等`。

- `className`: 样式类名, 我们可以通过它给元素修改样式。

- `title`: 鼠标移动到元素上面给出的提示信息。

- `action`: 用户操作时会触发的事件

```ecmascript6
export default class CustomPalette {
  constructor(bpmnFactory, create, elementFactory, palette, translate) {
    this.bpmnFactory = bpmnFactory
    this.create = create
    this.elementFactory = elementFactory
    this.translate = translate

    palette.registerProvider(this)
  }

  getPaletteEntries(element) {
    console.log(element)

    const {
      bpmnFactory,
      create,
      elementFactory,
      translate
    } = this

    function createTask() {
      return function(event) {
        const businessObject = bpmnFactory.create('bpmn:StartEvent')
        const shape = elementFactory.createShape({
          type: 'bpmn:StartEvent',
          businessObject
        })
        create.start(event, shape)
      }
    }

    return {
      'create.test-start-event': {
        group: 'model',
        className: 'icon-custom test-start-event',
        title: translate('创建一个开始节点'),
        action: {
          dragstart: createTask(),
          click: createTask()
        }
      }
    }
  }
}

CustomPalette.$inject = [
  'bpmnFactory',
  'create',
  'elementFactory',
  'palette',
  'translate'
]
```

#### 编写`index.js`文件

- `__init__`中的名字就必须是`customPalette`。

```ecmascript6
import CustomPalette from './palette/CustomPalette'

export default {
  __init__: ['customPalette'],
  customPalette: ['type', CustomPalette]
}
```

#### 在`vue`文件中引入

```vue
<script>
import customPalette from './components/modeler'

export default {
  mounted() {
    this.modeler = new Modeler({
      container: this.$refs.canvas,
      additionalModules: [
        customPalette
      ]
    })
  }
}
</script>
```

#### 编写样式

- 编写样式样式，能够在左侧`Palette`中展示自定义的节点。

```css
.icon-custom {
  border-radius: 50%;
  background-size: 65%;
  background-repeat: no-repeat;
  background-position: center;
}

.icon-custom.test-start-event {
  background-image: url('https://zdgg-scrm.oss-cn-shanghai.aliyuncs.com/bpmn/liuchengkongzhi/start.png');
}
```

#### 查看效果

![基于`Modeler`中的`Palette`进行自定义完成效果](/blog/images/BPMN工作流简述/1605170483360.jpg)

### 重写`Palette`方法

- 上面的代码通过修改`Modeler`中的`Palette`实现了对`Palette`中的节点进行自定义的功能，但是如果想实现以下红线圈出效果，则需要重写`Palette`方法。

![重写`Palette`方法展示图](/blog/images/BPMN工作流简述/1605172503339.jpg)

#### 编写`CustomPalette.js`代码

```ecmascript6
export default function PaletteProvider(palette, create, elementFactory, globalConnect) {
  this.create = create
  this.elementFactory = elementFactory
  this.globalConnect = globalConnect

  palette.registerProvider(this)
}

PaletteProvider.$inject = [
  'palette',
  'create',
  'elementFactory',
  'globalConnect'
]

PaletteProvider.prototype.getPaletteEntries = function() {
  const {
    create,
    elementFactory
  } = this

  function createTask() {
    return function(event) {
      const shape = elementFactory.createShape({
        type: 'bpmn:StartEvent'
      })
      console.log(shape)
      create.start(event, shape)
    }
  }

  return {
    'create.test-start-event': {
      group: 'model',
      className: 'icon-custom test-start-event',
      title: '创建一个开始节点',
      action: {
        dragstart: createTask(),
        click: createTask()
      }
    }
  }
}
```

#### 编写`index.js`代码

```ecmascript6
import Modeler from 'bpmn-js/lib/Modeler'
import inherits from 'inherits'
import CustomPalette from './palette/CustomPalette'

export default {
  __init__: ['paletteProvider'],
  paletteProvider: ['type', CustomPalette]
}

export default function CustomModeler(options) {
  Modeler.call(this, options)
  this._customElements = []
}

inherits(CustomModeler, Modeler)
CustomModeler.prototype._modules = [].concat(
  CustomModeler.prototype._modules, [
    CustomModule
  ]
)
```

#### 在`vue`文件中引入

- 当重写`Palette`方法后，将不再通过`BpmnModeler`进行创建，需要通过`CustomModeler`进行创建。

```vue
<script>
import CustomModeler from './components/modeler'

export default {
  mounted() {
    this.modeler = new CustomModeler({
      container: this.$refs.canvas
    })
  }
}
</script>
```

#### 编写样式

- 样式使用《基于`Modeler`中的`Palette`进行自定义》中的样式。

#### 产看效果

![重写`Palette`方法完成效果](/blog/images/BPMN工作流简述/1605174390912.jpg)

### 修改`Palette`样式

- 想要更改默认的`Palette`侧边栏的样式需要对`dom`结构有一定的更改，同时也要增加一部分样式。

- 获取`canvas`容器，获取`Palette`侧边栏的`dom`节点。

```ecmascript6
const canvas = this.$refs.canvas
const djsPalette = canvas.children[0].children[1].children[5]
```

- 拿到节点后就可以对其进行节点以及样式的增删改等操作。

---

## 自定义`Renderer`

- 由于画布中的图形为`svg`，与`Palette`不同的是`Palette`使用的是`html`，如果需要深度自定义（不仅仅是替换节点在`Render`中显示的图标）需要一定的`svg`知识。

- 在自定义`Palette`后，将一个节点从`Palette`栏拖拽到`Render`后，节点在`Render`上展示的还是默认类型的样子。

![重写`Palette`方法完成效果](/blog/images/BPMN工作流简述/1605235889814.jpg)

### 新建目录和文件

- 在`components -> modeler`下新建`renderer`文件夹，在`renderer`文件夹下新建`CustomRenderer.js`文件。

- 在`components -> modeler`下新建`utils.js`文件。

![在默认的`Renderer`上进行自定义目录结构](/blog/images/BPMN工作流简述/1605236911318.jpg)

### 在默认的`Renderer`上进行自定义

#### 编写`CustomRenderer.js`代码

- 由于是在`bpmn.js`已有的元素上进行修改, 所以所以需要将`BaseRenderer`这个类引入进来, 然后自定义`renderer`来继承它。

- 代码中`HIGH_PRIORITY`不能去掉, 否则不会执行`drawShape`函数。

```ecmascript6
import BaseRenderer from 'diagram-js/lib/draw/BaseRenderer'
import { customElements, customConfig } from '../utils'
import { append as svgAppend, create as svgCreate } from 'tiny-svg'

const HIGH_PRIORITY = 1500

export default class CustomRenderer extends BaseRenderer {
  constructor(eventBus, bpmnRenderer) {
    super(eventBus, HIGH_PRIORITY)
    this.bpmnRenderer = bpmnRenderer
  }

  canRender(element) {
    return !element.labelTarget
  }

  drawShape(parentNode, element) {
    const type = element.type

    if (customElements.includes(type)) {
      const { url, attr } = customConfig[type]
      const customIcon = svgCreate('image', {
        ...attr,
        href: url
      })
      element['width'] = attr.width
      element['height'] = attr.height
      svgAppend(parentNode, customIcon)

      return customIcon
    }

    const shape = this.bpmnRenderer.drawShape(parentNode, element)

    return shape
  }

  getShapePath(shape) {
    return this.bpmnRenderer.getShapePath(shape)
  }
}

CustomRenderer.$inject = ['eventBus', 'bpmnRenderer']
```

#### 编写`utils.js`代码

- 自定义的`Palette`中的节点的类型需要在`customElements`中注册，否则当用户拖拽一个节点从`Palette`侧边栏到`Render`中会提示找不到组件的错误。

- `customConfig`中的对象在`CustomRenderer.js`中

```ecmascript6
const customElements = ['bpmn:StartEvent']

const customConfig = {
  'bpmn:StartEvent': {
    'url': 'https://zdgg-scrm.oss-cn-shanghai.aliyuncs.com/bpmn/liuchengkongzhi/start.png',
    'attr': { x: 0, y: 0, width: 48, height: 48 }
  }
}

export { customElements, customConfig }
```

#### 编写`index.js`代码

```ecmascript6
import Modeler from 'bpmn-js/lib/Modeler'
import inherits from 'inherits'
import CustomPalette from './palette/CustomPalette'
import CustomRenderer from './renderer/CustomRenderer'

const CustomModule =  {
  __init__: ['paletteProvider', 'customRenderer'],
  paletteProvider: ['type', CustomPalette],
  customRenderer: ['type', CustomRenderer]
}

export default function CustomModeler(options) {
  Modeler.call(this, options)
  this._customElements = []
}

inherits(CustomModeler, Modeler)
CustomModeler.prototype._modules = [].concat(
  CustomModeler.prototype._modules, [
    CustomModule
  ]
)
```

### 重写`Renderer`方法

- 对于重写`Renderer`方法而言，只需修改`CustomRenderer.js`文件的代码，`index.js`和`utils.js`文件与在《默认的`Renderer`上进行自定义》的内容一致。

#### 编写`CustomRenderer.js`代码

```ecmascript6
import inherits from 'inherits'
import BaseRenderer from 'diagram-js/lib/draw/BaseRenderer'
import { append as svgAppend, create as svgCreate } from 'tiny-svg'
import { customElements, customConfig } from '../utils'

export default function CustomRenderer(eventBus) {
  BaseRenderer.call(this, eventBus, 2000)

  this.drawCustomElements = function(parentNode, element) {
    const type = element.type // 获取到类型

    if (customElements.includes(type)) { // or customConfig[type]
      const { url, attr } = customConfig[type]
      const customIcon = svgCreate('image', {
        ...attr,
        href: url
      })

      element['width'] = attr.width
      element['height'] = attr.height
      svgAppend(parentNode, customIcon)

      return customIcon
    }

    const shape = this.bpmnRenderer.drawShape(parentNode, element)

    return shape
  }
}

inherits(CustomRenderer, BaseRenderer)

CustomRenderer.$inject = ['eventBus', 'styles']

CustomRenderer.prototype.canRender = function(element) {
  return !element.labelTarget
}

CustomRenderer.prototype.drawShape = function(p, element) {
  return this.drawCustomElements(p, element)
}

CustomRenderer.prototype.getShapePath = function(shape) {
  console.log(shape)
}
```

### 实现效果

![自定义`Renderer`效果](/blog/images/BPMN工作流简述/1605249951861.jpg)

---

## 自定义`ContextPad`

- 默认效果的`ContextPad`。

- 可以看到除了在左侧的工具栏处能添加节点之外, 点击节点的时候也会出现一个小弹窗, 这里面也可以添加节点。

![`ContextPad`默认效果](/blog/images/BPMN工作流简述/1605252528039.jpg)

### 新建目录和文件

- 在`components -> modeler`下新建`context-pad`文件夹，在`context-pad`文件夹下新建`CustomContextPad.js`文件。

![自定义`CustomContextPad`目录结构](/blog/images/BPMN工作流简述/1605252797758.jpg)

### 在默认的`ContextPad`上自定义

#### 编写`CustomContextPad.js`代码

- 其实自定义`ContextPad`和`Palette`很像, 只不过是使用`contextPad.registerProvider(this)`来指定它是一个`ContextPad`, 而自定义`Palette`是用`paltette.registerProvider(this)`。

- `getContextPadEntries`方法与自定义`palette`时候的`getPaletteEntries`方法返回的参数相似。

```ecmascript6
export default class CustomContextPad {
  constructor(config, contextPad, create, elementFactory, injector, translate) {
    this.create = create
    this.elementFactory = elementFactory
    this.translate = translate

    if (config.autoPlace !== false) {
      this.autoPlace = injector.get('autoPlace', false)
    }

    contextPad.registerProvider(this)
  }

  getContextPadEntries(element) {
    const {
      autoPlace,
      create,
      elementFactory,
      translate
    } = this

    function appendTask(event, element) {
      if (autoPlace) {
        const shape = elementFactory.createShape({ type: 'bpmn:StartEvent' })
        autoPlace.append(element, shape)
      } else {
        appendTaskStart(event, element)
      }
    }

    function appendTaskStart(event) {
      const shape = elementFactory.createShape({ type: 'bpmn:StartEvent' })
      create.start(event, shape, element)
    }

    return {
      'append.test-start-event': {
        group: 'model',
        className: 'icon-custom test-start-event',
        title: translate('创建一个开始节点'),
        action: {
          click: appendTask,
          dragstart: appendTaskStart
        }
      }
    }
  }
}

CustomContextPad.$inject = [
  'config',
  'contextPad',
  'create',
  'elementFactory',
  'injector',
  'translate'
]
```

#### 编写`index.js`代码

```ecmascript6
import Modeler from 'bpmn-js/lib/Modeler'
import inherits from 'inherits'
import CustomPalette from './palette/CustomPalette'
import CustomRenderer from './renderer/CustomRenderer'
import CustomContextPadProvider from './context-pad/CustomContextPad'

const CustomModule =  {
  __init__: ['paletteProvider', 'customRenderer', 'contextPadProvider'],
  paletteProvider: ['type', CustomPalette],
  customRenderer: ['type', CustomRenderer],
  contextPadProvider: ['type', CustomContextPadProvider]
}

export default function CustomModeler(options) {
  Modeler.call(this, options)
  this._customElements = []
}

inherits(CustomModeler, Modeler)
CustomModeler.prototype._modules = [].concat(
  CustomModeler.prototype._modules, [
    CustomModule
  ]
)
```

#### 编写样式

- 在`App.vue`中增加样式。

```css
.djs-context-pad .test-start-event.entry:hover {
  background: url('https://zdgg-scrm.oss-cn-shanghai.aliyuncs.com/bpmn/liuchengkongzhi/start.png') center no-repeat !important;
  background-size: cover !important;
}

.djs-context-pad .entry:hover { /* 重新修改了 hover 之后的样式 */
  border: 1px solid #1890ff;
}

.djs-context-pad .entry {
  box-sizing: border-box;
  background-size: 94%;
  transition: all 0.3s;
}
```

### 重写`ContextPad`方法

- 重写`ContextPad`方法只需要修改`CustomContextPad.js`中的代码，对于`utils.js`和`App.vue`则与《在默认的`ContextPad`上自定义》相同。

#### 编写`CustomContextPad.js`代码

```ecmascript6
export default function ContextPadProvider(contextPad, config, injector, translate, bpmnFactory, elementFactory, create, modeling, connect) {
  this.create = create
  this.elementFactory = elementFactory
  this.translate = translate
  this.bpmnFactory = bpmnFactory
  this.modeling = modeling
  this.connect = connect

  config = config || {}

  if (config.autoPlace !== false) {
    this._autoPlace = injector.get('autoPlace', false)
  }

  contextPad.registerProvider(this)
}

ContextPadProvider.$inject = [
  'contextPad',
  'config',
  'injector',
  'translate',
  'bpmnFactory',
  'elementFactory',
  'create',
  'modeling',
  'connect'
]

ContextPadProvider.prototype.getContextPadEntries = function(element) {
  const {
    autoPlace,
    create,
    elementFactory,
    translate
  } = this

  function appendTask(event, element) {
    if (autoPlace) {
      const shape = elementFactory.createShape({ type: 'bpmn:StartEvent' })
      autoPlace.append(element, shape)
    } else {
      appendTaskStart(event, element)
    }
  }

  function appendTaskStart(event) {
    const shape = elementFactory.createShape({ type: 'bpmn:StartEvent' })
    create.start(event, shape, element)
  }

  return {
    'append.test-start-event': {
      group: 'model',
      className: 'icon-custom test-start-event',
      title: translate('创建一个开始节点'),
      action: {
        click: appendTask,
        dragstart: appendTaskStart
      }
    }
  }
}
```

### 实现效果

![`ContextPad`自定义效果](/blog/images/BPMN工作流简述/1605252668249.jpg)

---

## 自定义连接线和箭头

### 默认效果

![默认效果](/blog/images/BPMN工作流简述/1605254672725.jpg)

### 修改连接线颜色

```scss
.djs-connection {
  path {
    stroke: blue !important;
    marker-end: url(#sequenceflow-arrow-normal) !important;
  }
}
```

![修改连接线颜色](/blog/images/BPMN工作流简述/1605254549761.jpg)

### 自定义箭头

- 绘制箭头需要有一定的`svg`开发能力，因为`Render`中的所有节点都是以`svg`进行呈现的。

- 自定义`svg`需要引入以下两个包。

```ecmascript6
import { append as svgAppend, attr as svgAttr, create as svgCreate } from 'tiny-svg'
import { query as domQuery } from 'min-dom'
```

- 修改装载`xml`时候的方法。

```ecmascript6
bpmnModeler.importXML(xml).then(() => {
  const marker = svgCreate('marker')

  svgAttr(marker, {
    id: '#sequenceflow-arrow-normal',
    viewBox: '0 0 20 20',
    refX: '11',
    refY: '10',
    markerWidth: '10',
    markerHeight: '10',
    orient: 'auto'
  })

  const path = svgCreate('path')

  svgAttr(path, {
    d: 'M 1 5 L 11 10 L 1 15 Z',
    style:
      ' stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; '
  })

  const defs = domQuery('defs')
  svgAppend(marker, path)
  svgAppend(defs, marker)
})
```

### 实现效果

![实现效果](/blog/images/BPMN工作流简述/1605255869265.jpg)
