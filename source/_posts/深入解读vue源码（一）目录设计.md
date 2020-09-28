---
title: 深入解读vue源码（一）目录设计
date: 2019-05-14 11:06:20
updated: 2019-05-16 10:50:39
comments: true
categories:
- WEB前端
tags:
- vue
---

#### 基本介绍

此篇文章作为该专题的开篇，将会把<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的目录结构及作用进行简单的介绍，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>项目的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">github</code>地址在<a color="blue" href="https://github.com/vuejs/vue">vue</a>。

我们主要去介绍<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src</code>下面的目录结构，因为<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src</code>是源码的目录。

------

#### src

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">src</code>目录是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的源码目录，该目录下包含：



##### compiler（编译相关）

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">compiler</code>包含<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>所有编译相关的代码。包括将模版解析成<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">ast</code>语法树，以及对语法树的优化，代码自动生成等。

编译工作可以借助<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">webpack</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue-loader</code>等工具。

codegen —— 用ast去生成render函数

directives —— 生成render函数之前需要处理的指令

parser —— 模板解析



##### core（核心业务代码）

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">core</code>目录包含<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>的核心代码，如内置组件、API、实例化、虚拟DOM、工具类函数等。

components —— 全局的组件，这里只有keep-alive

global-api —— 全局方法，也就是添加在Vue对象上的方法，比如Vue.use、Vue.extend、Vue.mixin等

instance —— 实例方法、生命周期、事件等

observer —— 双向数据绑定

util —— 工具

vdom —— 虚拟化DOM



##### platforms（终端支持）

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>是一个<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mvvm</code>框架，能够运行在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">web</code>上，也可以配合<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">weex</code>运行在客户端上。

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">platforms</code>是<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>程序的入口，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">platforms</code>具有两个入口，分别运行在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">web</code>上和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">weex</code>上。

compiler —— 编译阶段需要处理的指令和模块

runtime —— 运行阶段需要处理的指令和模块

server —— 服务端渲染

util —— 工具



##### server（服务端渲染）

从2.0版本开始，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>支持服务端的渲染方式，<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">server</code>目录下包含所有与服务端渲染相关的逻辑。

注：

- 这部分代码是运行在<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node</code>上的代码，不要和运行在浏览器的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>混淆
- 服务端渲染是指服务器把组件以<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">html</code>字符串的形式发送到客户端



##### sfc（对vue文件的支持与解析）

通常我们开发项目都是通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">webpack</code>进行打包处理，通过编写<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>文件实现功能。<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">sfc</code>目录下的代码能够去把<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>文件解析成<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">JavaScript</code>对象。



##### shared（共享代码）

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>会定义一些方法，这些方法是会被客户端和服务端所共享的。

------

#### dist

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>项目打包后的文件存储区。

------

#### benchmarks

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">benchmarks</code>的目的主要有两种，一是验证性能，另一个是获得一些基准数据，从而可以与本软件的其他版本或其他同类软件进行比较，通常不使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">benchmarks</code>做正确性验证。

------

#### flow

静态类型检查工具，此目录会规定一些参数和方法的类型。

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>本身使用了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">flow</code>来进行静态类型检查。

------

#### examples

存放一些使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vue</code>开发的应用案例。

------

#### packages

生成其他<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">npm</code>包。

------

#### test

测试用例。

------

#### scripts

<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Rollup</code>构建时相关的配置文件。