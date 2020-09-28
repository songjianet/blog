---
title: Centos7升级内核
date: 2018-06-30 12:18:06
updated: 2018-06-30 15:06:51
comments: true
categories:
- Linux
tags:
- Centos7
---

内核主要有两种作用：

1.作为硬件和系统上运行的软件之间的接口；

2.尽可能地高效管理资源；

为此，内核通过内置的驱动程序或以后可作为模块安装的驱动程序与硬件通信。 

例如，当你计算机上运行的程序想要连接到无线网络时，它会将该请求提交给内核，后者又会使用正确的驱动程序连接到网络。 

随着新的设备和技术定期出来，如果我们想充分利用它们，保持最新的内核就很重要。此外，更新内核将帮助我们利用新的内核函数，并保护自己免受先前版本中发现的漏洞的攻击。 

<p style="color: red;">*这篇文章的方式支持发行版本种Centos7系统上进行操作</p>

##### 检查已安装的内核版本

当前我的系统内核版本为Linux 3.10.0-862.3.3.el7.x86_64

```shell
# uname -sr
```

![666](/blog/images/Centos7升级内核/666.png)

##### 在系统中启用ELRepo第三方库

```shell
# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
# rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
```

##### 列出可用的内核相关包 

```shell
# yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
```

##### 安装最新的主线稳定内核 

```shell
# yum --enablerepo=elrepo-kernel install kernel-ml
```

![1530331787(1)](/blog/images/Centos7升级内核/1530331787.jpg)

##### 设置默认内核版本

编辑/etc/default/grub 文件中的GRUB_DEFAULT 将值设置为0.意思是 GRUB 初始化页面的第一个内核将作为默认内核 

```shell
GRUB_TIMEOUT=5
GRUB_DEFAULT=0
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rd.lvm.lv=centos/root rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
```

![1530332090(1)](/blog/images/Centos7升级内核/1530332090.jpg)

##### 重新创建内核配置

```shell
# grub2-mkconfig -o /boot/grub2/grub.cfg
```

##### 重启系统

![1530332137(1)](/blog/images/Centos7升级内核/1530332137.jpg)

##### 重新查看内核版本为最新内核版本

```shell
# uname -sr
```
