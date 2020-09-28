---
title: Centos6.9安装MySQL5.7，以及数据库迁移
date: 2018-03-05 15:07:13
updated: 2018-05-15 11:01:59
comments: true
categories:
- Linux
tags:
- Centos6.9
- MySQL5.7
- 数据库迁移
- scp
---

身为一名佛系程序员，在一个佛系公司上班，真是身不由己，一切随缘。这不因为公司没有运维我又干起了运维的活，这次主要是介绍一下如何在Centos6.9环境下安装MySQL5.7。这时候就有小伙伴问了，为什么要用Centos6.9不用7.4呢，说起来都是泪啊，公司没几个会的啊，我倒是想用7.4，泪奔。

（一）下载四个软件包到/home下（可以自己选择下载路径）

```shell
# wget http://mirrors.sohu.com/mysql/MySQL-5.7/mysql-community-client-5.7.18-1.el6.x86_64.rpm
# wget http://mirrors.sohu.com/mysql/MySQL-5.7/mysql-community-common-5.7.18-1.el6.x86_64.rpm
# wget http://mirrors.sohu.com/mysql/MySQL-5.7/mysql-community-libs-5.7.18-1.el6.x86_64.rpm
# wget http://mirrors.sohu.com/mysql/MySQL-5.7/mysql-community-server-5.7.18-1.el6.x86_64.rpm
```

（二）检查mysql rpm相关的包是否安装并去除

```shell
# rpm -qa | grep -i mysql
mysql-libs-5.1.73-8.el6_8.x86_64
# rpm -e mysql-libs-5.1.73-8.el6_8.x86_64
# yum remove -y mysql-libs // 删除依赖包
# rpm -qa | grep -i mysql // 在此查询如果没有信息显示则表示删除成功
```

（三）同时安装这四个rpm包

```shell
# rpm -ivh mysql-community-client-5.7.18-1.el6.x86_64.rpm mysql-community-common-5.7.18-1.el6.x86_64.rpm mysql-community-libs-5.7.18-1.el6.x86_64.rpm mysql-community-server-5.7.18-1.el6.x86_64.rpm
```

（四）如果安装时提示缺少依赖执行numactl的安装

```shell
# rpm -ivh mysql-community-client-5.7.18-1.el6.x86_64.rpm mysql-community-common-5.7.18-1.el6.x86_64.rpm mysql-community-libs-5.7.18-1.el6.x86_64.rpm mysql-community-server-5.7.18-1.el6.x86_64.rpm
warning: mysql-community-client-5.7.18-1.el6.x86_64.rpm: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY
error: Failed dependencies:
libnuma.so.1()(64bit) is needed by mysql-community-server-5.7.18-1.el6.x86_64
libnuma.so.1(libnuma_1.1)(64bit) is needed by mysql-community-server-5.7.18-1.el6.x86_64
libnuma.so.1(libnuma_1.2)(64bit) is needed by mysql-community-server-5.7.18-1.el6.x86_64
# yum install -y numactl
```

到这里，基本的安装就已经完成了，接下来我们要对数据库进行基本的设置，通过基本设置后我们会进行数据的迁移工作。

（一）首先停止掉MySQL的服务

```shell
# service mysqld stop
```

（二）跳过MySQL密码认证，在[mysqld]后面任意一行添加“skip-grant-tables”用来跳过密码验证的过程

```shell
# vim /etc/my.cnf
```

（三）重新启动MySQL服务

```shell
# service mysqld start
```

（四）重启后通过mysql命令即可进入到数据库中

```shell
# mysql
```

（五）使用sql修改数据库的密码

```shell
mysql> use mysql; // 使用这个数据库
mysql> update user set password=password("你的新密码") where user="root"; // 设置密码
mysql> flush privileges; // 立即生效
mysql> quit // 退出数据库
```

（六）去掉配置文件中的“skip-grant-tables”，并且重启MySQL服务

```shell
# service mysqld restart
```

在配置完数据库的基本设置后，就要进行数据库的数据搬迁，首先要准备两个数据库，我这里用的是公司的两台数据库服务器。

原有数据库服务器：10.2.8.123

新的数据库服务器：10.2.8.128

（一）在原有数据库服务器上操作，讲数据和表结构导出成sql文件

```shell
# mysqldump -uroot -p dbname > /home/dbname .sql // 导出数据和表结构
# mysqldump -uroot -p -d dbname > dbname .sql // 只导出表结构
```

（二）在新的数据库服务器上操作，讲原有服务器上备份的sql文件复制到新服务器上（注：如果没有配置ssh免密登录，在执行如下命令时会提示输入密码，如果想跳过此步骤，请参考<a href="http://120.79.151.66:4000/2018/02/28/linux%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B9%8B%E9%97%B4%E8%BF%9C%E7%A8%8B%E6%8B%B7%E8%B4%9D%E6%96%87%E4%BB%B6%E5%8F%8A%E6%96%87%E4%BB%B6%E5%A4%B9/">ssh免密登录</a>）

```shell
# scp root@10.2.8.123:/home/dbname.sql /home
```

（三）在新机器上导入拷贝过来的sql

```shell
mysql> create database dbname; // 创建数据库
mysql> use dbname; // 使用数据库
mysql> set names utf8; // 设置数据库编码格式
mysql> source /home/dbname.sql; // 把sql文件导入到数据库
```