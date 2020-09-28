---
title: Java常用工具类——输入输出流（二）File类介绍和常用方法
date: 2018-02-22 9:29:13
updated: 2018-05-15 11:15:59
comments: true
categories:
- Java
tags:
- 输入输出流
- File类
---

作为2018年的第一篇文章（阴历），将继续为大家写一些关于计算机各个方面的文档，大家可以查看，也可以将问题、意见等通过Email的方式发送给我，我的Email为1778651752@qq.com。

本篇文章介绍一下Java输出输出的File类。File——文件，文件可认为是相关记录或放在一起的数据集合；在Java中，使用java.io.File类对文件进行操作

例：

```java
import java.io.File;
public class FileDemo {
  public static void main (String[] args) {
    // 创建File对象，方法一
    File file1 = new File("c:\\filestudy\\study.txt"); // Window系统路径的写法
    // File file1 = new File("/home/study.txt"); Linux系统的写法
    // 创建File对象，方法二
    // File file1 = new File("c:\\filestudy", "study.txt");
    // 创建File对象，方法三
    // File file = new File("c:\\filestudy");
    // File file1 = new File(file, "study.txt");
    
    // 判断是文件还是目录
    System.out.println("是否是目录：" + file1.isDirectory());
    System.out.println("是否是文件：" + file1.isFile());
    
    // 创建单级目录
    File file2 = new File("c:\\filestudy", "hashset");
    // 判断是否filestudy下是否有hashset目录
    if(!file2.exists()){
      file2.mkdir();
    }
    // 创建多级目录
    File file2 = new File("c:\\filestudy\\set\\hashset");
    // 判断是否filestudy下是否有hashset目录
    if(!file2.exists()){
      file2.mkdirs();
    }
    
    // 创建文件
    File file3 = new File("c:\\filestudy\\newStudy.txt");
    if(file3.exists()){
      try{
        file3.createNewFile();
      }catch(IOException e){
        e.printStackTrace();
      } 
    }
  }
}
```