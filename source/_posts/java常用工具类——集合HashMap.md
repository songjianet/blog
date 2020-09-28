---
title: Java常用工具类——集合（三）HashMap
date: 2018-01-23 08:59:13
updated: 2018-05-15 11:14:32
comments: true
categories:
- Java
tags:
- Java常用工具类
- Map
- HashMap
- Iterator
- Set
- entrySet
---

本篇文章介绍一下Java常用工具类中的HashMap，HashMap是基于哈希表的Map接口的一个实现类，它是以键值对的方式存储的（无序存储），并且允许拥有一对空的键值且key值不允许重复。

1. 导入Map和HashMap需要的包

   ```java
   import java.util.HashMap;
   import java.util.Map;
   ```

2. 对HashMap进行初始化

   ```java
   Map<String, String> map = new HashMap<String, String>();
   // HashMap泛型指定键值对数据类型
   ```

3. map添加数据

   ```java
   map.put(key, value); 
   // 这里为要填入的键值对数据，通过put方法添加到名为map的HashMap列表中
   ```

4. 打印输出map中的值，使用迭代器打印输出，首先导入Iterator包

   ```java
   import java.util.Iterator;
   ```

5. 通过迭代器输出HashMap中的value

   ```java
   Iterator<String> it = map.values().iterator(); // 获取map中所有的value存到it中
   while(it.hasNext()){
     Systemctl.out.print(" " + it.next() + " ");
   }
   ```

6. 通过entrySet方法获得HashMap中的key、value

   ```java
   // 导入Set需要的包
   import java.util.Set;
   // 将HashMap通过entrySet方法赋值给set，Set类型是Entry类型，Entry类型是HashMap的String数据类型
   Set<Entry<String, String>> set = map.entrySet();
   // 通过增强型for循环遍历输出
   for(Entry<String, String> entry:entrySet){
     Systemctl.out.print(entry.getKey()); 
     // 通过增强型for循环对Entry类型的重命名（entry）获取到key值
     Systemctl.out.print(entry.getValue());
   }
   ```

7. 本文讲解的是HashMap的常用方法，如果想了解其他方法可以查阅官网的文档