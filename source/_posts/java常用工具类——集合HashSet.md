---
title: Java常用工具类——集合（二）HashSet
date: 2018-01-22 10:33:13
updated: 2018-05-15 11:14:59
comments: true
categories:
- Java
tags:
- Java常用工具类
- Set
- HashSet
- Iterator
---

本篇文章介绍一下Java常用工具类中的HashSet：HashSet是Set的一个重要实现类，称为哈希集；HashSet是无序的不允许有重复数据的集合；HashSet中只允许有一个null元素（因为HashSet是不允许有重复数据的，所以HashSet只能有一个空元素）；HashSet具有良好的存取和查找性能。

1. 导入Set和HashSet需要的包

   ```java
   import java.util.HashSet;
   import java.util.Set;
   ```

2. 首先要想使用HashSet需要在主函数（或者函数）中对HashSet进行初始化，其中Set为自己定义的HashSet名，在下面对该HashSet进行操作的时候都是以Set的名字代指这个HashSet的数组

   ```java
   Set set = new HashSet();
   ```

3. 对HashSet进行添加数据操作，不同于ArrayList的是HashSet是无序存储，所以没有办法指定在某个元素和某个元素的下一个元素中间插入一个元素

   ```java
   set.add("java");
   set.add("c++");
   set.add("go");
   ```

4. 迭代器Iterator，是HashSet进行遍历输出的一个接口，在使用Iterator前，要进行包的导入。其中Iterator下有两个方法，一个是hasNext()作用于判断当前元素是否还有下一个元素，一个是next()作用于返回当前元素的下一个元素

   ```java
   import java.util.Iterator;
   ```

5. 初始化迭代器

   ```java
   Iterator it = set.iterator();
   ```

6. 通过迭代器遍历输出HashSet中的值

   ```java
   while(it.hasNext()){
     Systemctl.out.print(" " + it.next() + " "); // 空格是在区分没个元素，给每个元素增加间距
   }
   ```

7. 删除HashSet中的一个元素（由于HashSet是无序组合，所以只能通过remove对象的方式进行删除，无法通过下标方式删除）

   ```java
   set.remove("java");
   ```

8. 如果要add一个相同元素，编译器并不会报错，依然能够运行，但是重复的元素不会被插入到HashSet中

9. 本文讲解的是HashSet的常用方法，如果想了解其他方法可以查阅官网的文档