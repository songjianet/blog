---
title: CentOS7定时清理buff/cache内存占用过高
date: 2018-03-20 9:47:13
updated: 2018-05-15 11:07:25
comments: true
categories:
- Linux
tags:
- crontab
- buff/cache
---

最近因为公司事物过多，没有时间去更新博客，今天在查看自己博客的时候发现，应该对之前的一片文章<a href="http://120.79.151.66:4000/2018/02/06/buffcache%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E8%BF%87%E9%AB%98/">buff / cache内存占用过高</a>进行更深度的讲解，以及通过定时任务，解放人为清理的麻烦。

首先，在linux系统中想到自动化处理任务，无疑就是crontab，crontab就是linux系统中的自动化处理的程序，在默认的情况下，系统是自带crontab程序的，只是处于关闭状态，但是本篇文章依旧为大家提供crontab的安装方式。

1.安装crontab

```shell
# yum install vixie-cron
# yum install crontabs
```

2.查看crond.service的服务自启动状态

```shell
# systemctl is-enabled crond.service
disabled
```

3.使crond.service的服务在开机时自启动

```shell
# systemctl enable crond.service
```

4.再次查看crond.service的服务自启动状态

```shell
# systemctl is-enabled crond.service
enabled
```

5.其他关于crond.service操作的基本命令

```shell
# systemctl start crond.service // 启动
# systemctl stop crond.service // 关闭
# systemctl restart crond.service // 重启
# systemctl reload crond.service // 重新载入配置
```

6.crontab文件格式

![查看crontab规则](/images/CentOS7定时清理buffcache内存占用过高/查看crontab规则.png)

7.crontab的特殊字符

> 星号（*）：代表所有可能的值，例如month字段如果是星号，则表示在满足其它字段的制约条件后每月都执行该命令操作。
>
> 逗号（,）：可以用逗号隔开的值指定一个列表范围，例如，“1,2,5,7,8,9”。
>
> 中杠（-）：可以用整数之间的中杠表示一个整数范围，例如“2-6”表示“2,3,4,5,6”。
>
> 正斜线（/）：可以用正斜线指定时间的间隔频率，例如“0-23/2”表示每两小时执行一次。同时正斜线可以和星号一起使用，例如*/10，如果用在minute字段，表示每十分钟执行一次。

8.接下来我们要创建一个shell脚本，里面存放一个清除buff / cache的命令，通过让crontab在什么时间去执行这个shell脚本，而实现定时清理的任务

```shell
# vim /home/automaticallyCleanUpMemory.sh
```

9.在文件中写入清理buff / cache的命令，推出保存

```shell
echo 3 > /proc/sys/vm/drop_caches
```

10.定时任务相关操作

```shell
# crontab -e // 创建一个定时任务
# crontab -l // 列出当前用户的定时任务
# crontab -r // 删除当前用户的定时任务
```

11.创建一个定时任务

```shell
# crontab -e
```

12.将什么时候执行什么任务写在任务中

```shell
0 4 * * * /home/automaticallyCleanUpMemory.sh
// 每天早上四点执行一次automaticallyCleanUpMemory.sh脚本
```

到这里我们的自动清理buff / cache内存的方法就介绍完了，接下来介绍一些相关的其他操作示例

示例：

```shell
* * * * * /home/automaticallyCleanUpMemory.sh 
// 每一分钟执行一次
10,15 * * * * /home/automaticallyCleanUpMemory.sh
// 每小时的第十分钟和第十五分钟执行一次
15 8 * * * /home/automaticallyCleanUpMemory.sh
// 每天早上八点十五执行一次
15 8 1 jan * /home/automaticallyCleanUpMemory.sh
// 一月一号的早上八点十五执行一次
0 6 * * 6 /home/automaticallyCleanUpMemory.sh
// 每个星期六的早上六点执行一次
```
