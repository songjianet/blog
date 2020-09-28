---
title: MySQL too many connections 解决方法
date: 2018-06-25 19:44:56
updated: 2018-06-25 20:18:53
comments: true
categories:
- Linux
tags:
- MySQL
---

今天在项目中遇到了一个MySQL too many connections的错误，导致项目无法启动，数据库连接工具无法链接。查看了错误之后发现当初在安装完MySQL的时候，忘了更改这些链接配置，下面介绍下怎么去处理这些问题，当然这些设置也可以在成功安装MySQL后就进行配置。

##### 通过输入MySQL的root账号密码进入到MySQL管理

```shell
mysql -u root -p
```

##### 查看当前连接数

可以看到于sleep状态，这些其实是暂时没有用的，所以可以kill id号的方式进行关闭

```shell
show processlist;
```

##### 查看最大连接数

查看当前MySQL配置的最大连接数，当所有连接数综合等于最大连接数时，MySQL就会报出too many connections的错误

```shell
show variables like "max_connections";
```

##### 修改最大连接数

我们可以通过调大MySQL最大连接数的方式进行解决，但是出现too many connections的错误时我们不建议去增大最大的连接数，因为连接数的增加会造成更大的MySQL负担，对数据库的冲击也是比较大的，我们应该根据实际开发需求，设置一个比较合理的最大连接数，同时对sleep状态的连接进行kill

```shell
set GLOBAL max_connections=1000;
```

##### 查看当前MySQL关闭非交互连接的时间

这个数值指的是MySQL在关闭一个非交互的连接之前要等待的秒数，默认是28800s 

```shell
show global variables like 'wait_timeout';
```

##### 修改当前非交互连接关闭的时间

修改这个数值就能更改MySQL关闭一个非交互的连接要等待的秒数，最好控制在几分钟之内

```shell
set global wait_timeout=300;
```

##### <h5 style="color: red;">修改关闭非交互和交互连接的关闭时间</h5>

当我们修改这个时间的时候一定要进行估量，因为这个连接的时间一到，无论是交互的连接或者非交互的连接都会被关闭

```shell
set global interactive_timeout=500;
```