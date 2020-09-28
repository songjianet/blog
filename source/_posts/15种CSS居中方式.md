---
title: 15种CSS居中方式
date: 2018-04-12 10:15:55
updated: 2018-05-15 10:59:55
comments: true
categories:
- WEB前端
tags:
- CSS
---

最近由于公司的业务过于繁忙，一段时间前总结的一篇关于CSS居中的文档一直没有上传到服务器，今天对此文档稍作修改，并且部署服务器，以供大家查看。

很多人会觉得一个居中的方式，很简单啊，行内元素就用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">text-align: center</code>，块级元素就用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">margin: 0 auto;</code>。其实不然，单单是这两个样式就能演变出很多种的居中方式。为此，我总结出十五种的居中方式供大家参考，如果有没有想到的，大家可以留言我的邮箱：1778651752@qq.com。

##### 1.内联元素水平居中

利用 <code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">text-align: center </code>可以实现在块级元素内部的内联元素水平居中。此方法对内联元素(inline)，内联块(inline-block)，内联表(inline-table)，(inline-flex)元素水平居中都有效。

```css
.center-text {
    text-align: center;
}
```

##### 2.块级元素水平居中

通过把固定宽度块级元素的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">margin-left</code>和<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">margin-right</code>设成<code style="letter-spacing:2px;font-weight:700;background-color:#e6effb;border-radius:3px;">auto</code>，就可以使块级元素水平居中。

```css
.center-block {
    margin: 0 auto;
}
```

##### 3.多级块元素水平居中

如果一行中有两个或两个以上的块级元素，通过设置块级元素的显示类型为<code style="letter-spacing:2px;font-weight:700;background-color:#e6effb;border-radius:3px;">inline-block</code>和父容器的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">text-align</code>属性从而使多块级元素水平居中。

```css
.container {
    text-align: center;
}
.inline-block {
    display: inline-block;
}
```

##### 4.利用display: flex

利用弹性布局(flex)，实现水平居中，其中<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">justify-content</code>用于设置弹性盒子元素在主轴（横轴）方向上的对齐方式，本例中设置子元素水平居中显示。

```css
.flex-center {
    display: flex;
    justify-content: center;
}
```

##### 5.单行内联元素垂直居中

通过设置内联元素的高度<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">height</code>和行高<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">line-height</code>相等，从而使元素垂直居中。

```css
.v-box {
    height: 120px;
    line-height: 120px;
}
```

##### 6.利用表格布局的多行元素垂直居中

利用表布局的<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">vertical-align: middle</code>可以实现子元素的垂直居中。

```css
.center-table {
    display: table;
}
.v-cell {
    display: table-cell;
    vertical-align: middle;
}
```

##### 7.利用flex布局的多行元素垂直居中

利用 flex 布局实现垂直居中，其中<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">flex-direction: column</code>定义主轴方向为纵向。因为 flex 布局是 CSS3 中定义，在较老的浏览器存在兼容性问题。

```css
.center-flex {
    display: flex;
    flex-direction: column;
    justify-content: center;
}
```

##### 8.利用“精灵元素”

利用“精灵元素”(ghost element)技术实现垂直居中，即在父容器内放一个 100%高度的伪元素，让文本和伪元素垂直对齐，从而达到垂直居中的目的。

```css
.ghost-center {
    position: relative;
}
.ghost-center::before {
    content: " ";
    display: inline-block;
    height: 100%;
    width: 1%;
    vertical-align: middle;
}
.ghost-center p {
    display: inline-block;
    vertical-align: middle;
    width: 20rem;
}
```

##### 9.固定高度的块级元素垂直居中

我们知道居中元素的高度和宽度，垂直居中问题就很简单。通过绝对定位元素距离顶部 50%，并设置<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">margin-top</code>向上偏移元素高度的一半，就可以实现垂直居中了。

```css
.parent {
  position: relative;
}
.child {
  position: absolute;
  top: 50%;
  height: 100px;
  margin-top: -50px; 
}
```

##### 10.未知高度的块元素垂直居中

当垂直居中的元素的高度和宽度未知时，我们可以借助 CSS3 中的<code style="letter-spacing:2px;font-weight:700;background-color:#e6effb;border-radius:3px;">transform</code>属性向 Y 轴反向偏移 50%的方法实现垂直居中。但是部分浏览器存在兼容性的问题。

```css
.parent {
    position: relative;
}
.child {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
}
```

##### 11.固定宽高元素水平垂直居中

通过<code style="letter-spacing:2px;font-weight:700;background-color:#e6effb;border-radius:3px;">margin</code>平移元素整体宽度的一半，使元素水平垂直居中。

```css
.parent {
    position: relative;
}
.child {
    width: 300px;
    height: 100px;
    padding: 20px;
    position: absolute;
    top: 50%;
    left: 50%;
    margin: -70px 0 0 -170px;
}
```

##### 12.未知宽高元素水平垂直居中

利用 2D 变换，在水平和垂直两个方向都向反向平移宽高的一半，从而使元素水平垂直居中。

```css
.parent {
    position: relative;
}
.child {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
```

##### 13.利用flex布局水平垂直居中

利用 flex 布局，其中<code style="letter-spacing:2px;font-weight:700;background-color:#e6effb;border-radius:3px;">justify-content</code>用于设置或检索弹性盒子元素在主轴（横轴）方向上的对齐方式；而<code style="letter-spacing:2px;font-weight:700;background-color:#e6effb;border-radius:3px;">align-items</code>属性定义 flex 子项在 flex 容器的当前行的侧轴（纵轴）方向上的对齐方式。

```css
.parent {
    display: flex;
    justify-content: center;
    align-items: center;
}
```

##### 14.利用grid布局水平垂直居中

利用 grid 实现水平垂直居中，兼容性较差，不推荐。

```css
.parent {
  height: 140px;
  display: grid;
}
.child { 
  margin: auto;
}
```

##### 15.屏幕上水平垂直居中

屏幕上水平垂直居中十分常用，常规的登录及注册页面都需要用到。要保证较好的兼容性，还需要用到表布局。

```css
.outer {
    display: table;
    position: absolute;
    height: 100%;
    width: 100%;
}
.middle {
    display: table-cell;
    vertical-align: middle;
}
.inner {
    margin-left: auto;
    margin-right: auto; 
    width: 400px;
}
```