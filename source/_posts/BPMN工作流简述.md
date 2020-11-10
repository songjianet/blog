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

> q: `bpmn.js`是什么？
>
> a: `bpmn.js`是一个遵循`BPMN2.0`规范的渲染工具包和`web`建模工具，使得流程的绘制能在前端的页面完成。

---

## 基础概念

- `palette`: 指代左侧工具栏。

- `render`: 承载绘制流程的画布容器。

- `shape`: 左侧工具栏中的每一个节点。

- `connection`: 连接线节点。

- `context-pad`: 节点拖拽到`render`中后，点击节点右侧出现的菜单。

- `properties-panel`: 节点属性的配置栏。

![基础概念图](/blog/images/BPMN工作流简述/1604987259267.jpg)

