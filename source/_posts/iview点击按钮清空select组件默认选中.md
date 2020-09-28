---
title: iview点击按钮清空select组件默认选中
date: 2018-08-28 15:41:24
updated: 2018-08-28 15:41:24
comments: true
categories:
- WEB前端
tags:
- vue
- iview
---

最近的项目使用的是八月份更新的iview3的ui组件框架。使用了一段时间，如何去评价这个框架呢，只能说是组件比较多，源码比较渣，文档介绍不全。不过现在项目已经用上了，不能重新编写，只能硬着头皮继续了。

今天这个问题也是让我很头疼，就是如何在点击重置按钮时候对select组件进行选中项的清空操作。

##### 1. 查看文档的api介绍

	官网的示例中并没有介绍清空select的操作，我们可以在文档中查看到这两个参数项。要想做到清空操作就要把两个参数同时使用上。

![1535442437](/blog/images/iview点击按钮清空select组件默认选中/1535442437.jpg)

<br><br>

![1535442402](/blog/images/iview点击按钮清空select组件默认选中/1535442402.jpg)

##### 2. 代码

```vue
<template>
	<Select v-model="selectCouponStatus" placeholder="可用优惠券" clearable ref="oselect" style="width:200px">
        <Option v-for="item in couponStatus" :value="item.couponStatus" :key="item.couponStatus"></Option>
	</Select>
	<Button type="warning" icon="ios-calendar-outline" @click="emptyCouponList" on-clear>重置</Button>
</template>
<script>
    export default {
        emptyCouponList () {
            this.$refs.oselect.clearSingleSelect()
        }
    }
</script>
```
