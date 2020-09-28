---
title: Java常用工具类——多线程（三）线程相关
date: 2018-01-23 15:52:13
updated: 2018-05-15 11:12:56
comments: true
categories:
- Java
tags:
- 线程
- 线程的状态和生命周期
- sleep方法
- join方法
- 线程的优先级
- 线程同步
---

本篇文章介绍一下Java多线程的其他概念和相关的操作方式

<br>

（一）多线程分为五个状态：新建、可运行（就绪状态）、正在运行、阻塞、终止

<br>

（二）所谓线程的生命周期就是线程的五个状态的相互转换的过程。终止线程的stop()方法在新的jdk中已经不推荐使用了

![线程生命周期图](/blog/images/java常用工具类——多线程（三）线程相关/xiancheng.png)

<br>

（三）sleep()方法是Thread类中的一个方法，通过以下方式调用，作用是在制定毫秒内让正在执行的线程休眠（暂停执行）

```java
public static void sleep(long millis);
```

例：

```java
class MyThread implements Runnable {
  // 实现接口就要去实现它里面的方法，这里就是去实现Runnable接口里面的run()方法
  @Override
  public void run() {
    for (int i = 0; i < 15; i++) {
      System.out.println(Thread.currentThread().getName() + "执行第" + i + "次");
      try {
        Thread.sleep(1000);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
      // 防止在休眠期间线程中断
    }
    // 由于getName()方法是Thread类中的方法，我们没有继承Thread，而是通过Runnable接口的方式，所以要通过Thread.currentThread().getName()这个获取线程名称，这句话的意思是：调用Thread类的一个静态方法currentThread()代指当前线程，再去调用getName()方法，即获取当前正在运行的线程的线程名
  }
}
public class SleepDemo {
  public static void main (String[] args) {
    MyThread mt = new MyThread();
    Thread t = new Thread(mt);
    t.start();
  }
}
```

<br>

（四）join()方法也是Thread类的一个方法，通过以下方式进行调用，作用是等待调用该方法的线程结束后才能执行（调用该方法的线程优先执行，执行后其它没有调用该方法的线程才会执行），join()方法是一种抢占资源的方式

```java
public final void join();
public final void join(long millis); 
// 等待该线程终止的最长时间为millis毫秒，例：a线程调用join(1000)，表示不管a线程是否执行完，只要执行到1000毫秒就去实行其它线程，即millis毫秒后交出a线程的使用权，之后的线程执行顺序变无序
```

例：

```java
class MyThread extends Thread{
  public void run() {
    for (int i = 0; i < 10; i++) {
      System.out.println(getName() + "正在运行" + i + "次");
      // 因为该方法继承于Thread，所以可以直接调用Thread的getName()方法
    }
  }
}
public class JoinDemo{
  public static void main (String[] args) {
    MyThread mt = new MyThread();
    mt.start();
    try {
        mt.join();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    for (int i = 0; i < 10; i++) {
      System.out.println("主线程正在运行" + i + "次");
    }
    System.out.println("主线程运行结束了");
  }
}
// 输出结果，调用join()方法的线程优先执行
Thread-0正在运行0次
Thread-0正在运行1次
...
Thread-0正在运行9次
主线程正在运行0次
主线程正在运行1次
...
主线程正在运行9次
```

<br>

（五）线程优先级

1.Java为线程类提供10个优先级等级

2.优先级可以用1-10的正数表示，超出范围内的数字会抛出IllegalArgumentException异常

3.主线程默认优先级是5

4.数字越大表示的优先级越高

5.优先级常量

 <div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tr><td>线程优先级常量</td><td>说明</td></tr><tr><td>MIN_PRIORITY = 1</td><td>线程的最低优先级1</td>
 </tr><tr><td>NORM_PRIORITY = 5</td><td>线程的默认优先级5</td></tr><tr><td>MAX_PRIORITY = 10</td><td>线程的最高优先级10</td></tr></table></div>

6.线程优先级的相关方法

 <div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tr><td>线程优先级的方法</td><td>说明</td></tr><tr><td>public int getPriority()</td><td>获取线程优先级的方法</td></tr><tr><td>public void setPriority(int newPriority)</td><td>设置线程优先级的方法</td></tr></table></div>

7.例：

```java
class MyThread extends Thread {
  private String name;
  public Mythread (String name) {
    this.name = name;
  }
  // 构造方法为线程名赋值
  public void run () {
    for (int i = 0; i < 10; i++) {
      System.out.println(name + "正在运行第" + i + "次");
    }
  }
}
public class PriorityDemo {
  public static void main (String[] args) {
    int mainPriority = Thread.currentThread().getPriority();
    // 获取主线程优先级，使用Thread.currentThread().getPriority()是因为，主线程是当前正在运行的线程
    System.out.println("主线程的优先级为：" + mainPriority);
    MyThread mt = new MyThread("线程1");
    // 给自定义线程起名，赋给mt对象
    mt.setPriority(10);
    // 等价于mt.setPriority(Thread.MAX_PRIORITY);
    // 设置自定义线程为最高优先级
    mt.start();
    System.out.println("线程1的优先级为：" + mt.getPriority());
  }
}
// 输出结果，根据操作系统和系统环境的不同，不能保证高优先级的线程一定优先执行
主线程的优先级为：5
线程1正在运行第0次
线程1正在运行第1次
...
线程1正在运行第9次
线程1的优先级为：10

/**
 * 修改主方法，MyThread方法不动，增加一个自定义线程 */
public class PriorityDemo {
  public static void main (String[] args) {
    MyThread mt1 = new MyThread("线程1");
    MyThread mt2 = new MyThread("线程2");
    mt1.setPriority(10);
    mt2.setPriority(1);
    mt1.start();
    mt2.start();
  }
}
// 输出结果虽然两个线程优先级不一样，但是依然存在乱序的可能性
```

<br>

（六）线程同步

谈到线程同步，不得不说我们在之前的学习中遇到的问题

1.各个线程是通过竞争cpu的时间而获得运行机会的

2.各线程什么时候得到cpu的时间、占用多久是不可预测的

3.一个正在运行的进程在什么地方被暂停是不确定的

为保证一个线程能够从头到尾执行完毕，我们要对这个线程进行锁定，使用关键字synchronized实现，synchronized关键字可以用在成员方法、静态方法、语句块中，例如银行的一个账户存取款的问题
