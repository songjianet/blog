---
title: 详解flex布局
date: 2018-07-10 16:03:59
updated: 2018-07-25 18:33:30
comments: true
categories:
- WEB前端
tags:
- css
- flex
---

#### 一. flex介绍

flex简单来说就是”弹性布局“，用来为盒状模型提供最大的灵活性，任何一个容器都可以指定为一个flex容器。

flex可以以简便、完整、相应式地实现各种页面布局。目前，它已经得到了所有浏览器的支持，这意味着，现在就能很安全的使用这个功能。

关于布局传统的解决方案是基于盒状模型的，依赖display+position+float。它对于那些特殊布局非常不方便。比如，垂直居中就不容易实现。

![8712d713c7d0b884a5cb9770efc422b4](/blog/详解flex布局/8712d713c7d0b884a5cb9770efc422b4.jpg)



#### 二. 基本概念

采用flex布局的元素我们称之为flex容器（flex container），简称“容器”。他的所有的子元素都是容器的成员（flex item），简称“项目”。

容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做main start，结束位置叫做main end；交叉轴的开始位置叫做cross start，结束位置叫做cross end。

项目默认沿主轴排列。单个项目占据的主轴空间叫做main size，占据的交叉轴空间叫做cross size。

![3791e575c48b3698be6a94ae1dbff79d](/blog/详解flex布局/3791e575c48b3698be6a94ae1dbff79d.png)



#### 三. 如何声明flex布局

任何一个容器都可以指定为flex布局

```css
.box {
	display: flex;
}
```

行内元素使用flex布局

```css
.box {
	display: inline-flex;
}
```

webkit内核的浏览器，必须加上-webkit-前缀

```css
.box {
	display: -webkit-flex; /* Safari */
	display: flex;
}
```

<p style="color: red;">注意：一旦使用flex布局后，子元素的float、clear和vertical-align属性将失效。</p>



#### 四. 容器的六种属性

- flex-direction
- flex-wrap
- flex-flow
- justify-content
- align-items
- align-content

##### 4.1 flex-direction属性

flex-derection属性决定主轴的方向（即项目的排列方向）。

```css
.box {
	flex-direction: row | row-reverse | column | column-reverse;
}
/*
	row：（默认值）主轴为水平方向，起点在左端。
	row-reverse：主轴为水平方向，起点在右端。
	column：主轴为垂直方向，起点在上端。
	column-reverse：主轴为垂直方向，起点在下端
*/
```

##### 4.2 flex-wrap属性

默认情况下，项目都会排列在一条线上。flex-wrap属性，允许我们进行项目的换行操作。

```css
.box {
	flex-wrap: nowrap | wrap | wrap-reverse;
}
/*
	nowrap：（默认值）不换行。
	wrap：换行，第一行在上方。
	wrap-reverse：换行，第一行在下方。
*/
```

##### 4.3 flex-flow属性

flex-flow属性是flex-direction属性和flex-wrap属性的简写形式，默认值为row nowrap。

```css
.box {
	flex-flow: <flex-direction> <flex-wrap>;
}
/*
	flex-direction：flex-direction可以选择的值。
	flex-wrap：flex-wrap可以选择的值。
*/
```

##### 4.4 justify-content属性

justify-content属性定义了容器中项目在主轴上的对齐方式。

```css
.box {
	justify-content: flex-start | flex-end | center | space-between | space-around;
}
/*
	flex-start：（默认值）左对齐。
	flex-end：右对齐。
	center：居中。
	space-between：两端对齐，项目之间的间隔都相等。
	space-around：每个项目两侧的间隔相等。所以，项目之间的间隔比项目与边框的间隔大一倍。
*/
```

##### 4.5 align-items属性

align-items属性定义项目在交叉轴上如何对齐。

```css
.box {
	align-items: flex-start | flex-end | center | baseline | stretch;
}
/*
	flex-start：交叉轴的起点对齐。
	flex-end：交叉轴的终点对齐。
	center：交叉轴的中点对齐。
	baseline：项目的第一行文字的基线对齐。
	stretch：（默认值）如果项目没有设置高度或者设为auto，将占满整个容器的高度。
*/
```

##### 4.6 align-content属性

align-content属性定义了多根轴线的对齐方式。<p style="color:red">注意：如果项目只有一根轴线，该属性不起作用。</p>

```css
.box {
	align-content: flex-start | flex-end | center | space-between | space-around | stretch;
}
/*
	flex-start：与交叉轴的起点对齐。
	flex-end：与交叉轴的终点对齐。
	center：与交叉轴的中点对齐。
	space-between：与交叉轴两端对齐，轴线之间的间隔平均分布。
	space-around：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。
	stretch：（默认值）轴线占满整个交叉轴。
*/
```



#### 五. 项目的六种属性

- order
- flex-grow
- flex-shrink
- flex-basis
- flex
- align-self

##### 5.1 order属性

order属性定义项目的排列顺序。数值越小，排列越靠前，默认为0。

```css
.item {
	order: <integer>;
}
/*
	integer：（默认值为0）可填任意整数。
*/
```

##### 5.2 flex-grow属性

flex-grow属性定义项目的放大比例，默认为0，即如果存在剩余空间也不进行放大。

<p style="color:red">当属性值都为1时，等分剩余空间。</p>

```css
.item {
	flex-grow: <number>; /* default 0 */
}
```

##### 5.3 flex-shrink属性

flex-shrink属性定义了项目的缩小比例，默认为1，即如果空间不足，将项目进行缩小。

<p style="color:red">值为负数，属性无效。当一个项目属性值为0其它项目属性值都为1时，为0的项目在空间不足的时候也不会被缩放。</p>

```css
.item {
	flex-shrink: <number>; /* default 1 */
}
```

##### 5.4 flex-basis属性

flex-basis属性定义了再分配多于空间之前，项目占据的主轴空间。浏览器根据这个属性计算主轴是否有多余空间。他的默认值为auto，即项目本来的大小。

它可以设为跟width或height属性一样的值（比如350px），则项目占据固定空间。

```css
.item {
	flex-basis: <length> | auto; /* default auto */
}
```

##### 5.5 flex属性

flex熟悉是flex-grow, flex-shrink 和 flex-basis的简写，默认值为0 1 auto。后两个属性可选。 

该属性有两个快捷值：auto (1 1 auto) 和 none (0 0 auto)。

建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。

```css
.item {
	flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
}
```

##### 5.6 align-self属性

align-self属性允许单个项目有与其他项目不一样的对齐方式，可覆盖align-items属性。默认值为auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch。 

```css
.item {
	align-self: auto | flex-start | flex-end | center | baseline | stretch;
}
```



#### 六. 总结

本篇文章基本的介绍了下flex布局，总的来说flex布局已经是主流的布局方式，后续我会写一些关于flex布局的实例供大家参考，也希望大家将博客的问题通过留言的方式告诉我，我会陆续进行修改。
