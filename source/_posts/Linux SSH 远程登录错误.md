---
title: WARNING REMOTE HOST IDENTIFICATION HAS CHANGED
date: 2018-08-09 15:54:05
updated: 2018-08-09 15:54:05
comments: true
categories:
- Linux
tags:
- Linux
- shell
---

最近在终端远程一个Linux服务器的时候提示了“WARNING REMOTE HOST IDENTIFICATION HAS CHANGED”错误。

首先，出现这个错误的情况一般是192.168.1.9绑定a机器，但是因为a机器销毁了，ip被b机器占用后，导致本地系统的公钥还是a机器的公钥，所以在连接b机器的时候就会提示这个错误。

##### 解决办法

在系统的~路径下，进去.ssh文件夹删除known_hosts这个文件，之后重新连接远程即可

```shell
cd ~
rm -rf .ssh/known_hosts
```