---
title: Java常用工具类——集合（一）ArrayList
date: 2018-01-22 10:33:13
updated: 2018-05-15 11:13:52
comments: true
categories:
- Java
tags:
- Java常用工具类
- List
- ArrayList
---

本篇文章介绍一下Java常用工具类中的ArrayList，ArrayList是有序的允许有重复数据的集合。ArrayList底层是由数组构成的，所以支持有序的排列方式。ArrayList和数组的区别在于，ArrayList是支持动态增长的

1. 导入List和ArrayList需要的包

   ```java
   import java.util.ArrayList;
   import java.util.List;
   ```

2. 首先要想使用ArrayList需要在主函数（或者函数）中对ArrayList进行初始化，其中list为自己定义的ArrayList名，在下面对该ArrayList进行操作的时候都是以list的名字代指这个ArrayList的数组

   ```java
   List list = new ArrayList();
   ```

3. 对ArrayList进行添加数据操作

   ```java
   list.add("java"); // 当add方法只有一个参数时，表示在ArrayList末尾添加内容
   list.add("c++");
   list.add("go");
   list.add(1, "c"); // 当add方法有两个参数的时候，表示在指定位置插入，这样写表示在java和c++中间插入一个c
   ```

4. 修改ArrayList中最后一个元素go的值

   ```java
   list.set(3, "今年最火语言是go语言");
   ```

5. 获得ArrayList中的元素个数

   ```java
   list.size();
   ```

6. 移除列表中的元素（可以通过删除下标的方式，也可以通过删除对象的方式）

   ```java
   list.remove(0); // 通过删除下标的方式删除元素
   list.remove("java"); // 通过删除对象的方式删除元素
   ```

7. 删除ArrayList中的所有值

   ```java
   list.clear();
   ```

8. 查看ArrayList某一个位置的元素内容（通过get方法的下标方式进行查看）

   ```java
   list.get(0);
   ```

9. 对ArrayList的数据进行遍历输出（一般提到数组的遍历输出，List的遍历输出我们一般都是通过for循环的方式，循环数组或者List的长度进行输出）

   ```java
   for(int i = 0; i < list.size(); i++){
     Systemctl.out.println(list.get(i));
   }
   ```

10. 对于ArrayList中的其他方法可以参阅java官方文档，本文列举的是ArrayList的出现率最高的几个方法。