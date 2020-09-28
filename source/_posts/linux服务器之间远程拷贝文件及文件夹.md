---
title: linux服务器之间远程拷贝文件及文件夹
date: 2018-02-28 10:16:13
updated: 2018-05-15 11:21:41
comments: true
categories:
- Linux
tags:
- scp
- ssh
---

本篇介绍一下关于linux服务器之间拷贝文件的方法，在实际生产环境中使用率还是很高的。因为我们不可能把文件从linux服务器上拷贝到主机，再把主机文件拷贝到另一台服务器上。这样操作不仅时间成本大大增加，而且工作效率还会大打折扣。

首先要使用远程拷贝文件，建议首先安装ssh免密钥登录，这样在后续的拷贝文件中，就不用再去输入密码了。常用的依赖ssh的命令有scp、sftp、openssh等

（一）ssh免密钥登录方法

```shell
# ssh-keygen // 生成私钥公钥对，一直输入回车即可
```

![生成私钥公钥对](/blog/images/linux服务器之间远程拷贝文件及文件夹/db9c2660786be447af615832e167ed6b.png)

```shell
# cat /root/.ssh/id_rsa.pub // 查看生成的公钥
```

![查看生成的公钥](/blog/images/linux服务器之间远程拷贝文件及文件夹/0fc598c8a5fd5342810132e322d32bee.png)

```shell
# ssh-copy-id -i ~/.ssh/id_rsa.pub 10.2.18.30 // 将公钥推送到远端服务器上，第一次需要验证密码
```

![将公钥推送到远端服务器上](/blog/images/linux服务器之间远程拷贝文件及文件夹/42ddefd9660658418a901b2a8b1fd2e7.png)

（二）scp拷贝文件及文件夹

```shell
# scp -r /home/test/ root@10.2.8.124:/root/ // 拷贝本机/home/test整个目录至远程主机10.2.8.124的/root目录下
# scp /home/test.txt root@10.2.8.124:/root/ // 拷贝单个文件至远程主机
# scp root@10.2.8.124:/home/a.txt /home // 从远程主机拷贝文件至本机
# scp -r root@10.2.8.124:/home/web /home // 从远程主机拷贝文件夹至本机
```
