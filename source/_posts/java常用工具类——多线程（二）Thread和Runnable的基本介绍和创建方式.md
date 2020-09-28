---
title: Java常用工具类——多线程（二）Thread和Runnable的基本介绍和创建方式
date: 2018-01-23 14:15:13
updated: 2018-05-15 11:12:08
comments: true
categories:
- Java
tags:
- Thread
- Runnable
---

本篇文章介绍一下Java的Thread线程对象和Runnable接口实现类

<div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tr><td>构造方法</td><td>说明</td></tr><tr><td>Thread()</td><td>创建一个线程对象</td>
</tr><tr><td>Thread(String name)</td><td>创建一个指定名称的线程对象</td></tr><tr><td>Thread(Runnable target)</td><td>创建一个基于Runnable接口实现类的线程对象</td></tr><tr><td>Thread(Runnable target, String name)</td><td>创建一个基于Runnable接口实现类，并具有指定名称的线程对象</td></tr></table></div>

Thread()构造方法中包含以下四种方法

<div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tr><td>方法</td><td>说明</td></tr><tr><td>public void run()</td><td>线程相关代码写在该方法中（一般需要重写）</td>
</tr><tr><td>public void start()</td><td>启动线程方法</td></tr><tr><td>public static void sleep(long m)</td><td>线程休眠m毫秒的方法</td></tr><tr><td>public void join()</td><td>优先执行调用join()方法的线程</td></tr></table></div>

Runnable则只有一个run()方法，Runnable是Java中用以实现现成的接口，任何实现线程功能的类都必须实现该接口

<br>

（一）通过继承Thread类创建线程，在下面的代码中自定义线程类是占用一个线程，主函数默认占用一个线程，主函数的线程内容会先于自定义线程中的内容执行

例1：简单的创建一个线程类，打印输出字符串，观察线程执行顺序

```java
// 自定义线程类
class MyThread extends Thread{
  public void run() {
    System.out.println(getName() + "  该线程正在运行");
    // 调用Thread的getName()方法是获得线程名称
  }
}
// 通过主函数启动自定义的线程类
public class ThreadTest{
  public static void main (String[] args) {
    System.out.println("这是主线程的第一个输出，用来测试线程执行顺序");
    MyThread mt = new MyThread();
    // 初始化MyThread线程类，定义名称为mt
    mt.start();
    // 启动自定义线程类
    System.out.println("这是主线程的第二个输出，用来测试线程执行顺序");
  }
}
// 输出结果
这是主线程的第一个输出，用来测试线程执行顺序
这是主线程的第二个输出，用来测试线程执行顺序
Thread-0  该线程正在运行
```

例2：创建一个较为复杂的线程类，通过循环打印输出的方式查看两个自定义线程类的运行状态

```java
class MyThread extends Thread{
  public MyThread (String name) {
    super(name);
    // 调用Thread类的方法
  }
  public void run() {
    for (int i = 0; i < 10; i++) {
      System.out.println(getName() + "正在运行" + i + "次");
      // 因为该方法继承于Thread，所以可以直接调用Thread的getName()方法
    }
  }
}
public class ThreadTest{
  public static void main (String[] args) {
    MyThread mt1 = new MyThread("线程1");
    MyThread mt2 = new MyThread("线程2");
    mt1.start();
    mt2.start();
  }
}
// 输出结果（线程1和线程2交替无序的运行，每个线程运行10次）
线程1正在运行0次
线程1正在运行1次
线程2正在运行0次
线程2正在运行1次
线程2正在运行2次
线程2正在运行3次
...

```

<br>

（二）通过实现Runnable接口的方式创建线程（为什么要通过Runnable接口实现创建线程：Java不支持多继承，假设一个方法继承了另一个方法，就不能在继承Thread类了；或者就是不打算重写Thread类的其他方法，一般我们只是使用run()方法，如果不打算重写Thread类的其他方法，只想修改run()方法，我们就可以使用Runnable接口的方式创建线程；Runnable接口中的run()方法支持多线程共享，即可以在多线程处理同一问题的情况下使用）

```java
class PrintRunnable implements Runnable{
  // 实现接口就要去实现它里面的方法，这里就是去实现Runnable接口里面的run()方法
  @Override
  public void run() {
    for (int i = 0; i < 10; i++) {
      System.out.println(Thread.currentThread().getName() + "正在运行，第" + i + "次");
    }
    // 由于getName()方法是Thread类中的方法，我们没有继承Thread，而是通过Runnable接口的方式，所以要通过Thread.currentThread().getName()这个获取线程名称，这句话的意思是：调用Thread类的一个静态方法currentThread()代指当前线程，再去调用getName()方法，即获取当前正在运行的线程的线程名
  }
}
public class ThreadTest{
  public static void main (String[] args) {
    PrintRunnable pr1 = new PrintRunnable();
    // 创建PrintRunnable类对象
    Thread t1 = new Thread(pr1);
    // 创建Thread类的对象，将pr接口当参数存进t的对象中
    t1.start();
    PrintRunnable pr2 = new PrintRunnable();
    Thread t2 = new Thread(pr2);
    t2.start();
  }
}
// 输出结果（两个和两个以上线程运行起来具有随机性，先后顺序无法确定）
Thread-1正在运行，第0次
Thread-0正在运行，第0次
Thread-1正在运行，第1次
Thread-1正在运行，第2次
...
```