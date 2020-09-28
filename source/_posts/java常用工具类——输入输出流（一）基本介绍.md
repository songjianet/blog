---
title: Java常用工具类——输入输出流（一）基本介绍
date: 2018-01-26 10:10:13
updated: 2018-05-15 11:16:32
comments: true
categories:
- Java
tags:
- 输入输出流
---

本篇文章介绍一下Java输入输出流，我们可以通过以下两张图看出输出输入流的基本流程方式。

<br>

<h4 style="color: rgb(42,111,160);">1.Java流的分类</h4>

> 按流向分:
>
> 输入流: 程序可以从中读取数据的流。
> 输出流: 程序能向其中写入数据的流。
>
> 按数据传输单位分:
>
> 字节流: 以字节为单位传输数据的流
> 字符流: 以字符为单位传输数据的流
>
> 按功能分:
>
> 节点流: 用于直接操作目标设备的流
> 过滤流: 是对一个已存在的流的链接和封装，通过对数据进行处理为程序提供功能强大、灵活的读写功能。
>

<br>

<h4 style="color: rgb(42,111,160);">2.什么是I/O</h4>

> ​	Java中I/O操作主要是指使用Java进行输入，输出操作. Java所有的I/O机制都是基于数据流进行输入输出，这些数据流表示了字符或者字节数据的流动序列。Java的I/O流提供了读写数据的标准方法。任何Java中表示数据源的对象都会提供以数据流的方式读写它的数据的方法。  
>
> ​	Java.io是大多数面向数据流的输入/输出类的主要软件包。此外，Java也对块传输提供支持，在核心库 java.nio中采用的便是块IO。
>
> 　　流IO的好处是简单易用，缺点是效率较低。块IO效率很高，但编程比较复杂。 
>  	Java IO模型  :
> ​        Java的IO模型设计非常优秀，它使用Decorator模式，按功能划分Stream，您可以动态装配这些Stream，以便获得您需要的功能。例如，您需要一个具有缓冲的文件输入流，则应当组合使用FileInputStream和BufferedInputStream。
>

<br>

![输出流](1516931978.jpg)

<br>

![输入流](1516932106.jpg)

<br>

<h4 style="color: rgb(42,111,160);">3.如何选择IO流模式</h4>

1）确定数据源和数据目标位置（输入和输出）

源 / 输入：InputStream   Reader

目标位置 / 输出： OutputStream   Writer

2）明确操作对象是否是纯文本（判断字符字节流）

是 / 字符流：Reader   Writer

否 / 字节流：InputStream   OutputStream

3）明确设备

<div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tbody><tr><td></td><td>数据源 / 输入</td><td>目标位置 / 输出</td></tr><tr><td>键盘</td><td>System.in</td><td>System.out</td></tr><tr><td>硬盘</td><td>File</td><td>File</td></tr><tr><td>网络</td><td>socket.getInputStream()</td><td>socket.getOutputStream()</td></tr><tr><td>内存</td><td>byte型数组：ByteArrayInputStream<br>char型数组：CharArrayReader</td><td>byte型数组：ByteArrayOutputStream<br>char型数组：CharArrayWriter</td></tr></tbody></table></div>

4）是否需要转换流

是，就使用转换流，从Stream转化为Reader，Writer：InputStreamReader，OutputStreamWriter 

5）是否需要缓冲提高效率

是就加上Buffered：BufferedInputStream, BufferedOuputStream, BuffereaReader, BufferedWriter

<br>

<h4 style="color: rgb(42,111,160);">4.IOException异常的子类</h4>

针对IOException的异常又三个子类，分别是

1）EOFException： 非正常到达文件尾或输入流尾时，抛出的异常

2）FileNotFoundException： 当文件找不到时，抛出的异常

3）InterruptedIOException：当I/O操作被中断时，抛出的异常